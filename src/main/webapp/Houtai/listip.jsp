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

<!-- 日期选择 -->
<link rel="stylesheet" href="/SSM/css/date/datedropper.css">
<link rel="stylesheet" href="/SSM/css/date/timedropper.min.css">


<script type="text/javascript" src="/SSM/dist/js/wangEditor.js"></script>
<script type="text/javascript">
$(function(){
	var options = {
         bootstrapMajorVersion:3,
         currentPage: ${page2.currentPage+1},
         numberOfPages: ${page2.allPage}>5?"5":${page2.allPage},
         totalPages:${page2.allPage}, 
         onPageClicked : function (event, originalEvent, type, page) {
	        $("#frompage").attr("action","/SSM/Houtai/iplist.do?currentpage="+(page-1)+"&size=${requestScope.page2.size}");
	      	$("#frompage").submit();
         }
     };
	 $('#fenye').bootstrapPaginator(options);
	 $("a[id^=listsize]").click(function() {
		 var count = $(this).attr("id").split("_")[1];
		 $("#frompage").attr("action","/SSM/Houtai/iplist.do?currentpage=0&size="+count);
	     $("#frompage").submit();
	});
	 $("#pickdate").dateDropper({
			animate: false,
			format: 'Y-m-d',
			maxYear: '2100'
		});
	$("#picktime").timeDropper({
		meridians: false,
		format: 'HH:mm',
	});
	 $("#pickdate1").dateDropper({
			animate: false,
			format: 'Y-m-d',
			maxYear: '2100'
	});
	$("#picktime1").timeDropper({
		meridians: false,
		format: 'HH:mm',
	});
});

</script>
</head>

<body>
	<jsp:include page="/Houtai/nav.jsp"></jsp:include>
	<!-- Page Content -->
        <div id="page-wrapper">
          <div class="panel panel-default">
           <div class="panel-heading">
            <i class="fa fa-bar-chart-o fa-fw"></i>ip访问记录
             <div class="pull-right">
                <div class="btn-group">
                    <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                      	 数量
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu pull-right" role="menu">
                     <li><a href="#" id="listsize_10">10</a>
                        </li>
                        <li><a href="#" id="listsize_30">30</a>
                        </li>
                        <li><a href="#" id="listsize_60">60</a>
                        </li>
                        <li><a href="#" id="listsize_100">100</a>
                        </li>
                    </ul>
                </div>
            </div>
            </div>
            <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                        	<td>序号</td>
                            <th>ip地址</th>
                            <th>ip区域</th>
                            <th>访问时间</th>
                        </tr>
                    </thead> 
                    <tbody>
                    <c:set value="1" var="count"></c:set>
                    <c:forEach items="${requestScope.page2.lists}" var="ips">
                        <tr>
                        	<td>${count}</td>
                            <td>${ips.ip}</td>
                            <td>${ips.location }</td>
                            <td>${ips.date}</td>
                        </tr>
                        <c:set value="${count+1}" var="count"></c:set>
                     </c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- /.table-responsive -->
            <!-- 分页注入 -->
				<!-- <div id="fenye"></div> -->
				<ul id='fenye'></ul>
			<form id="frompage" method="post" action="">
				<p><input type="text" class="input" id="pickdate" name="mindate"/>
				<input type="text" class="input" id="picktime" name="mintime"/>～
				<input type="text" class="input" id="pickdate1" name="maxdate1"/>
				<input type="text" class="input" id="picktime1" name="maxtime1"/>之间访问ip记录
				<input type="submit" value="筛选">
			</form>
        </div>
        </div>
        <!-- /#page-wrapper -->
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
	<!-- 日期选择 -->
	<script type="text/javascript" src="/SSM/js/date/datedropper.min.js"></script>
	<script type="text/javascript" src="/SSM/js/date/timedropper.min.js"></script>
</body>
</html>