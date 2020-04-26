<%-- 
    Document   : transferenciaRemota
    Created on : 25 abr. 2020, 20:09:39
    Author     : Kike
--%>

<%@page import="proyecto.modelo.Vinculacion"%>
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
                            List listaVinculadas = (List) request.getSession().getAttribute("cuentasVinculadas");
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

                        %>
                        <li><input type="submit" name= "btnLogOut" value="Cerrar sesión"></li>
                        </form>
                    </ul>
                </nav>
        </header>
        <form id="formulario" action="servicios" method="post" accept-charset="UTF-8">  
            <div id="content">
                <%     if (listaVinculadas != null && listaVinculadas.size() > 1) {
                        int numMovs = listaVinculadas.size();
                        out.print("<label>");
                        out.print("<table id='tablaVinculadas' class='tableC'>");
                        out.print("<caption>Lista Cuentas vinculadas");
                        out.print("<div class='divTras'>");
                        out.print("</div>");
                        out.print("</caption>");
                        out.print("</label><tr>");
                        out.print("<th style='text-align:left;'>Cuentas Propias</th>");
                        out.print("<th>Cuentas Vinculadas</th>");
                        out.print("</tr>");
                        for (int i = 0; i < numMovs; i++) {
                            Integer id = ((Vinculacion) listaVinculadas.get(i)).getId_c1();
                            Integer id_2 = ((Vinculacion) listaVinculadas.get(i)).getId_c2();
                            out.print("<tr>");
                            out.print("<td>" + id + "</td>");
                            out.print("<td>" + id_2 + "</td>");
                            out.print("</tr>");
                        }
                        out.print("</table>");
                %>
                <label>Cuenta origen: </label>
                <input type="number" id="transRem">
                <label>Cuenta destino: </label>
                <input type="number" id="transRem">
                <input type="submit" value="Transferir" name="btnTransRemota" id="botonTransferir">

                <%
                    } else if (listaMov != null && listaMov.size() == 1) {
                        out.print("<label>");
                        out.print("<table id='tablaVinculadas' class='tableC'>");
                        out.print("<caption>Lista Cuentas vinculadas");
                        out.print("<div class='divTras'>");
                        out.print("</div>");
                        out.print("</caption>");
                        out.print("</label><tr>");
                        out.print("<th style='text-align:left;'>Cuentas Propias</th>");
                        out.print("<th>Cuentas Vinculadas</th>");
                        out.print("</tr>");
                        Integer id = ((Vinculacion) listaVinculadas.get(0)).getId_c1();
                        Integer id_2 = ((Vinculacion) listaVinculadas.get(0)).getId_c2();
                        out.print("<tr>");
                        out.print("<td>" + id + "</td>");
                        out.print("<td>" + id_2 + "</td>");
                        out.print("</tr>");

                        out.print("</table>");
                        out.print("<label>Cuenta origen: </label>");
                        out.print("<input type='number' id='transRem' readonly='readonly' value='" + ((Vinculacion) listaVinculadas.get(0)).getId_c1() + "'>");
                        out.print("<label>Cuenta destino: </label>");
                        out.print("<input type='number' id='transRem'>");
                        out.print("<input type='submit' value='Transferir' name='btnTransRemota' id='botonTransferir'>");

                    } else {
                        out.print("<label>No hay cuentas vinculadas.</label>");
                    }
                %>

            </div>
            <%}%>
    </body>
</html>
