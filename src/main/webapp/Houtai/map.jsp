<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Bootstrap Core CSS -->
<link href="/SSM/assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<!-- MetisMenu CSS -->
<link href="/SSM/assets/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- DataTables CSS -->
<link
	href="/SSM/assets/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link
	href="/SSM/assets/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/SSM/assets/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/SSM/assets/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<link rel="stylesheet" href="/SSM/css/jquery-confirm.css">
<link rel="stylesheet" href="/SSM/css/fenye.css">
<!-- <script src="/SSM/js/jquery.js"></script> -->
<script
	src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="/SSM/js/jquery-confirm.js"></script>
	<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.0&key=06f4dc2a23f3e7e8a778f573d682e4f6"></script>
	<script type="text/javascript">
	 $(function(){
         var map = new AMap.Map('container', {
             resizeEnable: true,
             zoom:11,
             center: [116.397428, 39.90923]
         });
	 })
	</script>
</head>

<body>
	<div id="wrapper">
		<jsp:include page="nav.jsp"></jsp:include>
	</div>
	<div id="page-wrapper">
       <div class="panel panel-default">
        <div class="panel-heading">
        	ip访问分布
        </div>
          <div class="panel-body">
			  <div id="container" style="width:1200px; height:800px"></div>
         </div>
       </div>
     </div>
	<script src="/SSM/assets/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="/SSM/assets/vendor/metisMenu/metisMenu.min.js"></script>

	<!-- DataTables JavaScript -->
	<script src="/SSM/assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
	<script
		src="/SSM/assets/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
	<script
		src="/SSM/assets/vendor/datatables-responsive/dataTables.responsive.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="/SSM/assets/dist/js/sb-admin-2.js"></script>
	<script type="text/javascript" src="/SSM/js/bootstrap-paginator.min.js"></script>
	<script src="/SSM/js/jqueryForm.js"></script>
</body>
</html>