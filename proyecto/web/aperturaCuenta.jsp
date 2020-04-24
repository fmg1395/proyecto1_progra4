<%-- 
    Document   : aperturaCuenta
    Created on : 26 mar. 2020, 17:40:26
    Author     : Kike
--%>

<%@page import="java.util.UUID"%>
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
                            List lista = (List) request.getAttribute("cuentasA");
                            String nombre = "";
                            String ced = "";
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
        <form id="formulario" action="servicios" method="post" accept-charset="UTF-8">  
            <div id="content">
                <%
                    int aux = Modelo.cont + 1;
                    out.println("<label> Cuenta:<input type='text' id='Cuenta' disabled='disabled' name= 'cantCuentas' value='" + aux + "'></label> <br>");
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
                <label> Saldo inicial:<input type='text' id='sInicial' disabled="disabled"  name= 'saldo' value="0"></label>
                <br>
                <br>
                <label>Tipo de Cuenta: </label>
                <input type='radio' id='cuentaA' name= 'tCuenta' value='1' checked>
                <label for='cuentaA'>Cuenta de Ahorros</label>
                <input type='radio' id='cuentaC' name= 'tCuenta' value='0' checked>
                <label for='cuentaA'>Cuenta Corriente</label>
                <br>
                <br>
                <label> Límite de transferencias remotas:<input type='number' id='transR' name= 'transferencia' placeholder='Digite numero límite'></label> <br>
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
                        <input class="buscar" type = "submit" name="btnCuentaA" value=" buscar ">
                        <input class="vincular" type="submit" name="btnVincular" value="vincular">
                        <%
                        Boolean existe=(Boolean)request.getAttribute("inexistente");
                        if(existe!=null&&!existe)
                        {
                        out.println("<label>Id inexistente</label><p></p>");
                        }
                        %>
                    </div>
                </div>
                <div class="usuarioNuevo">
                    <%
                        Boolean error = (Boolean) request.getAttribute("validacion");
                        if (error != null && error == false) {
                            out.println("<input type='radio' id='ansN' name= 'drone2' value='no'>");
                            out.println("<label for='ansN'>No</label> <span>Ya existe un usuario registrado con ese ID</span>");
                        } else {
                            out.println("<input type='radio' id='ansN' name= 'drone2' value='no'>");
                            out.println("<label for='ansN'>No</label>");
                        }
                    %>
                    <div class='reveal-if-active'>
                        <label for="CedulaN">Cedula del cliente a vincular:</label>
                        <input type="number" id="cedNueva" name="cedNueva" max="999999999" placeholder="Ingrese la cedula">
                        <p></p> 
                        <label for="NombreN">Nombre completo del cliente a vincular:</label>
                        <input type="text" id="nomN" name="nomN" placeholder="Ingrese el Nombre">   
                        <p></p> 
                        <label for="TelefonoN">Numero telefónico del cliente a vincular:</label>
                        <input type="number" id="celT" name="celT" max= "99999999" placeholder="Ingrese el numero">
                        <p></p> 
                        <label for="passN">Contraseña:</label>
                        <input type="text" name="passN" for="passN"  readonly="readonly"
                               <%
                                   final String uuid = UUID.randomUUID().toString().replace("-", "");

                                   out.println("value='" + uuid.substring(0, 8) + "'>");
                               %>
                               <input class="registro" type="submit" name="crearUsuario" value="Registrar">
                    </div>
                </div>
            </div>
        </form>
        <%}%>                       
    </body>
</html>
