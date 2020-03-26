<%-- 
    Document   : sesion
    Created on : 22/03/2020, 11:05:47 PM
    Author     : frank
--%>

<%@page import="proyecto.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="stylesSesion.css" rel="stylesheet" type="text/css"/>
        <title>Inicio</title>
    </head>
    <body>
        <header><!--Titulo o logotipo y despues el menu-->
            <nav class="navBar"><!--Menu de navegacion-->
                <ul class="menu"><!--Lista-->
                    <li><a href="#">Apertura de Cuenta</a></li>
                    <li><a href="#">Depósito</a></li>
                    <li><a href="#">Retiro</a></li>
                    <li><a href="#">Transferencia en cajas</a></li>
                    <li><a href="#">Acreditación de intereses</a></li>
                    <li><a href="#">Consultas</a>
                        <ul class="submenu">
                            <li><a href="#">Consulta de cuenta</a></li>
                            <li><a href="#">Consulta de movimientos</a></li>
                        </ul>
                    </li>

                    <li><a href="#">Vinculación de cuentas</a></li>
                    <li><a href="#">Transferencia remota</a></li>
                </ul>
            </nav>   
        </header>
        <h1>SESION CORRECTA</h1>
        <%
            Usuario usr = (Usuario) request.getAttribute("usuario");
            String nombre = usr.getNombre();

        %>
        <h2>Bienvenido <%= nombre%></h2>


    </body>
</html>
