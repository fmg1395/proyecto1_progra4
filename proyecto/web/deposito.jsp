<%-- 
    Document   : deposito
    Created on : 29/03/2020, 04:57:22 PM
    Author     : frank
--%>

<%@page import="proyecto.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="stylesSesion.css" rel="stylesheet" type="text/css"/>
        <title>Deposito</title>
    </head>
    <body>
        <header><!--Titulo o logotipo y despues el menu-->
            <nav class="navBar"><!--Menu de navegacion-->
                <ul class="menu"><!--Lista-->
                    <%
                          String rol = (String)request.getSession().getAttribute("rol");
                                       
                          Usuario usr = (Usuario) request.getSession().getAttribute("cajero");
                          
                           out.println(usr.toString());
                        /* if(usr.getRol().equals("CAJ"))
                         {
                             out.println("<li><a href='#'>Apertura de Cuenta</a></li>");
                             out.println("<li><a href='#'>Retiro</a></li>");
                             out.println("<li><a href='#'>Depósito</a></li>");
                             out.println("<li><a href='#'>Transferencia en cajas</a></li>");
                             out.println("<li><a href='#'>Acreditación de intereses</a></li>");
                          }
                         else
                         {
                             out.println("<li><a href='#'>Consultas</a>");
                             out.println("<ul class='submenu'>");
                             out.println("<li><a href='#'>Consulta de cuenta</a></li>");
                             out.println("<li><a href='#'>Consulta de movimientos</a></li>");
                             out.println("</ul>");
                             out.println("</li>");
                             out.println("<li><a href='#'>Vinculación de cuentas</a></li>");
                             out.println("<li><a href='#'>Transferencia remota</a></li>");
                         }*/
                     %>
                     <li class="salir"><a href="index.jsp">Cerrar sesión</a></li>
                </ul>
            </nav>
        </header>
        <div id="content">
                         
        </div>
        <h1>Depositos</h1>
    </body>
</html>
