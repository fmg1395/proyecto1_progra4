<%-- 
    Document   : index
    Created on : 01/03/2020, 07:04:10 PM
    Author     : frank
--%>

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
                <div id="wrong">
                    <img class="errorIm" src="img/error.png" alt="imagen error">
                    <br>
                    <label>Usuario o contraseña incorrecta.</label>
                    <br>
                    <label>Intentelo nuevamente.</label>
                </div>
                <div id="triangle"></div>
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

                        <input type="submit" value="Log in">
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
