<%-- 
    Document   : index
    Created on : 01/03/2020, 07:04:10 PM
    Author     : frank
--%>

<%@page import="proyecto.modelo.Modelo"%>
<%@page import="proyecto.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Banco Islas Caiman</title>
        <%
           Modelo.cont=Modelo.cantidadCuentas();
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="styles.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div id="wrapper">
                <div id="Encabezado">
                    <p>
                        <b>Bienvenido al Banco Islas Caiman</b>
                        <%
                            out.println("<b> "+Modelo.cont+"</b>");
                        %>
                    </p>
                </div>

                <%
                    String rol = (String) request.getSession().getAttribute("rol");
                    Boolean error = (Boolean)request.getAttribute("validacion");
                    Usuario usr = null;
                    
                    if(rol!=null && rol.equals("CLI"))
                        usr = (Usuario)request.getSession().getAttribute("usuario");
                    if(rol!=null)
                        usr = (Usuario)request.getSession().getAttribute("cajero");
                         
                    if (error!=null && error==false) {
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
                    <h1>Ingrese aquí</h1>
                    <form id="formulario" action="servicios" method="post"
                          accept-charset="UTF-8">
                        <label for="Nombre de Usuario">Usuario</label>
                        <input type="text" id="logUsuario" name= "logUsuario" placeholder="Ingrese su usuario">

                        <label for="Contraseña">Contraseña</label>
                        <input type="password" id="logPass" name="logPass" placeholder="Ingrese su contraseña">

                        <input type="submit" name= "btnLogIn" value="Ingresar">
                        <!--Si es erroneo, debe recargar la página, esta vez con imprimir=true-->
                        <br>
                        <a href="#">He olvidado mi contraseña</a>
                        <br>
                        <a href="#">Crear usuario</a>

                        <table class="tablaFormulario">

                        </table>
                    </form>

                </div>
        </div>

    </body>
</html>
