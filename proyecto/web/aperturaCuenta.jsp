<%-- 
    Document   : aperturaCuenta
    Created on : 26 mar. 2020, 17:40:26
    Author     : Kike
--%>

<%@page import="proyecto.modelo.Cuenta"%>
<%@page import="java.util.List"%>
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
                        String rol = (String) request.getSession().getAttribute("rol");
                        
                        List lista = (List) request.getAttribute("cuentasA");
                        String nombre = "";
                        String ced="";
                        if (lista != null) {
                            nombre = ((Cuenta) lista.get(0)).getUsuarios().getNombre();
                            ced=((Cuenta)lista.get(0)).getUsuarios().getId();
                        }
                        Usuario usr = (Usuario) request.getSession().getAttribute("cajero");

                        if (rol.equals("CAJ")) {
                            out.println("<li><a href='#'>Apertura de Cuenta</a></li>");
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
        <form id="formulario" action="servicios" method="post" accept-charset="UTF-8">  
            <div id="content">
                <%
                    int aux = Modelo.cont + 1;
                    out.println("<label> Cuenta:<input type='text' id='Cuenta' disabled='disabled' name= 'cantCuentas' placeholder='" + aux + "'></label> <br>");
                %>                
                <br>
                <br>
                <label>Tipo de moneda: </label> <br>
                <input type='radio' id='monCRC' name= 'drone' value='CRC' checked>
                <label for='monCRC'>CRC</label>
                <br>
                <input type='radio' id='monUSD' name= 'drone' value='USD'>
                <label for='monUSD'>USD</label>
                <br>
                <input type='radio' id='monEUR' name= 'drone' value='EUR'>
                <label for='monEUR'>EUR</label>
                <br>
                <br>
                <br>
                <label> Saldo inicial:<input type='text' id='sInicial' disabled='disabled' name= 'saldo' placeholder='0'></label> <br>
                <br>
                <br>
                <label> Límite de transferencias remotas:<input type='number' id='sInicial' name= 'saldo' placeholder='Digite numero límite'></label> <br>
                <br>
                <br>
                <label>¿El cliente está registrado? </label> <br>
                <div>
                    <input type='radio' id='ansY' name= 'drone2' value='yes' checked>
                    <label for='ansY'>Sí</label>
                    <div class='reveal-if-active'>
                        <label for="Cedula">Cedula del cliente:</label>
                        <%if (nombre != "") {
                        %>
                        <input type="number" id="cedExistente" name="cedExistente" maxlength = "9" Value=<%=ced%>>
                        <label> Cliente seleccionado:<%=nombre%></label><p></p>
                        <%
                        } else {

                        %>
                        <input type="number" id="cedExistente" name="cedExistente" maxlength = "9" placeholder="Ingrese la cedula">
                        <%}%>
                        <input type = "submit" name="btnCuentaA" value=" buscar ">

                    </div>
                </div>
                <div>
                    <input type='radio' id='ansN' name= 'drone2' value='no'>
                    <label for='ansN'>No</label>
                    <div class='reveal-if-active'>
                        <label for="CedulaN">Cedula del cliente a vincular:</label>
                        <input type="number" id="cedNueva" name="cedNueva" max="99999999" placeholder="Ingrese la cedula">
                        <p style=" margin-top: 20px"></p> 
                        <label for="NombreN">Nombre completo del cliente a vincular:</label>
                        <input type="text" id="nomN" name="nomN" placeholder="Ingrese el Nombre">   
                        <p style=" margin-top: 20px"></p> 
                        <label for="TelefonoN">Numero telefónico del cliente a vincular:</label>
                        <input type="number" id="celT" name="celT" max= "99999999" placeholder="Ingrese el numero">
                        <p style=" margin-top: 20px"></p> 
                    </div>
                </div>

            </div>
        </form>

    </body>
</html>
