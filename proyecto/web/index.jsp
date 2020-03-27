<%-- 
    Document   : index
    Created on : 01/03/2020, 07:04:10 PM
    Author     : frank
--%>

<%@page import="proyecto.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Banco Islas Caiman</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="styles.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div id="wrapper">
            <header>
                <div id="Encabezado">
                    <p>
                        <b>Bienvenido al Banco Islas Caiman</b>
                    </p>
                </div>

                <%
                    Usuario usr = (Usuario)request.getAttribute("usuario");
                    String pass = "good";
                    String comprobar = (String)request.getAttribute("valid");
                    if(comprobar != null && comprobar.equals("wrong"))
                        pass = "wrong";
                        
                    if (usr == null && pass.equals("wrong")) {
                        out.println(" <div id='wrong'>");
                        out.println("<img class='errorIm' src='img/error.png' alt='imagen error'>");
                        out.println("<br>");
                        out.println("<label>Usuario o contraseña incorrecta.</label>");
                        out.println("<br>");
                        out.println("<label>Inténtelo nuevamente.</label>");
                        out.println("</div>");
                    }
                %>

                <div id="content">
                    <img class="avatar" src="img/logo.jpg" alt="logo Caiman">
                    <h1>Login here</h1>
                    <form id="formulario" action="servicios" method="post"
                          accept-charset="UTF-8">
                        <label for="Nombre de Usuario">Usuario</label>
                        <input type="text" id="logUsuario" name= "logUsuario" placeholder="Ingrese su usuario">

                        <label for="Contraseña">Contraseña</label>
                        <input type="password" id="logPass" name="logPass" placeholder="Ingrese su contraseña">

                        <input type="submit" value="Log in">
                        <!--Si es erroneo, debe recargar la página, esta vez con imprimir=true-->
                        <br>
                        <a href="#">He olvidado mi contraseña</a>
                        <br>
                        <a href="#">Crear usuario</a>

                        <table class="tablaFormulario">

                        </table>
                    </form>

                </div>
            </header>
        </div>

    </body>
</html>
