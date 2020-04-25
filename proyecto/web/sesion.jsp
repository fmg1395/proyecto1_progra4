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
        <link  rel="icon"   href="img/bank.png" type="image/png" />
    </head>
    <body>
        <header>                    
            <form action="servicios" method="post">
                <nav class="navBar">  <!--Menu de navegacion-->
                    <ul class="menu"><!--Lista-->
                        <a class="Encabezado">Bienvenido al Banco Islas Caiman</a>
                        <%
                            String rol = (String) request.getSession().getAttribute("rol");

                            Usuario usr = null;
                            if (rol == null) {
                        %>
                        <div id="realized">
                            <h2>ACCESO DENEGADO</h2>
                            <div id="url">
                                <input type="submit" name= "btnLogOut" value="Volver al inicio"> 
                            </div>
                        </div>
                        <%
                        } else {

                            if (rol.equals("CAJ")) {
                                usr = (Usuario) request.getSession().getAttribute("cajero");
                                out.println("<li><a href='aperturaCuenta.jsp'>Apertura de Cuenta</a></li>");
                                out.println("<li><a href='retiro.jsp'>Retiro</a></li>");
                                out.println("<li><a href='deposito.jsp'>Depósito</a></li>");
                                out.println("<li><a href='#'>Transferencia en cajas</a></li>");
                                out.println("<li><a href='acreditacionIntereses.jsp'>Acreditación de intereses</a></li>");
                            } else if (rol.equals("CLI")) {
                                usr = (Usuario) request.getSession().getAttribute("usuario");
                                out.println("<li><a href='consultaCuenta.jsp'>Consultas de Cuenta</a>");
                                out.println("</li>");
                                out.println("<li><a href='#'>Vinculación de cuentas</a></li>");
                                out.println("<li><a href='#'>Transferencia remota</a></li>");
                            }

                        %>
                        <li><input type="submit" name= "btnLogOut" value="Cerrar sesión"></li>
                        </form>
                    </ul>
                </nav>   
        </header>
        <%}%>
    </body>
</html>
