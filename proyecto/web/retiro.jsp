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
        <title>Deposito</title>
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
                        String nombre = "";
                        if (lista != null) {
                            nombre = ((Cuenta) lista.get(0)).getUsuarios().getNombre();
                        }
                        if (rol.equals("CAJ")) {
                            out.println("<li><a href='aperturaCuenta.jsp'>Apertura de Cuenta</a></li>");
                            out.println("<li><a href='retiro.jsp'>Retiro</a></li>");
                            out.println("<li><a href='deposito.jsp'>Depósito</a></li>");
                            out.println("<li><a href='#'>Transferencia en cajas</a></li>");
                            out.println("<li><a href='acreditacionIntereses.jsp'>Acreditación de intereses</a></li>");
                        } else {
                            out.println("<li><a href='#'>Consultas</a>");
                            out.println("<ul class='submenu'>");
                            out.println("<li><a href='#'>Consulta de cuenta</a></li>");
                            out.println("<li><a href='#'>Consulta de movimientos</a></li>");
                            out.println("</ul>");
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
        <form id="buscarCuentas" action="servicios" method="post" accept-charset="UTF-8">
            <div id="content">
                <label>
                    Retiro
                    <br>
                    Buscar Cuenta:
                    <input type="text" name="txtCuenta" size="30" placeholder="ingrese cuenta del cliente">
                    <input type = "submit" name="btnCuentaRetiro"  value=" buscar ">
                    <br>
                    <br>
                </label> 
                <%
                    if(lista!=null)
                    {
                        int numCuentas=lista.size();
                        out.print("<label>");
                        out.print("<table id='tablaCuentas' class='table'>");
                        out.print("<caption> Cuentas Bancarias");
                        out.print("<div class='divTras'>");
                        out.print("<span style='font-size: small'>"+nombre+"</span>");
                        out.print("</div>");
                        out.print("</caption>");
                        out.print("</label><tr>");
                        out.print("<th style='text-align:left;'>Descripcion</th>");
                        out.print("<th>Número de Cuenta</th>");
                        out.print("<th>Saldo</th>");
                        out.print("</tr>");
                        for(int i = 0; i < numCuentas; i++) 
                        {
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
                        
                        out.print("<br> Realizar Retiro <br>"
                                + "<input type = 'text' size='25' name='txtCuentaDeposito'  placeholder='Ingrese Número de Cuenta'>");
                        out.print("<input type = 'text' name='txtMonto'  placeholder='Monto a retirar'>");
                        out.print("<input type = 'submit' name='btnDepositar'  value='Depositar'>");
                    }
                //Falta elegir cuenta para hacer el update
                             
                %>
            </div>  
        </form>
    </body>
</html>
