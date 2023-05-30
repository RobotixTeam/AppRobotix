<%@ page import="app.app.Conexion" %>
<%@ page import="java.sql.*" %>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
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
            String NumeroPC = null;
            String Lab = null;
            String Hora = null;
            String Alumno = null;

            NumeroPC = request.getParameter("NumeroPC");
            Lab = request.getParameter("Lab");
            Hora = request.getParameter("Hora");
            Alumno = request.getParameter("Alumno");

            if (NumeroPC != null && Lab != null && Hora != null && Alumno != null) {
                if (!NumeroPC.isEmpty() && !Lab.isEmpty() && !Hora.isEmpty() && !Alumno.isEmpty()) {
                    Connection connection = null;
                    PreparedStatement statement = null;

                    try {
                        // Establecer la conexión a la base de datos
                        Conexion msj = new Conexion();
                        connection = msj.conectar();

                        // Verificar si el número de PC ya existe en la base de datos
                        String checkQuery = "SELECT NumeroPC FROM computadoras WHERE NumeroPC = ?";
                        PreparedStatement checkStatement = connection.prepareStatement(checkQuery);
                        checkStatement.setInt(1, Integer.parseInt(NumeroPC));
                        ResultSet resultSet = checkStatement.executeQuery();

                        if (resultSet.next()) {
                            out.println("<script>");
                            out.println("alert('El número de PC ya existe. Por favor, ingrese otro número.');");
                            out.println("</script>");
                        } else {
                            // Preparar la consulta SQL para la inserción
                            String query = "INSERT INTO computadoras (NumeroPC, Lab, Hora, Alumno) VALUES (?, ?, ?, ?)";
                            statement = connection.prepareStatement(query);

                            // Establecer los parámetros de la consulta
                            statement.setInt(1, Integer.parseInt(NumeroPC));
                            statement.setString(2, Lab);
                            statement.setInt(3, Integer.parseInt(Hora));
                            statement.setString(4, Alumno);

                            // Ejecutar la consulta de inserción
                            statement.executeUpdate();

                            out.println("<script>");
                            out.println("alert('Datos dados de alta correctamente.');");
                            out.println("</script>");
                        }

                        resultSet.close();
                        checkStatement.close();
                    } catch (SQLException e) {
                        out.println("<script>");
                        out.println("console.log('Error al insertar los datos en la base de datos: " + e.getMessage() + "');");
                        out.println("</script>");
                    } finally {
                        // Cerrar la conexión y liberar los recursos
                        if (statement != null) {
                            statement.close();
                        }
                        connection.close();
                    }
                } else {
                    out.println("<script>");
                    out.println("alert('Por favor, llene todos los campos.');");
                    out.println("</script>");
                }
            }
        %>

        <a href="SesionAdministradores.jsp"><button class="botonA">Ir a Admins</button></a>
        <a href="SesionMaestro.jsp"><button class="botonA">Ir a Maestros</button></a>

        <form id="form1">
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
                        <td><input id="NumeroPC" name="NumeroPC" value="" type="number" /></td>
                        <td><input id="Lab" name="Lab" value="" type="text" /></td>
                        <td><input id="Hora" name="Hora" value="" type="number" /></td>
                        <td><input id="Alumno" name="Alumno" value="" type="text" /></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <input type="submit" class="botonA" id="Guardar" name="Guardar" value="Alta" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
</body>
</html>
