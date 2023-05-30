<%@ page import="app.app.Conexion" %>
<%@ page import="java.sql.*" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="StyleALCO.css">
</head>
<body>
<div class="containerPrincipalPC">
    <%
    String NumeroPC = request.getParameter("NumeroPC");

    if (NumeroPC != null && !NumeroPC.isEmpty()) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Establecer la conexión a la base de datos
            Conexion msj = new Conexion();
            connection = msj.conectar();

            // Obtener los datos correspondientes al NumeroPC
            String selectQuery = "SELECT * FROM computadoras WHERE NumeroPC = ?";
            statement = connection.prepareStatement(selectQuery);
            statement.setInt(1, Integer.parseInt(NumeroPC));
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Mostrar los datos en un formulario para editarlos
    %>
                <form method="post" action="">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>NumeroPC</th>
                                <th>Lab</th>
                                <th>Hora</th>
                                <th>Alumno</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input id="NumeroPC" name="NumeroPC" value="<%= resultSet.getInt("NumeroPC") %>" type="number" readonly /></td>
                                <td><input id="Lab" name="Lab" value="<%= resultSet.getString("Lab") %>" type="text" /></td>
                                <td><input id="Hora" name="Hora" value="<%= resultSet.getInt("Hora") %>" type="number" /></td>
                                <td><input id="Alumno" name="Alumno" value="<%= resultSet.getString("Alumno") %>" type="text" /></td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <input type="submit" class="botonA" name="action" value="Guardar Cambios" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
    <%
            } else {
                out.println("<script>");
                out.println("alert('El número de PC no existe en la base de datos.');");
                out.println("window.location.href='BajaAltasA.jsp';");
                out.println("</script>");
            }
        } catch (SQLException e) {
            out.println("<script>");
            out.println("console.log('Error al consultar los datos en la base de datos: " + e.getMessage() + "');");
            out.println("</script>");
        } finally {
            // Cerrar la conexión y liberar los recursos
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            connection.close();
        }
    } else {
        out.println("<script>");
        out.println("alert('Favor de proporcionar un número de PC válido.');");
        out.println("window.location.href='BajaAltasA.jsp';");
        out.println("</script>");
    }

    // Verificar si se ha enviado el formulario para actualizar los datos
    if (request.getMethod().equalsIgnoreCase("post")) {
        String Lab = request.getParameter("Lab");
        String Hora = request.getParameter("Hora");
        String Alumno = request.getParameter("Alumno");

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Establecer la conexión a la base de datos
            Conexion msj = new Conexion();
            connection = msj.conectar();

            // Actualizar los datos correspondientes al NumeroPC
            String updateQuery = "UPDATE computadoras SET Lab = ?, Hora = ?, Alumno = ? WHERE NumeroPC = ?";
            statement = connection.prepareStatement(updateQuery);
            statement.setString(1, Lab);
            statement.setInt(2, Integer.parseInt(Hora));
            statement.setString(3, Alumno);
            statement.setInt(4, Integer.parseInt(NumeroPC));
            statement.executeUpdate();

            out.println("<script>");
            out.println("alert('Los datos se han actualizado correctamente.');");
            out.println("window.location.href='BajaAltasA.jsp';");
            out.println("</script>");
        } catch (SQLException e) {
            out.println("<script>");
            out.println("console.log('Error al actualizar los datos en la base de datos: " + e.getMessage() + "');");
            out.println("</script>");
        } finally {
            // Cerrar la conexión y liberar los recursos
            if (statement != null) {
                statement.close();
            }
            connection.close();
        }
    }
    %>
</div>
</body>
</html>
