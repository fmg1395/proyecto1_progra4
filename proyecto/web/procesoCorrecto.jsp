<%-- 
    Document   : procesoCorrecto
    Created on : 6 abr. 2020, 13:58:25
    Author     : Kike
--%>

<%@page import="proyecto.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="stylesSesion.css" rel="stylesheet" type="text/css"/>
        <title>Proceso correcto</title>
        <link  rel="icon"   href="img/bank.png" type="image/png" />
    </head>
    <form action="servicios" method="post">
        <body>
            <div id="realized">

                <%
                    String rol = (String) request.getSession().getAttribute("rol");

                    if (rol == null) {
                %>
                <h2>ACCESO DENEGADO</h2>
                <div id="url">
                <input type="submit" name= "btnLogOut" value="Volver al inicio"> 
                </div>
                <%
                } else {
                %>
                <h2>Proceso realizado con éxito.</h2>
                <div id="url">
                    <a href="/sesion.jsp">Volver al menú principal</a>
                    <input type="submit" name= "btnLogOut" value="Cerrar sesión"> 
                </div>
                <%}%>
            </div>
    </form>
</body>
</html>
