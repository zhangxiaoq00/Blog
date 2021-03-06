<%@page import="java.text.SimpleDateFormat" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="includes/basiccss.jsp"/>
    <script type="text/javascript">
        $(function () {
            var options = {
                    bootstrapMajorVersion: 3,
                    currentPage: ${page2.currentPage+1},
                    numberOfPages: ${page2.allPage} > 5 ? "5" :${page2.allPage},
                totalPages
            :${page2.allPage},
            onPageClicked : function (event, originalEvent, type, page) {
                $("#frompage").attr("action", "/Houtai/listjuzi.do?currentpage=" + (page - 1) + "&size=${requestScope.page2.size}");
                $("#frompage").submit();
            }
        }
            ;
            $('#fenye').bootstrapPaginator(options);
            $("a[id^=listsize]").click(function () {
                var count = $(this).attr("id").split("_")[1];
                $("#frompage").attr("action", "/Houtai/listjuzi.do?currentpage=0&size=" + count);
                $("#frompage").submit();
            });

            $("#exportxls").click(function () {

                var flag = false;
                if ($("#juzi").val() != "") {
                    flag = true;
                }
                if ($("#chuchu").val() != "") {
                    flag = true;
                }
                if ($("#juzileixing").val() != "") {
                    flag = true;
                }
                if (flag == false) {
                    $("#exportalert").attr("class", "alert alert-danger");
                    $("#exportalert").html('<strong>导出时请至少选择一个筛选条件</strong>');
                    return false;
                }
                $("#exportxls").attr("class", "btn btn-primary btn disabled");
                $("#exportxls").val("正在生成xls文件,请耐心等待。。。");


                $.ajax({
                    type:"post",
                    url:"/Houtai/exportExcle.do",
                    data:{"juzi":$("#juzi").val(),"chuchu":$("#chuchu").val(),"juzileixing":$("#juzileixing").val()},
                    success:function(data){
                        if(data.indexOf("success")!=-1) {
                            $("#exportalert").attr("class", "alert alert-success alert-dismissable");
                            $("#exportalert").html('<strong>导出成功。。。。。正在下载</strong>');
                            $("#exportxls").attr("class", "btn btn-primary btn");
                            $("#exportxls").val("导出至xls");

                            var form = $("<form>");//定义一个form表单
                            form.attr("style", "display:none");
                            form.attr("target", "");
                            form.attr("method", "post");
                            form.attr("action", '/Houtai/downloadExportExcle.do');

                            var inputJuzi = $("<input>");
                            inputJuzi.attr("style", "display:none");
                            inputJuzi.attr("value", data.split("__")[1]);
                            inputJuzi.attr("name", "filename");

                            var inputChuchu = $("<input>");
                            inputChuchu.attr("style", "display:none");
                            inputChuchu.attr("value", data.split("__")[2]);
                            inputChuchu.attr("name", "dname");


                            form.append(inputJuzi);
                            form.append(inputChuchu);

                            form.submit().remove();
                        }else if(data.indexOf("-0001")!=-1){
                            $("#exportalert").attr("class", "alert alert-danger alert-dismissable");
                            $("#exportalert").html('<strong>当前筛选条件下暂无符合条件的句子，导出失败</strong>');
                            $("#exportxls").attr("class", "btn btn-primary btn");
                            $("#exportxls").val("重新导出");
                        }
                        else{
                            $("#exportalert").attr("class", "alert alert-danger alert-dismissable");
                            $("#exportalert").html('<strong>导出失败。。。。。</strong>');
                            $("#exportxls").attr("class", "btn btn-primary btn");
                            $("#exportxls").val("重新导出");
                        }
                    },
                    error:function(){
                        $("#exportalert").attr("class", "alert alert-danger alert-dismissable");
                        $("#exportalert").html('<strong>导出失败。。。。。</strong>');
                        $("#exportxls").attr("class", "btn btn-primary btn");
                        $("#exportxls").val("重新导出");
                    }
                });
            });
        });
    </script>
</head>

<body>
<div id="wrapper">
    <jsp:include page="includes/nav.jsp"></jsp:include>
</div>
<div id="page-wrapper">
    <div class="panel panel-default">
        <div class="panel-heading">
            句库
            <div class="pull-right">
                <div class="btn-group">
                    <button type="button"
                            class="btn btn-default btn-xs dropdown-toggle"
                            data-toggle="dropdown">
                        数量 <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu pull-right" role="menu">
                        <li><a href="#" id="listsize_10">10</a></li>
                        <li><a href="#" id="listsize_30">30</a></li>
                        <li><a href="#" id="listsize_60">60</a></li>
                        <li><a href="#" id="listsize_100">100</a></li>
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
                        <th>句子内容</th>
                        <th>句子出处</th>
                        <th>句子类型</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set value="1" var="count"></c:set>
                    <c:forEach items="${requestScope.page2.lists}" var="juzis">
                        <tr>
                            <td>${count}</td>
                            <td>${juzis.juzineirong}</td>
                            <td>${juzis.juzichuchu }</td>
                            <td>${juzis.juziTypeKey.leixingming }</td>
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

            <hr class="dirver"/>
            <form id="frompage" method="post" action="" role="form">
                <div class="form-group">
                    <label for="name">内容</label> <input name="juzi" type="text"
                                                        value="${requestScope.juzi }" class="form-control" id="juzi"/>
                </div>
                <div class="form-group">
                    <label for="name">出处/作者</label> <input name="chuchu" type="text"
                                                           value="${requestScope.chuchu }" class="form-control"
                                                           id="chuchu"/>
                </div>
                <div class="form-group">
                    <label for="name">句子类型</label> <select name="juzileixing"
                                                           class="form-control" id="juzileixing">
                    <option></option>
                    <c:forEach items="${requestScope.juzileixing}" var="juzileixing">
                        <c:choose>
                            <c:when test="${juzileixing.leixingid==requestScope.juzitype}">
                                <option value="${juzileixing.leixingid }"
                                        selected="selected">${juzileixing.leixingming}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${juzileixing.leixingid }">${juzileixing.leixingming}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
                </div>
                <input type="submit" value="查询" class="btn btn-primary">
                <span style="float:right"><input type="button" value="导出至xls" class="btn btn-primary"
                                                 id="exportxls"></span>
                <div id="exportalert"></div>
            </form>
            <shiro:hasRole name="administrator">
                <hr class="dirver"/>
                <form action="/Houtai/updataJuzi.do" role="form">
                    <div class="form-group">
                        <label for="name"> 爬取网站</label> <input name="juziurl" type="text" class="form-control"/>
                    </div>
                    <input type="submit" value="爬取" class="btn btn-primary">
                </form>
            </shiro:hasRole>
        </div>
        <!-- 条件查询 -->
        <div></div>
    </div>
</div>
<jsp:include page="includes/basicjs.jsp"/>
</body>
</html>