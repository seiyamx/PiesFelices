<%--
  Created by IntelliJ IDEA.
  User: mc764d
  Date: 04/10/2018
  Time: 10:16 AM
  File: Login.jsp
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <%@include file="templates/meta.jsp"%>
    <title>Pies Felices | Inicio de Sesión</title>
    <script>
        function validate() {
            var username = document.form.username.value;
            var password = document.form.password.value;

            if (username==null || username=="") {
                alert("Username cannot be blank");
                return false;
            } else if(password==null || password=="") {
                alert("Password cannot be blank");
                return false;
            }
        }
    </script>
</head>
<body class="hold-transition login-page">
    <div class="login-box">
        <div class="login-logo">
            <a href="index.jsp"><strong>PIES</strong> Felices</a>
        </div>
        <%-- /.login-logo --%>
        <div class="login-box-body">
            <p class="login-box-msg">Ingresa al sistema</p>
            <form action="Login"  method="post" onsubmit="return validate()">
                <div class="form-group has-feedback">
                    <input type="text" name="username" class="form-control" placeholder="Usuario">
                    <span class="glyphicon glyphicon-user form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <input type="password" name="password" class="form-control" placeholder="Password">
                    <span class="glyphicon glyphicon-lock form-control-feedback">
                        <%=(request.getAttribute("errMessage") == null) ? "" : request.getAttribute("errMessage")%>
                    </span>
                </div>
                <div class="row">
                    <div class="col-xs-8">
                        <div class="checkbox icheck">
                            <label>
                                <input type="checkbox"> Mantener Sesión
                            </label>
                        </div>
                    </div>
                    <%-- /.col --%>
                    <div class="col-xs-4">
                        <button type="submit" class="btn btn-primary btn-block btn-flat">Ingresar</button>
                    </div>
                    <%-- /.col --%>
                </div>
            </form>
        </div>
        <%-- /.login-body --%>
    </div>
    <%-- /.login-box --%>

    <%@include file="templates/script.jsp"%><%-- Archivo con scripts utilizables --%>

    <%-- iCheck --%>
    <script src="assets/plugins/iCheck/icheck.min.js"></script>
    <script>
        $(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%'
            });
        });
    </script>
</body>
</html>