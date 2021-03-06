<%@page import="java.text.SimpleDateFormat" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="includes/basiccss.jsp"/>
</head>

<body>
<div id="wrapper">
    <jsp:include page="includes/nav.jsp" />
    <script type="text/javascript">
        getNextContinent(-1);
        $(function () {
            $("#continent").change(function () {
                getNextCountry($("#continent").val());
            })
            $("#country").change(function () {
                getNextProvinces($("#country").val());
            })
            $("#provinces").change(function () {
                getNextCity($("#provinces").val());
            });
            $("#city").change(function () {
                getNextArea($("#city").val())
            });
        });
        function getNextContinent(cityId) {
            $.ajax({
                method: "get",
                dataType: "json",
                data: {"cityId": cityId},
                url: "/webutil/getNextLevelCity.do",
                success: function (data) {
                    var first = 0;
                    $("#continent").html("");
                    $(data.citys).each(function (i, j) {
                        $("#continent").append("<option value='" + j.id + "'>" + j.cityname + "</option>");
                        if (first == 0) {
                            first = j.id;
                        }
                    });
                    getNextCountry(first);
                }
            });
        }
        function getNextCountry(cityId) {
            $.ajax({
                method: "get",
                dataType: "json",
                data: {"cityId": cityId},
                url: "/webutil/getNextLevelCity.do",
                success: function (data) {
                    var first = 0;
                    $("#country").html("");
                    $(data.citys).each(function (i, j) {
                        $("#country").append("<option value='" + j.id + "'>" + j.cityname + "</option>");
                        if (first == 0) {
                            first = j.id;
                        }
                    });
                    getNextProvinces(first);
                }
            });
        }
        function getNextProvinces(cityId) {
            $.ajax({
                method: "get",
                dataType: "json",
                data: {"cityId": cityId},
                url: "/webutil/getNextLevelCity.do",
                success: function (data) {
                    var first = 0;
                    $("#provinces").html("");
                    $(data.citys).each(function (i, j) {
                        $("#provinces").append("<option value='" + j.id + "'>" + j.cityname + "</option>");
                        if (first == 0) {
                            first = j.id;
                        }
                    });
                    if (first == 0) {
                        $("#provinces").append("<option value='当前精度不足'>当前精度不足</option>");
                        $("#city").empty();
                        $("#city").append("<option value='当前精度不足'>当前精度不足</option>");
                        $("#area").empty();
                        $("#area").append("<option value='当前精度不足'>当前精度不足</option>");
                        return;
                    }
                    getNextCity(first);
                }
            });
        }
        function getNextCity(cityId) {
            $.ajax({
                method: "get",
                dataType: "json",
                data: {"cityId": cityId},
                url: "/webutil/getNextLevelCity.do",
                success: function (data) {
                    var first = 0;
                    $("#city").empty();
                    $(data.citys).each(function (i, j) {
                        $("#city").append("<option value='" + j.id + "'>" + j.cityname + "</option>");
                        if (first == 0) {
                            first = j.id;
                        }
                    });
                    if (first == 0) {
                        $("#city").append("<option value='当前精度不足'>当前精度不足</option>");
                        $("#area").empty();
                        $("#area").append("<option value='当前精度不足'>当前精度不足</option>");
                        return;
                    }
                    getNextArea(first);
                }
            });
        }
        function getNextArea(cityId) {
            $.ajax({
                method: "get",
                dataType: "json",
                data: {"cityId": cityId},
                url: "/webutil/getNextLevelCity.do",
                success: function (data) {
                    $("#area").empty();
                    $(data.citys).each(function (i, j) {
                        $("#area").append("<option value='" + j.id + "'>" + j.cityname + "</option>");
                    });
                }
            });
        }
    </script>


    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">省市区三级联动</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <div class="row">
            <div class="panel panel-default">
                <div class="panel-heading">
                    省市区三级联动
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <form action="###" method="post" class="form-horizontal" role="form" id="cityLiandong">
                            <select id="continent" class="form-control"></select>洲
                            <select id="country" class="form-control"></select>国
                            <select id="provinces" class="form-control"></select>省
                            <select id="city" class="form-control"></select>市
                            <select id="area" class="form-control"></select>区
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="includes/basicjs.jsp"/>
</body>
</html>
