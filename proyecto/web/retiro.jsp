<%-- 
    Document   : retiro
    Created on : 29/03/2020, 04:57:22 PM
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
        <title>Retiro</title>
        <link  rel="icon"   href="img/bank.png" type="image/png" />

    </head>
    <body>
        <header><!--Titulo o logotipo y despues el menu-->
            <nav class="navBar"><!--Menu de navegacion-->
                <ul class="menu"><!--Lista-->
                    <%
                        String rol = (String) request.getSession().getAttribute("rol");
                        List lista = (List) request.getAttribute("cuentas");
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
                        if (rol.equals("CAJ")) {
                            out.println("<li><a href='aperturaCuenta.jsp'>Apertura de Cuenta</a></li>");
                            out.println("<li><a href='retiro.jsp'>Retiro</a></li>");
                            out.println("<li><a href='deposito.jsp'>Depósito</a></li>");
                            out.println("<li><a href='trasferencias.jsp'>Transferencia en cajas</a></li>");
                            out.println("<li><a href='acreditacionIntereses.jsp'>Acreditación de intereses</a></li>");
                        } else {
                            out.println("<li><a href='#'>Consultas</a>");
                            out.println("<ul class='submenu'>");
                            out.println("<li><a href='#'>Consulta de cuenta</a></li>");
                            out.println("<li><a href='#'>Consulta de movimientos</a></li>");
                            out.println("</ul>");
                            out.println("</li>");
                            out.println("<li><a href='vinculacion.jsp'>Vinculación de cuentas</a></li>");
                            out.println("<li><a href='transferencias.jsp'>Transferencia remota</a></li>");
                        }
                    %>
                    <li class="salir"><a href="index.jsp">Cerrar sesión</a></li>
                </ul>
            </nav>
        </header>
        <form id="buscarCuentas" name='form_retiro' action="servicios" method="post" accept-charset="UTF-8">
            <%
                request.getSession().setAttribute("formulario", "retiro");
            %>
            <div id='content'>
                <div id = 'Elección'>
                    <label>Retiro: <br> Buscar Cuenta: <br><br></label>
                    <div id='Yes'>
                        <input type='radio' id='ansY' name='drone2' value='yes'>
                        <label>Por cédula:</label>
                        <div class='reveal-if-active'>
                            <input type='text' name='txt_buscar' placeholder='Ingrese cédula'>
                            <input type='submit' name='btnBuscarPorCedula' value='Buscar'>
                        </div>
                    </div>
                    <div id='No'>
                        <input type='radio' id='ansN' name='drone2' value='no'>
                        <label>Por número de cuenta:</label>
                        <div class='reveal-if-active'>
                            <input type='text' name='txt_buscar2' placeholder='Ingrese número de cuenta'>
                            <input type='submit' name='btnBuscarPorCuenta' value='Buscar'>
                        </div>
                    </div>
                </div>

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
                        Usuario usr = (Usuario)request.getSession().getAttribute("usuario");
                        out.print("<br> Realizar Retiro: <br><br>");
                        out.print("Datos del Cliente: <br>");
                        out.print("<input type='text' size='30' name='text_name' placeholder='Ingrese nombre del Cliente'>");
                        out.print("<input type='text' size='25' name='text_id' placeholder='Ingrese ID del cliete'><br><br>");
                        out.print("Datos del deposito: <br>");
                        out.print("<input type = 'text' size='25' name='txtCuentaRetiro'  placeholder='Ingrese Número de Cuenta'>");
                        out.print("<input type = 'text' name='txtMonto'  placeholder='Monto a retirar'>");
                        out.print("<input type = 'text' name='txtDetalle'  placeholder='Ingrese el detalle'>");
                        out.print("<input type = 'submit' name='btnRetirar'  value='Retirar'>");

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
                        out.print("<br> Realizar Retiro: <br><br>");
                        out.print("Datos del cliente <br>");
                        out.print("<input type='text' size='30' name='text_name' placeholder='Ingrese nombre del Cliente'>");
                        out.print("<input type='text' size='25' name='text_id' placeholder='Ingrese ID del cliente'><br><br>");
                        out.print("Datos del retiro <br>");
                        out.print("<input type = 'text' size='25' name='txtCuentaRetiro'  placeholder='Ingrese Número de Cuenta'>");
                        out.print("<input type = 'text' name='txtMonto'  placeholder='Monto a retirar'>");
                        out.print("<input type = 'text' name='txtDetalle'  placeholder='Ingrese el detalle'>");
                        out.print("<input type = 'submit' name='btnRetirar'  value='Retirar'>");
                    }


                %>
            </div>
        </form>
            <%}%>
    </body>
</html>
