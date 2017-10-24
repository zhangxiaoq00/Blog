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

<link rel="stylesheet" type="text/css"
	href="/SSM//dist/css/wangEditor.min.css">
<!-- <script src="/SSM/js/jquery.js"></script> -->
<script
	src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="/SSM/js/jquery-confirm.js"></script>

<script type="text/javascript" src="/SSM/dist/js/wangEditor.js"></script>
	<script type="text/javascript">
		//初始化省
        $.ajax({
            method : "get",
            dataType:"json",
            data:{"cityId":100000},
            url : "/SSM/webutil/getNextLevelCity.do",
            success:function(data){
                $("#provinces").html("");
                $(data.citys).each(function(i,j){
                    $("#provinces").append("<option value='"+j.id+"'>"+j.name+"</option>");
                    $("#area").html("");
				});
            }
        });
        $(function(){
            $("#provinces").change(function () {
                $.ajax({
                    method: "get",
                    dataType: "json",
                    data: {"cityId": $("#provinces").val()},
                    url: "/SSM/webutil/getNextLevelCity.do",
                    success: function (data) {
                        var first = 0;
                        $("#city").empty();
                        $(data.citys).each(function (i, j) {
                            $("#city").append("<option value='" + j.id + "'>" + j.name + "</option>");
                            if(first == 0) {
                                first = j.id;
                            }
                        });
                        getNextArea(first);
                    }
                });
            });
            $("#city").change(function () {
               getNextArea($("#city").val())
            });
        });
        function getNextArea(cityId){
            $.ajax({
                method: "get",
                dataType: "json",
                data: {"cityId":cityId },
                url: "/SSM/webutil/getNextLevelCity.do",
                success: function (data) {
                    $("#area").empty();
                    $(data.citys).each(function (i, j) {
                        $("#area").append("<option value='" + j.id + "'>" + j.name + "</option>");
                    });
                }
            });
        }
	</script>
</head>

<body>
	<div id="wrapper">
		<jsp:include page="nav.jsp"></jsp:include>
	</div>
	<div id="page-wrapper">
       <div class="panel panel-default">
        <div class="panel-heading">
        	省市区三级联动
        </div>
          <div class="panel-body">
            <div class="table-responsive">
				<form action = "###" method="post" class ="form-horizontal" role="form" id="cityLiandong">
					<select id="provinces"  class="form-control">
					</select>省
					<select id="city"  class="form-control">
					</select>市
					<select id="area"  class="form-control">
					</select>区
				</form>
            </div>
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