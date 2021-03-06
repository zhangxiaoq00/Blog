<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>

    <script
            src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <!-- Bootstrap Core CSS -->
    <link href="/assets/vendor/bootstrap/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/assets/vendor/metisMenu/metisMenu.min.css"
          rel="stylesheet">

    <!-- DataTables CSS -->
    <link
            href="/assets/vendor/datatables-plugins/dataTables.bootstrap.css"
            rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link
            href="/assets/vendor/datatables-responsive/dataTables.responsive.css"
            rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/assets/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/assets/vendor/font-awesome/css/font-awesome.min.css"
          rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="/css/jquery-confirm.css">
    <script src="/js/jquery-confirm.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var username;
            var pwd;
            var pwdagan;
            $("#username").blur(function () {
                if ($("#username").val() == "") {
                    $("#msg").html("<span style='color:red'>用户名不能为空</span>");
                    $("#vilidatezhanghao").attr("class", "form-group has-error");
                    $("#tijiao").attr("class", "btn btn-primary disabled");
                    return;
                }
                $.ajax({
                    url: "/user/findByName.do",
                    data: {
                        username: $("#username").val()
                    },
                    error: function () {
                        alert("error");
                    },
                    success: function (data) {
                        if (data == "error") {
                            $("#msg").html("<span style='color:red'>已存在</span>");
                            $("#vilidatezhanghao").attr("class", "form-group has-error");
                            $("#tijiao").attr("class", "btn btn-primary disabled");
                        } else {
                            $("#msg").html(null);
                            $("#vilidatezhanghao").attr("class", "form-group has-success");
                            $("#tijiao").attr("class", "btn btn-primary");
                        }
                    }
                });
            });
            $("#password").blur(function () {
                if ($("#password").val() == "") {
                    $("#msg1").html("<span style='color:red'>密码不能为空</span>");
                    $("#vilidatepwd").attr("class", "form-group has-error");
                    $("#tijiao").attr("class", "btn btn-primary disabled");
                } else {
                    $("#tijiao").attr("class", "btn btn-primary");
                }
            });
            $("#passwordagain").blur(function () {
                if ($("#passwordagain").val() == "") {
                    $("#msg2").html("<span style='color:red'>重复密码不能为空</span>");
                    $("#vilidatepwd1").attr("class", "form-group has-error");
                    $("#tijiao").attr("class", "btn btn-primary disabled");
                    return;
                } else {
                    $("#tijiao").attr("class", "btn btn-primary");
                }
                if ($("#passwordagain").val() != $("#password").val()) {
                    $("#msg1").html("<span style='color:red'>两次密码不一致</span>");
                    $("#msg2").html("<span style='color:red'>两次密码不一致</span>");
                    $("div[id*=vilidatepwd]").attr("class", "form-group has-error");
                    $("#tijiao").attr("class", "btn btn-primary disabled");
                } else {
                    $("#msg1").html(null);
                    $("#msg2").html(null);
                    $("div[id*=vilidatepwd]").attr("class", "form-group has-success");
                    $("#tijiao").attr("class", "btn btn-primary");
                }
            });
            $("#useremail").blur(function(){
                if($("#useremail").val()==""){
                    $("#emailmsg").html("<span style='color:red'>邮箱不能为空</span>");
                    $("#uenail").attr("class", "form-group has-error");
                    $("#tijiao").attr("class", "btn btn-primary disabled");
                }else{
                    $("#emailmsg").html(null);
                    $("#uenail").attr("class", "form-group has-success");
                    $("#tijiao").attr("class", "btn btn-primary");
                }
            });
            $("#register").click(function () {
                $("#myModa1").modal("show");
            });
            $("#tijiao").click(function () {
                if ($("#username").val() == "") {
                    $("#msg").html("<span style='color:red'>用户名不能为空</span>");
                    $("#vilidatezhanghao").attr("class", "form-group has-error");
                    $("#tijiao").attr("class", "btn btn-primary disabled");
                    return;
                }
                $.ajax({
                    url: "/user/findByName.do",
                    data: {
                        username: $("#username").val()
                    },
                    error: function () {
                        alert("error");
                    },
                    success: function (data) {
                        if (data == "error") {
                            $("#msg").html("<span style='color:red'>已存在</span>");
                            $("#vilidatezhanghao").attr("class", "form-group has-error");
                            $("#tijiao").attr("class", "btn btn-primary disabled");
                        } else {
                            $("#msg").html(null);
                            $("#vilidatezhanghao").attr("class", "form-group has-success");
                            $("#tijiao").attr("class", "btn btn-primary");
                        }
                    }
                });
                if ($("#passwordagain").val() == "") {
                    $("#msg2").html("<span style='color:red'>重复密码不能为空</span>");
                    $("#vilidatepwd1").attr("class", "form-group has-error");
                    $("#tijiao").attr("class", "btn btn-primary disabled");
                    return;
                } else {
                    $("#tijiao").attr("class", "btn btn-primary");
                }
                if ($("#passwordagain").val() != $("#password").val()) {
                    $("#msg1").html("<span style='color:red'>两次密码不一致</span>");
                    $("#msg2").html("<span style='color:red'>两次密码不一致</span>");
                    $("div[id*=vilidatepwd]").attr("class", "form-group has-error");
                    $("#tijiao").attr("class", "btn btn-primary disabled");
                } else {
                    $("#msg1").html(null);
                    $("#msg2").html(null);
                    $("div[id*=vilidatepwd]").attr("class", "form-group has-success");
                    $("#tijiao").attr("class", "btn btn-primary");
                }
                if ($("#password").val() == "") {
                    $("#msg1").html("<span style='color:red'>密码不能为空</span>");
                    $("#vilidatepwd").attr("class", "form-group has-error");
                    $("#tijiao").attr("class", "btn btn-primary disabled");
                } else {
                    $("#tijiao").attr("class", "btn btn-primary");
                }
                if ($("#passwordagain").val() != $("#password").val()) {
                    $("#msg1").html("<span style='color:red'>两次密码不一致</span>");
                    $("#msg2").html("<span style='color:red'>两次密码不一致</span>");
                    $("div[id*=vilidatepwd]").attr("class", "form-group has-error");
                    $("#tijiao").attr("class", "btn btn-primary disabled");
                    return;
                }
                if($("#useremail").val()==""){
                    $("#emailmsg").html("<span style='color:red'>邮箱不能为空</span>");
                    $("#uenail").attr("class", "form-group has-error");
                    $("#tijiao").attr("class", "btn btn-primary disabled");
                }else{
                    $("#tijiao").attr("class", "btn btn-primary");
                }
                $("#registerfrom").submit();
            });
        });
    </script>
    <script type="text/javascript">
        function getVerifCode() {
            $.ajax({
                url: "/user/getVerifyCode.do",
                type: "get",
                success: function (data) {
                   $("#verifCode").html('<img src="/user/getVerifyCode.do"/>');
                }
            });
        }
        function getVerifCodeByEmail() {
            $.ajax({
                url: "/user/getVerifyCodeFromMail.do?useremail="+$("#useremail").val(),
                type: "get",
                beforeSend:function(){
                    $("#emailMsg").html("正在发送验证码...");
                },
                success: function (data) {
                    $("#emailMsg").html("验证码发送成功...");
                },
                error:function(){
                    $("#emailMsg").html("验证码发送失败...");
                    $("#emailMsg").html('<a href="###" onclick="">重新发送验证码</a>');
                }
            });
        }
    </script>
