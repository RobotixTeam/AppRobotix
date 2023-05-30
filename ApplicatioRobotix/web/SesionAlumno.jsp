<%@page import="app.app.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String mensaje = "";
    
    if (request.getMethod().equalsIgnoreCase("post")) {
        // Obtén los valores ingresados por el usuario desde los campos del formulario
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            // Crea una instancia de la clase de conexión a la base de datos
            Conexion conexion = new Conexion();
            Connection cn = conexion.conectar();

            // Prepara la sentencia SQL para verificar las credenciales de inicio de sesión
            String query = "SELECT * FROM alumnos WHERE nombreAl = ? AND contraseñaAl = ?";
            PreparedStatement pst = cn.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password);

            // Ejecuta la consulta en la base de datos
            ResultSet rs = pst.executeQuery();

            // Verifica si se encontraron resultados en la consulta
            if (rs.next()) {
                // Inicio de sesión exitoso
                mensaje = "Inicio de sesión exitoso. Redireccionando...";
                response.sendRedirect("AltasComputadorasA.jsp");
                
            } else {
                // Inicio de sesión fallido
                mensaje = "Nombre de usuario o contraseña incorrectos.";
            }

            // Cierra los recursos
            rs.close();
            pst.close();
            cn.close();
        } else {
            mensaje = "Por favor, ingresa el nombre de usuario y contraseña.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>JSP Page</title>
  <link rel="stylesheet" href="StyleSEAL.css">
</head>
<body>
<div class="container fade-in">
    <h1>Iniciar Sesión</h1>

    <form id="loginForm" method="post">
        <label for="username">Usuario</label>
        <input type="text" id="username" name="username" placeholder="Ingresa tu usuario" required>
        <label for="password">Contraseña</label>
        <input type="password" id="password" name="password" placeholder="Ingresa tu contraseña" required>
        <button id="boton" class="boton">Iniciar Sesión</button>
        <button id="boton2" class="boton2" onclick="registroAl()">Registro</button>
    </form>
    <p><%= mensaje %></p>
</div>

<div class="background"></div>

<script>
    function registroAl() {
        window.location.href = "RegistroAlumno.jsp";
    }
</script>
</body>
</html>
