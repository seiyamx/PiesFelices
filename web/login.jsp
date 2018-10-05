<%--
  Created by IntelliJ IDEA.
  User: mc764d
  Date: 04/10/2018
  Time: 10:16 AM
  File: Login.jsp
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <%@include file="templates/meta.jsp"%>
    <title>Pies Felices | Inicio de Sesión</title>
</head>
<body class="hold-transition login-page">
    <div class="login-box">
        <div class="login-logo">
            <a href="login.jsp"><strong>PIES</strong> Felices</a>
        </div>
        <div class="login-box-body">
            <p class="login-box-msg">Ingresa al sistema</p>
            <form action="index.jsp"  method="post">
                <div class="form-group has-feedback">
                    <input type="text" class="form-control" placeholder="Usuario">
                    <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <input type="password" class="form-control" placeholder="Password">
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
            </form>
        </div>
        <%-- /.login-logo --%>
    </div>
</body>
</html>