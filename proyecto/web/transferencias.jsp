<%-- 
    Document   : transferencias
    Created on : 11/04/2020, 09:32:05 PM
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
        <title>Transferencias</title>
    </head>
    <body>
        <form id="buscarCuentas" name='form_transferencias' action="servicios" method="post" accept-charset="UTF-8">
            <header><!--Titulo o logotipo y despues el menu-->
                <nav class="navBar"><!--Menu de navegacion-->
                    <ul class="menu"><!--Lista-->
                        <%
                            String rol = (String) request.getSession().getAttribute("rol");
                            List cuentas1 = (List) request.getAttribute("cuentas");
                            //Falta acomodar
                            List listaDestino = (List) request.getAttribute("");
                            Cuenta cuenta = (Cuenta) request.getAttribute("individual");

                            String nombre = "";
                            if (cuentas1 != null) {
                                nombre = ((Cuenta) cuentas1.get(0)).getUsuarios().getNombre();
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
                                out.println("<li><a href='transferencias.jsp'>Transferencia en cajas</a></li>");
                                out.println("<li><a href='acreditacionIntereses.jsp'>Acreditación de intereses</a></li>");
                            } else {
                               out.println("<li><a href='consultaCuenta.jsp'>Consultas de Cuenta</a>");
                                out.println("</li>");
                                out.println("<li><a href='#'>Vinculación de cuentas</a></li>");
                                out.println("<li><a href='transferenciaRemota.jsp'>Transferencia remota</a></li>");
                            }
                        %>
                        <li class="salir"><a href="index.jsp">Cerrar sesión</a></li>
                    </ul>
                </nav>
            </header>
            <%
                request.getSession().setAttribute("formulario", "deposito");
            %>
            <div id='content'>
                <div id = 'Elección'>
                    <label>Transferencias: <br> Buscar Cuenta Origen: <br><br></label>
                    <div id='Yes'>
                        <input type='radio' id='ansY' name='drone2' value='yes'>
                        <label>Por cédula:</label>
                        <div class='reveal-if-active'>
                            <input type='text' name='txt_buscar' placeholder='Ingrese cédula'>
                            <input type='submit' name='btnBuscarPorCedula1' value='Buscar'>
                        </div>
                    </div>
                    <div id='No'>
                        <input type='radio' id='ansN' name='drone2' value='no'>
                        <label>Por número de cuenta:</label>
                        <div class='reveal-if-active'>
                            <input type='text' name='txt_buscar2' placeholder='Ingrese número de cuenta'>
                            <input type='submit' name='btnBuscarPorCuenta1' value='Buscar'>
                        </div>
                    </div>
                </div>
                <div id = 'Elección2'>
                    <label>Buscar Cuenta Destino <br><br></label>
                    <div id='Yes'>
                        <input type='radio' id='ansY' name='drone3' value='yes'>
                        <label>Por cédula:</label>
                        <div class='reveal-if-active'>
                            <input type='text' name='txt_buscar' placeholder='Ingrese cédula'>
                            <input type='submit' name='btnBuscarPorCedula2' value='Buscar'>
                        </div>
                    </div>
                    <div id='No'>
                        <input type='radio' id='ansN' name='drone3' value='no'>
                        <label>Por número de cuenta:</label>
                        <div class='reveal-if-active'>
                            <input type='text' name='txt_buscar2' placeholder='Ingrese número de cuenta'>
                            <input type='submit' name='btnBuscarPorCuenta2' value='Buscar'>
                        </div>
                    </div>
                </div>
                <div>
                    <%
                        if (cuentas1 != null && cuentas1.size() > 1) {
                            int numCuentas = cuentas1.size();
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
                                String descripcion = ((Cuenta) cuentas1.get(i)).getMoneda().getId();
                                String nCuenta = String.valueOf(((Cuenta) cuentas1.get(i)).getId());
                                String saldo = String.valueOf(((Cuenta) cuentas1.get(i)).getMonto());
                                out.print("<tr>");
                                out.print("<td>" + descripcion + "</td>");
                                out.print("<td>" + nCuenta + "</td>");
                                out.print("<td>" + saldo + "</td>");
                                out.print("</tr>");
                            }
                            out.print("</table>");
                            out.print("<br> Realizar Deposito: <br><br>");
                            out.print("Datos del depositante: <br>");
                            out.print("<input type='text' size='30' name='text_name' placeholder='Ingrese nombre del depositante'>");
                            out.print("<input type='text' size='25' name='text_id' placeholder='Ingrese ID del depositante'><br><br>");
                            out.print("Datos del deposito: <br>");
                            out.print("<input type = 'text' size='25' name='txtCuentaDeposito'  placeholder='Ingrese Número de Cuenta'>");
                            out.print("<input type = 'text' name='txtMonto'  placeholder='Monto a depositar'>");
                            out.print("<input type = 'text' name='txtDetalle'  placeholder='Ingrese el detalle'>");
                            out.print("<input type = 'submit' name='btnDepositar'  value='Depositar'>");

                        } else if (cuentas1 != null && cuentas1.size() == 1) {
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

                            String descripcion = ((Cuenta) cuentas1.get(0)).getMoneda().getId();
                            String nCuenta = String.valueOf(((Cuenta) cuentas1.get(0)).getId());
                            String saldo = String.valueOf(((Cuenta) cuentas1.get(0)).getMonto());

                            out.print("<tr>");
                            out.print("<td>" + descripcion + "</td>");
                            out.print("<td>" + nCuenta + "</td>");
                            out.print("<td>" + saldo + "</td>");
                            out.print("</tr>");
                            out.print("</table>");
                            out.print("<br> Realizar Deposito: <br><br>");
                            out.print("Datos del depositante: <br>");
                            out.print("<input type='text' size='30' name='text_name' placeholder='Ingrese nombre del depositante'>");
                            out.print("<input type='text' size='25' name='text_id' placeholder='Ingrese ID del depositante'><br><br>");
                            out.print("Datos del deposito: <br>");
                            out.print("<input type = 'text' size='25' name='txtCuentaDeposito'  placeholder='Ingrese Número de Cuenta'>");
                            out.print("<input type = 'text' name='txtMonto'  placeholder='Monto a depositar'>");
                            out.print("<input type = 'text' name='txtDetalle'  placeholder='Ingrese el detalle'>");
                            out.print("<input type = 'submit' name='btnDepositar'  value='Depositar'>");
                        }

                    %>
                </div>
            </div>
        </form>
        <%}%>
    </body>
</html>
