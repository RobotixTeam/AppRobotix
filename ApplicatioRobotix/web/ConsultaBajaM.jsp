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

                // Obtener el valor del parámetro "action"
                String action = request.getParameter("action");
                if (action != null) {
            
                    if (action.equals("Consultar")) {
                        if (NumeroPC != null && !NumeroPC.isEmpty()) {
        if (Lab.isEmpty() && Hora.isEmpty() && Alumno.isEmpty()) {
            Connection connection = null;
            PreparedStatement statement = null;

            try {
                // Establecer la conexión a la base de datos
                Conexion msj = new Conexion();
                connection = msj.conectar();

                // Verificar si el número de PC existe en la base de datos
                String checkQuery = "SELECT NumeroPC, Lab, Hora, Alumno FROM computadoras WHERE NumeroPC = ?";
                PreparedStatement checkStatement = connection.prepareStatement(checkQuery);
                checkStatement.setInt(1, Integer.parseInt(NumeroPC));
                ResultSet resultSet = checkStatement.executeQuery();

                if (resultSet.next()) {
                    // Mostrar los datos en la tabla
                    out.println("<table border='1'>");
                    out.println("<thead>");
                    out.println("<tr>");
                    out.println("<th>NumeroPC</th>");
                    out.println("<th>Lab</th>");
                    out.println("<th>Hora</th>");
                    out.println("<th>Alumno</th>");
                    out.println("</tr>");
                    out.println("</thead>");
                    out.println("<tbody>");
                    out.println("<tr>");
                    out.println("<td>" + resultSet.getInt("NumeroPC") + "</td>");
                    out.println("<td>" + resultSet.getString("Lab") + "</td>");
                    out.println("<td>" + resultSet.getInt("Hora") + "</td>");
                    out.println("<td>" + resultSet.getString("Alumno") + "</td>");
                    out.println("</tr>");
                    out.println("</tbody>");
                    out.println("</table><br>");

                    // Cambiar el texto del botón a "Limpiar Consulta" y mantener los datos en la tabla
                    out.println("<form method='post' action=''>");
                    out.println("<input type='hidden' name='NumeroPC' value='" + NumeroPC + "' />");
                    out.println("<input type='hidden' name='Lab' value='" + resultSet.getString("Lab") + "' />");
                    out.println("<input type='hidden' name='Hora' value='" + resultSet.getInt("Hora") + "' />");
                    out.println("<input type='hidden' name='Alumno' value='" + resultSet.getString("Alumno") + "' />");
                    out.println("<input type='submit' class='botonA' name='action' value='Limpiar Consulta' />");
                    out.println("<br><br></form>");
                } else {
                    out.println("<script>");
                    out.println("alert('El número de PC no existe en la base de datos.');");
                    out.println("</script>");
                }

                resultSet.close();
                checkStatement.close();
            } catch (SQLException e) {
                out.println("<script>");
                out.println("console.log('Error al consultar los datos en la base de datos: " + e.getMessage() + "');");
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
            out.println("alert('Favor de solo ingresar el número de PC.');");
            out.println("</script>");
        }
    } else {
        out.println("<script>");
        out.println("alert('Favor de ingresar el número de PC.');");
        out.println("</script>");
    }
                    
                    } else if (action.equals("Eliminar")) {
                        if (NumeroPC != null && !NumeroPC.isEmpty()) {
                            if(Lab.isEmpty() && Hora.isEmpty() && Alumno.isEmpty()){
            Connection connection = null;
            PreparedStatement statement = null;

            try {
                // Establecer la conexión a la base de datos
                Conexion msj = new Conexion();
                connection = msj.conectar();

                // Verificar si el número de PC existe en la base de datos
                String checkQuery = "SELECT NumeroPC, Lab, Hora, Alumno FROM computadoras WHERE NumeroPC = ?";
                PreparedStatement checkStatement = connection.prepareStatement(checkQuery);
                checkStatement.setInt(1, Integer.parseInt(NumeroPC));
                ResultSet resultSet = checkStatement.executeQuery();

                if (resultSet.next()) {
                    // Mostrar los datos en una tabla para confirmar la eliminación
                    out.println("<table border='1'>");
                    out.println("<thead>");
                    out.println("<tr>");
                    out.println("<th>NumeroPC</th>");
                    out.println("<th>Lab</th>");
                    out.println("<th>Hora</th>");
                    out.println("<th>Alumno</th>");
                    out.println("</tr>");
                    out.println("</thead>");
                    out.println("<tbody>");
                    out.println("<tr>");
                    out.println("<td>" + resultSet.getInt("NumeroPC") + "</td>");
                    out.println("<td>" + resultSet.getString("Lab") + "</td>");
                    out.println("<td>" + resultSet.getInt("Hora") + "</td>");
                    out.println("<td>" + resultSet.getString("Alumno") + "</td>");
                    out.println("</tr>");
                    out.println("</tbody>");
                    out.println("</table><br>");

                    // Agregar otro botón para eliminar los datos
                    out.println("<form method='post' action=''>");
                    out.println("<input type='hidden' name='NumeroPC' value='" + NumeroPC + "' />");
                    out.println("<input type='submit' class='botonA' name='action' value='Confirmar Eliminación' />");
                    out.println("<br><br></form>");
                } else {
                    out.println("<script>");
                    out.println("alert('El número de PC no existe en la base de datos.');");
                    out.println("</script>");
                }

                resultSet.close();
                checkStatement.close();
            } catch (SQLException e) {
                out.println("<script>");
                out.println("console.log('Error al consultar los datos en la base de datos: " + e.getMessage() + "');");
                out.println("</script>");
            } finally {
                // Cerrar la conexión y liberar los recursos
                if (statement != null) {
                    statement.close();
                }
                connection.close();
            }
                }else{
                out.println("<script>");
                out.println("alert('Favor de solo ingresar el numero de PC');");
                out.println("</script>");
                }
        } else {
            out.println("<script>");
            out.println("alert('Favor de ingresar el numero de PC');");
            out.println("</script>");
        }
                    
                    } else if (action.equals("Confirmar Eliminación")) {
        if (NumeroPC != null && !NumeroPC.isEmpty()) {
            Connection connection = null;
            PreparedStatement statement = null;

            try {
                // Establecer la conexión a la base de datos
                Conexion msj = new Conexion();
                connection = msj.conectar();

                // Eliminar los datos correspondientes al número de PC
                String deleteQuery = "DELETE FROM computadoras WHERE NumeroPC = ?";
                statement = connection.prepareStatement(deleteQuery);
                statement.setInt(1, Integer.parseInt(NumeroPC));
                statement.executeUpdate();

                out.println("<script>");
                out.println("alert('Los datos han sido eliminados correctamente.');");
                out.println("</script>");
            } catch (SQLException e) {
                out.println("<script>");
                out.println("console.log('Error al eliminar los datos de la base de datos: " + e.getMessage() + "');");
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
            out.println("alert('Por favor, ingrese solo el número de PC para eliminar.');");
            out.println("</script>");
        }
    }
                }
            %>

            <a href="SesionAlumno.jsp"><button class="botonA">Ir a Alumnos</button></a>
            <a href="SesionMaestro.jsp"><button class="botonA">Ir a Maestros</button></a>

            <form id="form1" method="post" action="">
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
                                <button class="botonA" name="action" value="Eliminar">Eliminar</button>
                                <button class="botonA" name="action" value="Consultar">Consultar</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </body>
</html>
