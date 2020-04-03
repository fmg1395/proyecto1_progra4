<%-- 
    Document   : deposito
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
        <header><!--Titulo o logotipo y despues el menu-->
            <nav class="navBar"><!--Menu de navegacion-->
                <ul class="menu"><!--Lista-->
                    <%
                        String rol = (String) request.getSession().getAttribute("rol");
                        List lista = (List) request.getAttribute("cuentas");
                        String nombre = "";
                        if (lista != null) {
                            nombre = ((Cuenta) lista.get(0)).getUsuarios().getNombre();
                        }
                        if (rol.equals("CAJ")) {
                            out.println("<li><a href='aperturaCuenta.jsp'>Apertura de Cuenta</a></li>");
                            out.println("<li><a href='#'>Retiro</a></li>");
                            out.println("<li><a href='#'>Depósito</a></li>");
                            out.println("<li><a href='#'>Transferencia en cajas</a></li>");
                            out.println("<li><a href='#'>Acreditación de intereses</a></li>");
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
                    <li class="salir"><a href="index.jsp">Cerrar sesión</a></li>
                </ul>
            </nav>
        </header>
        <form id="buscarCuentas" action="servicios" method="post" accept-charset="UTF-8">
            <div id="content">
                <label>
                    Depositos
                    <br>
                    Buscar Cuenta:
                    <input type="text" name="txtCuenta" size="30" placeholder="ingrese cuenta del cliente">
                    <input type = "submit" name="btnCuenta"  value=" buscar ">
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
                        out.print("<th>Numero de Cuenta</th>");
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
                          //out.print("<td>" + "<input type='text' name='txtMonto' placeholder='ingrese monto'>" + "</td>");
                          //out.print("<td>" + "<input type='submit' name='btnDepositar' value='Depositar'" + "</td>");
                            out.print("</tr>");
                        }
                        out.print("</table>");
                    }
                
                             
                %>
                  
                            
                      
                    
             
            

            </div>  
        </form>
    </body>
</html>
