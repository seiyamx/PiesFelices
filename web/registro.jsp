<%--
  Created by IntelliJ IDEA.
  User: mc764d
  Date: 05/10/2018
  Time: 01:44 PM
  File: registro.jsp
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%@include file="templates/meta.jsp"%>
    <title>AdminLTE 2 | Home</title>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- .wrapper -->
<div class="wrapper">

    <%@include file="/templates/header.jsp"%>
    <%@include file="templates/aside.jsp"%>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Page Header
                <small>Optional description</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                <li class="active">Here</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <!-- Your Page Content Here -->

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <%@include file="templates/footer.jsp"%>
    <%@include file="templates/control-sidebar.jsp"%>

</div>
<!-- /.wrapper -->

<%@include file="templates/script.jsp"%>

</body>
</html>