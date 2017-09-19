<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->

<head>
<title>墨染琉璃殇</title>
<meta name="description" content="website description" />
<meta name="keywords" content="website keywords, website keywords" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Tangerine&amp;v1" />
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz" />
<!-- <link href="/SSM/css/bootstrap.css" rel="stylesheet" /> -->
<link rel="stylesheet" type="text/css" href="style/style.css" />
<script type="text/javascript" src="/SSM/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
						$("#nextPage").click(function() {
											var nextPage = ${page.currentPage};
											if (nextPage >= ${page.allPage}) {
												$("#form1").attr("action","/SSM/wenzhang/findByPage.do?currentPage=${page.allPage}");
												$("#currentPage").attr("value","${page.allPage}");
											} else {
												$("#form1")
														.attr(
																"action",
																"/SSM/wenzhang/findByPage.do?currentPage=${page.currentPage+1}");
												$("#currentPage").attr("value","${page.currentPage+1}");
											}
											$("#form1").submit();
										});
						$("#lastPage").click(function() {
											var lastPage = ${page.currentPage};
											if (lastPage <= 1) {
												$("#form1")
														.attr("action",
																"/SSM/wenzhang/findByPage.do?currentPage=1");
												$("#currentPage").attr("value","1");
											} else {
												$("#form1")
														.attr(
																"action",
																"/SSM/wenzhang/findByPage.do?currentPage=${page.currentPage-1}");
												$("#currentPage").attr("value","${page.currentPage-1}");
											}
											$("#form1").submit();
										});
						$("#sieze").change(function() {
							$("#fom1").submit();
						});
						$("#currentPage").change(function() {
							$("#fom1").submit();
						});
					})
</script>
</head>

<body>
	<div id="main">
		<div id="header">
			<div id="logo">
				<h1>墨染琉璃殇</h1>
				<div class="slogan">Cool slogan goes here!</div>
			</div>
			<div id="menubar">
				<ul id="menu">
					<!-- put class="current" in the li tag for the selected page - to highlight which page you're on -->
					<li class="current"><a href="/SSM/index.jsp">Home</a></li>
					<li><a href="page.html">A Page</a></li>
					<li><a href="/SSM/wenzhang/randWenZhang.do">Rand A Page</a></li>
					<li><a href="contact.html">Contact Us</a></li>
				</ul>
			</div>
		</div>

		<div id="site_content">
			<div id="sidebar_container">
				<img class="paperclip" src="style/paperclip.png" alt="paperclip" />
				<div class="sidebar">
					<img src="/SSM/imgs/touxiang.png"  src="/SSM/imgs/touxiang.png" width="200px" height="200px">
				</div>
				<img class="paperclip" src="style/paperclip.png" alt="paperclip" />
				<div class="sidebar">
					<h3>查找</h3>
					<p>If you would like to receive our newletter, please enter
						your email address and click 'Subscribe'.</p>
					<form action="/SSM/wenzhang/findByPage2.do" method="post" id="fom1">
						<p style="padding: 0 0 9px 0;">
							文章标题<input type="text" class="search" name="wenzhangbiaoti"
								value="${page.wenZhangSearch.name}" /> 文章类型<input type="text"
								class="search" name="wenzhangleixing"
								value="${page.wenZhangSearch.type}" /> 一页<select class="search" style="width:50px"
								name="sieze" id="sieze">
								<c:forEach begin="${1 }" end="${15}" var="i">
									<c:choose>
										<c:when test="${i==page.sieze}">
											<option value="${i }" selected="selected">${i}
										</c:when>
										<c:otherwise>
											<option value="${i }">${i}
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select> 条记录 <br>
						</p>
						<p style="padding: 0 0 9px 0;">
							<input class="subscribe" name="subscribe" type="submit"
								value="Subscribe" />
								<br>
								<br>
								<br>
								
						</p>
						<P style="padding: 0 0 9px 0;">
							<button id="lastPage" class="btn btn-default">上一页</button>
							<input type="submit" value="跳转至" style=" color:#35BDF5"/> <select name="currentPage" 
								id="currentPage">
								<c:forEach begin="${1}" end="${page.allPage}" var="i">
									<c:choose>
										<c:when test="${i==page.currentPage}">
											<option value="${i }" selected="selected">${i}
										</c:when>
										<c:otherwise>
											<option value="${i }">${i}
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select> 页
							<button id="nextPage" class="btn btn-default">下一页</button>
						</P>
					</form>

				</div>
				<img class="paperclip" src="style/paperclip.png" alt="paperclip" />
				<div class="sidebar">
					<h3>Latest Blog</h3>
					<h4>Website Goes Live</h4>
					<h5>1st July 2011</h5>
					<p>
						We have just launched our new website. Take a look around, we'd
						love to know what you think.....<br /> <a href="#">read more</a>
					</p>
				</div>
			</div>
			<div id="content">
				<!-- insert the page content here -->
				<h1>Welcome to the simplestyle_7 template</h1>
				<c:forEach items="${page.lists }" var="wenzhang1">
					<h3>
						<a href="/SSM/wenzhang/xiangxi.do?wenzhangid=${wenzhang1.id }">${wenzhang1.wenzhangbiaoti}</a>
					</h3>
					<h5>${wenzhang1.wenzhangleixing}</h5>
					<p>
						<%-- <i>${wenzhang1.wenzhangneirong }</i> --%>
						<i><c:if test="${fn:length(wenzhang1.wenzhangchunwenben)>100 }">${fn:substring(wenzhang1.wenzhangchunwenben ,0,100)} ...</c:if>
 						<c:if test="${fn:length(wenzhang1.wenzhangchunwenben)<=100 }">${wenzhang1.wenzhangchunwenben }</c:if></i>
					</p>
					<h5>${wenzhang1.wenzhangriqi}</h5>
				</c:forEach>
			</div>
		</div>
		<div id="footer"></div>
	</div>
</body>
</html>