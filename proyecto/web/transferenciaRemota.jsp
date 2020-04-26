<%-- 
    Document   : transferenciaRemota
    Created on : 25 abr. 2020, 20:09:39
    Author     : Kike
--%>

<%@page import="proyecto.modelo.Usuario"%>
<%@page import="proyecto.modelo.Cuenta"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="stylesSesion.css" rel="stylesheet" type="text/css"/>
        <title>Transferencia Remota</title>
        <link  rel="icon"   href="img/bank.png" type="image/png" />
    </head>
    <body>
        <header>
            <form action="servicios" method="post"> 
                <nav class="navBar"><!--Menu de navegacion-->
                    <ul class="menu"><!--Lista-->
                        <a class="Encabezado">Bienvenido al Banco Islas Caiman</a>
                        <%
                            String rol = (String) request.getSession().getAttribute("rol");
                            List lista = (List) request.getAttribute("cuentas");
                            List listaMov = (List) request.getAttribute("movimientos");

                            String nombre = "";
                            String ced = "";
                            Integer numCuenta = 0;
                            if (lista != null) {
                                nombre = ((Cuenta) lista.get(0)).getUsuarios().getNombre();
                                ced = ((Cuenta) lista.get(0)).getUsuarios().getId();
                            }

                            Usuario usr = (Usuario) request.getSession().getAttribute("cajero");
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
                                    out.println("<li><a href='aperturaCuenta.jsp'>Apertura de Cuenta</a></li>");
                                    out.println("<li><a href='retiro.jsp'>Retiro</a></li>");
                                    out.println("<li><a href='deposito.jsp'>Depósito</a></li>");
                                    out.println("<li><a href='transferencias.jsp'>Transferencia en cajas</a></li>");
                                    out.println("<li><a href='acreditacionIntereses.jsp'>Acreditación de intereses</a></li>");
                                } else {
                                    out.println("<li><a href='consultaCuenta.jsp'>Consultas de Cuenta</a>");
                                    out.println("</li>");
                                    out.println("<li><a href='#'>Vinculación de cuentas</a></li>");
                                    out.println("<li><a href='#'>Transferencia remota</a></li>");
                                }
                            }
                        %>
                        <li><input type="submit" name= "btnLogOut" value="Cerrar sesión"></li>
                        </form>
                    </ul>
                </nav>
        </header>
        <form id="formulario" action="servicios" method="post" accept-charset="UTF-8">  
            <div id="content">
                
            </div>
    </body>
</html>
