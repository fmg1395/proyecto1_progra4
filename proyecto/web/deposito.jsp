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
                            out.println("<li><a href='retiro.jsp'>Retiro</a></li>");
                            out.println("<li><a href='deposito.jsp'>Depósito</a></li>");
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
            <div id='content'>
                <div id = 'Elección'>
                    <label>Depósitos: <br> Buscar Cuenta: <br><br></label>
                    <div id='Yes'>
                        <input type='radio' id='ansY' name='drone2' value='yes'>
                        <label>Por cédula:</label>
                        <div class='reveal-if-active'>
                            <input type='text' name='buscarCedula' placeholder='Ingrese cédula'>
                            <input type='submit' name='btnBuscarPorCedula' value='Buscar'>
                        </div>
                    </div>
                    <div id='No'>
                        <input type='radio' id='ansN' name='drone2' value='no'>
                        <label>Por número de cuenta:</label>
                        <div class='reveal-if-active'>
                            <input type='text' name='buscarCuenta' placeholder='Ingrese número de cuenta'>
                            <input type='submit' name='btnBuscarPorCuenta' value='Buscar'>
                        </div>
                    </div>
                </div>
                
                <!-- Aqui va la tabla falta hacer logica-->
            </div>
        </form>
    </body>
</html>
