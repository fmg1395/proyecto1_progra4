<%-- 
    Document   : aperturaCuenta
    Created on : 26 mar. 2020, 17:40:26
    Author     : Kike
--%>

<%@page import="proyecto.modelo.Modelo"%>
<%@page import="proyecto.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="stylesSesion.css" rel="stylesheet" type="text/css"/>
        <title>Apertura de Cuenta</title>
    </head>
    <body>
        <header><!--Titulo o logotipo y despues el menu-->
            <nav class="navBar"><!--Menu de navegacion-->
                <ul class="menu"><!--Lista-->
                    <%
                          String rol = (String)request.getSession().getAttribute("rol");
                                       
                          Usuario usr = (Usuario) request.getSession().getAttribute("cajero");
                         if(usr.getRol().equals("CAJ"))
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
                         }
                     %>
                     <li class="salir"><a href="index.jsp">Cerrar sesión</a></li>
                </ul>
            </nav>
        </header>                        
<form id="formulario" action="servicios" method="post" accept-charset="UTF-8">  
        <div id="content">
            <%
            out.println("<label> Cuenta:<input type='text' id='Cuenta' disabled='disabled' name= 'cantCuentas' placeholder='"+Modelo.cont+1+"'></label> <br>");
            out.println("<br>");
            out.println("<br>");
            out.println("<label>Tipo de moneda: </label> <br>");
            out.println("<input type='radio' id='monCRC' name= 'drone' value='CRC' checked>");
            out.println("<label for='monCRC'>CRC</label>");
            out.println("<br>");
            out.println("<input type='radio' id='monUSD' name= 'drone' value='USD'>");
            out.println("<label for='monUSD'>USD</label>");
            out.println("<br>");
            out.println("<input type='radio' id='monEUR' name= 'drone' value='EUR'>");
            out.println("<label for='monEUR'>EUR</label>");
            out.println("<br>");
            out.println("<br>");
            out.println("<br>");
            out.println("<label> Saldo inicial:<input type='text' id='sInicial' disabled='disabled' name= 'saldo' placeholder='0'></label> <br>");
            out.println("<br>");
            out.println("<br>");
            out.println("<label> Límite de transferencias remotas:<input type='number' id='sInicial' name= 'saldo' placeholder='Digite numero límite'></label> <br>");
            out.println("<br>");
            out.println("<br>");
            out.println("<label>¿El cliente está registrado? </label> <br>");
            out.println("<div>");
            out.println("<input type='radio' id='ansY' name= 'drone2' value='yes' checked>");
            out.println("<label for='ansY'>Sí</label>");
            out.println("<div class='reveal-if-active'>");
            out.println("<label for='ansY'>Mostrar listado de clientes</label>");
            out.println("</div>");
            out.println("</div>");
            out.println("<div>");
            out.println("<input type='radio' id='ansN' name= 'drone2' value='no'>");
            out.println("<label for='ansN'>No</label>");
            out.println("<div class='reveal-if-active'>");
            out.println("<label for='ansN'>Mostrar datos a rellenar</label>");
            out.println("</div>");
            out.println("</div>");
            %>       
        </div>
</form>

    </body>
</html>
