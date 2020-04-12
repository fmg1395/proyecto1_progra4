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

                    <%
                          String rol = (String)request.getSession().getAttribute("rol");
                          
                          Usuario usr = null;
                         if(rol.equals("CAJ"))
                         {
                             usr = (Usuario) request.getSession().getAttribute("cajero");
                             out.println("<li><a href='aperturaCuenta.jsp'>Apertura de Cuenta</a></li>");
                             out.println("<li><a href='retiro.jsp'>Retiro</a></li>");
                             out.println("<li><a href='deposito.jsp'>Depósito</a></li>");
                             out.println("<li><a href='transferencias.jsp'>Transferencia en cajas</a></li>");
                             out.println("<li><a href='#'>Acreditación de intereses</a></li>");
                          }
                         else if(rol.equals("CLI"))
                         {
                             usr = (Usuario) request.getSession().getAttribute("usuario");
                             out.println("<li><a href='#'>Consultas</a>");
                             out.println("<ul class='submenu'>");
                             out.println("<li><a href='#'>Consulta de cuenta</a></li>");
                             out.println("<li><a href='#'>Consulta de movimientos</a></li>");
                             out.println("</ul>");
                             out.println("</li>");
                             out.println("<li><a href='#'>Vinculación de cuentas</a></li>");
                             out.println("<li><a href='#'>Transferencia remota</a></li>");
                             out.println("");
                         }
                     %>
                     <li class="salir"><a href="index.jsp">Cerrar sesión</a></li>
                </ul>
            </nav>   
        </header>
    </body>
</html>
