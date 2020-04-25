<%-- 
    Document   : acreditacionIntereses
    Created on : 8 abr. 2020, 13:48:42
    Author     : Kike
--%>

<%@page import="proyecto.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="stylesSesion.css" rel="stylesheet" type="text/css"/>
        <title>Acreditación de intereses</title>
        <link  rel="icon"   href="img/bank.png" type="image/png" />

    </head>
    <body>
        <header>                    
            <form action="servicios" method="post">
                <nav class="navBar">  <!--Menu de navegacion-->
                    <ul class="menu"><!--Lista-->
                        <a class="Encabezado">Bienvenido al Banco Islas Caiman</a>
                        <%
                            String rol = (String) request.getSession().getAttribute("rol");

                            Usuario usr = null;
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
                                usr = (Usuario) request.getSession().getAttribute("cajero");
                                out.println("<li><a href='aperturaCuenta.jsp'>Apertura de Cuenta</a></li>");
                                out.println("<li><a href='retiro.jsp'>Retiro</a></li>");
                                out.println("<li><a href='deposito.jsp'>Depósito</a></li>");
                                out.println("<li><a href='#'>Transferencia en cajas</a></li>");
                                out.println("<li><a href='acreditacionIntereses.jsp'>Acreditación de intereses</a></li>");
                            } else if (rol.equals("CLI")) {
                                usr = (Usuario) request.getSession().getAttribute("usuario");
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
                        <li><input type="submit" name= "btnLogOut" value="Cerrar sesión"></li>
                        </form>
                    </ul>
                </nav>   
        </header> 
        <form id="formulario" action="servicios" method="post" accept-charset="UTF-8">  
            <div id="content">
                <h3>Acreditación de Intereses</h3>
                <label>Porcentaje de interés USD:</label><input type="text" name="aUSD" readonly="readonly" value="1.5">
                <p></p>
                <label>Porcentaje de interés CRC:</label><input type="text" name="aCRC" readonly="readonly" value="1.8">
                <p></p>
                <label>Porcentaje de interés EUR:</label><input type="text" name="aEUR" readonly="readonly" value="2.1">
                <p></p>
                <input class="vincular" type="submit" name="btnAcreditacion" value="Acreditar">
            </div>
        </form>
        <%}%>             
    </body>
</html>
