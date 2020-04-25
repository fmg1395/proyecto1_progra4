<%-- 
    Document   : vinculacion
    Created on : 24/04/2020, 06:22:17 PM
    Author     : frank
--%>


<%@page import="proyecto.modelo.Cuenta"%>
<%@page import="java.util.List"%>
<%@page import="proyecto.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="stylesSesion.css" rel="stylesheet" type="text/css"/>
        <title>Vinculación de Cuentas</title>
        <link  rel="icon"   href="img/bank.png" type="image/png" />

    </head>
    <body>
        <header><!--Titulo o logotipo y despues el menu-->
            <nav class="navBar"><!--Menu de navegacion-->
                <ul class="menu"><!--Lista-->
                    <%
                        String rol = (String) request.getSession().getAttribute("rol");
                        List lista = (List) request.getSession().getAttribute("listaCuentas");
                        Cuenta cuenta = (Cuenta) request.getAttribute("individual");

                        String nombre = "";
                        if (lista != null) {
                            nombre = ((Cuenta) lista.get(0)).getUsuarios().getNombre();
                        }
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
                        if (rol.equals("CLI")) {
                            out.println("<li><a href='#'>Consultas</a>");
                            out.println("<ul class='submenu'>");
                            out.println("<li><a href='#'>Consulta de cuenta</a></li>");
                            out.println("<li><a href='#'>Consulta de movimientos</a></li>");
                            out.println("</ul>");
                            out.println("</li>");
                            out.println("<li><a href='vinculacion.jsp'>Vinculación de cuentas</a></li>");
                            out.println("<li><a href='#'>Transferencia remota</a></li>");
                        }
                    %>
                    <li class="salir"><a href="index.jsp">Cerrar sesión</a></li>
                </ul>
            </nav>
        </header>
        <form id="buscarCuentas" name='form_deposito' action="servicios" method="post" accept-charset="UTF-8">
            <%
                Usuario usr = (Usuario) request.getSession().getAttribute("usuario");
            %>
            <div id='content'>
                <div id = 'Lista_Cuentas'>
                    <label>Vincular Cuentas: <br><br></label>

                    <!-- Aqui va la tabla falta hacer logica-->
                    <%
                        if (lista != null && lista.size() > 1) {
                            int numCuentas = lista.size();
                            out.print("<label>");
                            out.print("<table id='tablaCuentas' class='table'>");
                            out.print("<caption> Cuentas Bancarias");
                            out.print("<div class='divTras'>");
                            out.print("<span style='font-size: small'>" + nombre + "</span>");
                            out.print("</div>");
                            out.print("</caption>");
                            out.print("</label><tr>");
                            out.print("<th style='text-align:left;'>Descripcion</th>");
                            out.print("<th>Número de Cuenta</th>");
                            out.print("<th>Saldo</th>");
                            out.print("</tr>");
                            for (int i = 0; i < numCuentas; i++) {
                                String descripcion = ((Cuenta) lista.get(i)).getMoneda().getId();
                                String nCuenta = String.valueOf(((Cuenta) lista.get(i)).getId());
                                String saldo = String.valueOf(((Cuenta) lista.get(i)).getMonto());
                                out.print("<tr>");
                                out.print("<td>" + descripcion + "</td>");
                                out.print("<td>" + nCuenta + "</td>");
                                out.print("<td>" + saldo + "</td>");
                                out.print("</tr>");
                            }
                            out.print("</table>");
                            out.print("<br><br>");
                            out.print("Datos de la cuenta a vincular <br>");
                            out.print("<br><br>");
                            out.print("<input type='text' size='30' name='text_cuenta_ori' placeholder='Ingrese su número de cuenta'>");
                            out.print("<input type='text' size='30' name='text_cuenta_des' placeholder='Ingrese cuenta a vincular'>");
                            out.print("<input type = 'submit' name='btnVinculacion'  value='Vincular'>");

                        } else if (lista != null && lista.size() == 1) {
                            out.print("<label>");
                            out.print("<table id='tablaCuentas' class='table'>");
                            out.print("<caption> Cuentas Bancarias");
                            out.print("<div class='divTras'>");
                            out.print("<span style='font-size: small'>" + nombre + "</span>");
                            out.print("</div>");
                            out.print("</caption>");
                            out.print("</label><tr>");
                            out.print("<th style='text-align:left;'>Descripcion</th>");
                            out.print("<th>Número de Cuenta</th>");
                            out.print("<th>Saldo</th>");
                            out.print("</tr>");

                            String descripcion = ((Cuenta) lista.get(0)).getMoneda().getId();
                            String nCuenta = String.valueOf(((Cuenta) lista.get(0)).getId());
                            String saldo = String.valueOf(((Cuenta) lista.get(0)).getMonto());

                            out.print("<tr>");
                            out.print("<td>" + descripcion + "</td>");
                            out.print("<td>" + nCuenta + "</td>");
                            out.print("<td>" + saldo + "</td>");
                            out.print("</tr>");
                            out.print("</table>");
                            out.print("<br><br>");
                            out.print("Datos de la cuenta a vincular <br>");
                            out.print("<br><br>");
                            out.print("<input type='text' size='30' name='text_cuenta_ori' placeholder='Ingrese su número de cuenta'>");
                            out.print("<input type='text' size='30' name='text_cuenta_des' placeholder='Ingrese cuenta a vincular'>");
                            out.print("<input type = 'submit' name='btnVinculacion'  value='Vincular'>");
                        }

                    %>
                </div>
        </form>
        <%}%>
    </body>
</html>