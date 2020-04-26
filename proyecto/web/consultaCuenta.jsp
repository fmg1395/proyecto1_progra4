<%-- 
    Document   : consultaCuenta
    Created on : 24 abr. 2020, 17:02:15
    Author     : Kike
--%>

<%@page import="proyecto.modelo.Movimientos"%>
<%@page import="proyecto.modelo.Usuario"%>
<%@page import="proyecto.modelo.Cuenta"%>
<%@page import="proyecto.modelo.Cuenta"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="stylesSesion.css" rel="stylesheet" type="text/css"/>
        <title>Apertura de Cuenta</title>
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
                                out.println("<li><a href='transferenciaRemota.jsp'>Transferencia remota</a></li>");
                            }
                        %>
                        <li><input type="submit" name= "btnLogOut" value="Cerrar sesión"></li>
                        </form>
                    </ul>
                </nav>
        </header>   
        <form id="formulario" action="servicios" method="post" accept-charset="UTF-8">  
            <div id="content">
                <%if (listaMov == null) {%>
                <input class="buscarC" type = "submit" name="btnListar" value=" buscar ">
                <%}
                    if (listaMov != null && listaMov.size() > 1) {
                        int numMovs = listaMov.size();
                        out.print("<label>");
                        out.print("<table id='tablaMovimientos' class='tableC'>");
                        out.print("<caption>Lista de Movimientos");
                        out.print("<div class='divTras'>");
                        out.print("</div>");
                        out.print("</caption>");
                        out.print("</label><tr>");
                        out.print("<th style='text-align:left;'>Id</th>");
                        out.print("<th>Fecha</th>");
                        out.print("<th>Monto</th>");
                        out.print("<th>Detalle</th>");
                        out.print("</tr>");
                        for (int i = 0; i < numMovs; i++) {
                            Integer id = ((Movimientos) listaMov.get(i)).getId();
                            String fecha = String.valueOf(((Movimientos) listaMov.get(i)).getFecha());
                            Integer monto = (int) ((Movimientos) listaMov.get(i)).getMonto();
                            String detalle = String.valueOf(((Movimientos) listaMov.get(i)).getDetalle());
                            out.print("<tr>");
                            out.print("<td>" + id + "</td>");
                            out.print("<td>" + fecha + "</td>");
                            out.print("<td>" + monto + "</td>");
                            out.print("<td>" + detalle + "</td>");
                            out.print("</tr>");
                        }
                        out.print("</table>");
                        out.print("<input class='volver' type = 'submit' name='btnVolverConsulta' value='regresar'>");

                    } else if (listaMov != null && listaMov.size() == 1) {
                        out.print("<label>");
                        out.print("<table id='tablaMovimientos class='tableC'>");
                        out.print("<caption>Movimientos");
                        out.print("<div class='divTras'>");
                        out.print("<span style='font-size: small'>" + nombre + " Cuenta: " + numCuenta + "</span>");
                        out.print("</div>");
                        out.print("</caption>");
                        out.print("</label><tr>");
                        out.print("<th style='text-align:left;'>Id</th>");
                        out.print("<th>Fecha</th>");
                        out.print("<th>Monto</th>");
                        out.print("<th>Detalle</th>");
                        out.print("</tr>");
                        Integer id = ((Movimientos) lista.get(0)).getId();
                        String fecha = String.valueOf(((Movimientos) listaMov.get(0)).getFecha());
                        Integer monto = (int) ((Movimientos) listaMov.get(0)).getMonto();
                        String detalle = String.valueOf(((Movimientos) listaMov.get(0)).getDetalle());
                        out.print("<tr>");
                        out.print("<td>" + id + "</td>");
                        out.print("<td>" + fecha + "</td>");
                        out.print("<td>" + monto + "</td>");
                        out.print("<td>" + detalle + "</td>");
                        out.print("</tr>");
                        out.print("</table>");
                        out.print("<input class='buscar' type = 'submit' name='btnListarMov' value='regresar'>");

                    } else {
                        if (lista != null && lista.size() > 1) {
                            int numCuentas = lista.size();
                            out.print("<label>");
                            out.print("<table id='tablaCuentas' class='tableC'>");
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
                            out.print(" <label for='CuentaMov'>Cuenta por mostrar movimientos:</label>");
                            out.print("<input type='number' id='cuentaExistente' name='numCuenta' placeholder='Ingrese cuenta'>");
                            out.print("<input class='buscar' type = 'submit' name='btnListarMov' value='buscar'>");
                        } else if (lista != null && lista.size() == 1) {
                            out.print("<label>");
                            out.print("<table id='tablaCuentas' class='tableC'>");
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
                            out.print(" <label for='CuentaMov'>Cuenta por mostrar movimientos:</label>");
                            out.print("<input type='number' id='cuentaExistente' name='numCuenta' placeholder='Ingrese cuenta'>");
                            out.print("<input class='buscar' type = 'submit' name='btnListarMov' value='buscar'>");

                        }
                    }
                %>
            </div>
            <%}%>
    </body>
</html>