</head>

<body>

<div class="container">
    <div class="row">
        <div class="col-md-5 col-md-offset-4">
            <div class="login-panel panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Please Sign In</h3>
                </div>
                <div class="panel-body">
                    <form action="/user/logIn.do" method="post"
                          class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="firstname" class="col-sm-2 control-label">用户名</label>
                            <div class="col-lg-8">
                                <input type="text" name="username" class="form-control"
                                       placeholder="请输入用户名"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-sm-2 control-label">密码</label>
                            <div class="col-lg-8">
                                <input type="password" name="password" class="form-control"
                                       placeholder="请输入密码"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-sm-2 control-label">验证码</label>
                            <div class="col-lg-8">
                                <input type="text" name="veudyCode" class="form-control"
                                       placeholder="请输入验证码"/>
                                <span style="color: red">${requestScope.msg}</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-sm-2 control-label">  </label>
                            <div class="col-lg-8">
                                <div class="col-lg-6"  id="verifCode"><img src="/user/getVerifyCode.do"/></div>
                                <div class="col-lg-6"><a href="###" onclick="getVerifCode()">看不清？</a></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <input type="submit" class="btn btn-info" value="登陆"/>
                                <button type="button" class="btn btn-primary" id="register">注册</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModa1" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 30%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">&times;
                </button>
                <h4 class="modal-title" id="myModalLabel">注册</h4>
            </div>
            <div class="modal-body" id="modaltext">
                <form action="/user/adduser.do" class="form-horizontal" id="registerfrom"
                      role="form">
                    <div class="form-group" id="vilidatezhanghao">
                        <label for="username" class="col-sm-2 control-label">用户名</label>
                        <div class="col-lg-4">
                            <input type="text" name="username" class="form-control"
                                   id="username" placeholder="请输入用户名" id="username"/>
                            <div id="msg"></div>
                        </div>
                    </div>
                    <div class="form-group" id="vilidatepwd">
                        <label for="password" class="col-sm-2 control-label">密码</label>
                        <div class="col-lg-4">
                            <input type="password" name="password" class="form-control"
                                   placeholder="请输入密码" id="password"/>
                            <div id="msg1"></div>
                        </div>
                    </div>
                    <div class="form-group" id="vilidatepwd1">
                        <label for="password" class="col-sm-2 control-label">重复密码</label>
                        <div class="col-lg-4">
                            <input type="password" name="password" class="form-control"
                                   placeholder="再次输入密码" id="passwordagain"/>
                            <div id="msg2"></div>
                        </div>
                    </div>
                    <div class="form-group" id="uenail">
                        <label for="useremail" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-lg-4">
                            <input type="email" name="useremail" class="form-control"
                                   placeholder="输入邮箱" id="useremail"/>
                            <div id="emailmsg"></div>
                        </div>
                    </div>
                    <div class="form-group" id="veudyCode">
                        <label for="username" class="col-sm-2 control-label">验证码</label>
                        <div class="col-lg-4">
                            <input type="password" name="veudyCode_email" class="form-control"
                                   placeholder="输入验证码" id="veudyCode_email"/>
                            <span id="veudyCodeMsg">
                                <a href="###" onclick="getVerifCodeByEmail()">获取验证码</a>
                            </span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="tijiao">注册</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>

<!-- Bootstrap Core JavaScript -->
<script src="/assets/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="/assets/vendor/metisMenu/metisMenu.min.js"></script>

<!-- DataTables JavaScript -->
<script src="/assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
<script
        src="/assets/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
<script
        src="/assets/vendor/datatables-responsive/dataTables.responsive.js"></script>

<!-- Custom Theme JavaScript -->
<script src="/assets/dist/js/sb-admin-2.js"></script>
</body>

</html>
