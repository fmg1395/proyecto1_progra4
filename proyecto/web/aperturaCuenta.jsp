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
                          Usuario usr = null;

                          if(rol.equals("CAJ"))
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
        <div id="content">
            <%
            out.println("<label> Cuenta: "+Modelo.cont+"</label> <br>");
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
            out.println("");
            %>       
        </div>
        <h1>Hello World!</h1>
    </body>
</html>
