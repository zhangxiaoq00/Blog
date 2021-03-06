<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
    <jsp:include page="includes/basiccss.jsp"/>


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/css/fileupload/Huploadify.css"/>
    <script src="/js/fileupload/jquery.Huploadify.js"></script>

    <script type="text/javascript">
        //修改富文本编辑器初始化
        $(function () {
            var editor = new wangEditor('editor-trigger1');
            editor.config.uploadImgUrl = '/Houtai/upLoadImg.do';
            editor.config.mapAk = 'ByDEc7m5D1gKYKOGTqiltNNjqHvqQmmj';
            editor.create();

            var editor1 = new wangEditor('editor-trigger');
            editor1.config.uploadImgUrl = '/Houtai/upLoadImg.do';
            editor1.config.mapAk = 'ByDEc7m5D1gKYKOGTqiltNNjqHvqQmmj';
            editor1.create();
            //当总页数不为零时加载分页
            if (${page.allPage!=0}) {
                //加载分页
                var options = {
                        bootstrapMajorVersion: 3,
                        currentPage: ${page.currentPage+1},
                        numberOfPages: ${page.allPage} > 5 ? "5" :${page.allPage},
                    totalPages
            :${page.allPage},
                onPageClicked : function (event, originalEvent, type, page) {
                    $("#frompage").attr("action", "/Houtai/findByPage.do?currentPage=" + (page - 1));
                    $("#frompage").submit();
                }
            }
                ;
                $('#fenye').bootstrapPaginator(options);
            } else {
                $("#wenzhangListBody").html("当前还没有创建过任何文章")
            }

            $('#upload').Huploadify({
                auto: true,
                multi: true,
                formData: {"wenzhangbiaoti": $("#wenzhangbiaoti").val()},
                fileSizeLimit: 999999,
                showUploadedPercent: true,//是否实时显示上传的百分比，如20%
                showUploadedSize: true,
                removeTimeout: 1000,
                uploader: '/Houtai/addFile.do',
                buttonText: '添加附件',
                onUploadStart: function () {
                    //alert('开始上传');
                },
                onInit: function () {
                },
                onUploadComplete: function (file, data) {
                    editor1.$txt.append("<p>" + data + "</p>");
                },
                onDelete: function (file) {
                    console.log('删除的文件：' + file);
                    console.log(file);
                }
            });
            $('#modify').Huploadify({
                auto: true,
                multi: true,
                formData: {"wenzhangbiaoti1": $("#wenzhangbiaoti1").val()},
                fileSizeLimit: 999999,
                showUploadedPercent: true,//是否实时显示上传的百分比，如20%
                showUploadedSize: true,
                removeTimeout: 1000,
                uploader: '/Houtai/addFile.do?',
                buttonText: '添加附件',
                onUploadStart: function () {
                    //alert('开始上传');
                },
                onInit: function () {
                },
                onUploadComplete: function (file, data) {
                    editor.$txt.append("<p>" + data + "</p>");
                },
                onDelete: function (file) {
                    console.log('删除的文件：' + file);
                    console.log(file);
                }
            });
            $("#sieze").change(function () {
                $("#frompage").attr("action", "/Houtai/findByPage.do?currentPage=0");
                $("#frompage").submit();
            });
            $("#addwenzhang").click(function () {
                $("#myModa1").modal("show");
                $("#tijiao").click(function () {
                    $("#hiddentext").val(editor1.$txt.html());
                    $("#wenzhangchunwenben").val(editor1.$txt.text());
                    $("#hiddentext").val(editor1.$txt.html());
                    $("#form1").submit();
                });
            });
            $("button[id*=deletewenzhang]").on('click', function () {
                var id = $(this).val();
                $.confirm({
                    title: "不可逆的删除操作",
                    content: "确认要删除文章《" + $("#deletneirong" + id).val() + "》吗？",
                    theme: 'supervan',// 'material', 'bootstrap'
                    buttons: {
                        ok: function () {
                            location.href = "/Houtai/delete.do?wenzhangid=" + id;
                        },
                        cancel: function () {
                            return;
                        }
                    }
                });
            });
            $("button[id*=modify]").click(function () {
                var id = $(this).val();
                $.ajax({
                    type: "post",
                    url: "/Houtai/modifywenzhang.do?wenzhangid=" + id,
                    data: null,
                    dataType: "text",
                    beforeSend: function (XMLHttpRequest) {
                    },
                    success: function (data) {
                        var obj = JSON.parse(data);
                        $("#myModal1").modal("show");
                        $("#wenzhangbiaoti1").val(obj.wenzhang.wenzhangbiaoti);
                        $("#wenzhangleixing1").val(obj.wenzhang.wenzhangleixing);
                        $("#wenzhangid1").val(obj.wenzhang.wenzhangid);
                        editor.$txt.html(obj.wenzhang.wenzhangneirong);
                        $("#tijiao1").click(function () {
                            $("#wenzhangchunwenben1").val(editor.$txt.text())
                            $("#hiddentext1").val(editor.$txt.html())
                            $("#form11").submit();
                        });
                    },
                    complete: function (XMLHttpRequest, textStatus) {
                    },
                    error: function (message) {
                        alert("调用ajax请求出错");
                        alert(message);
                    }
                });
            });
        });
    </script>
</head>

<body>
<div id="wrapper">
<jsp:include page="includes/nav.jsp"></jsp:include>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">文章管理</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">文章列表</div>
        <!-- /.panel-heading -->
        <div class="panel-body">
            <div class="table-responsive" id="neirong">
                <!-- 分页表单 -->
                <form action="" method="post" id="frompage" class="form-inline">
                    <div class="col-sm-6">
                        <div class="dataTables_length" id="dataTables-example_length">
                            <label>Show <select id="sieze" name="sieze" aria-controls="dataTables-example"
                                                class="form-control input-sm">
                                <c:forEach begin="10" end="100" step="30" var="temp">
                                    <c:choose>
                                        <c:when test="${page.size==temp}">
                                            <option value="${temp}" selected="selected">${temp}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${temp}">${temp}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>entries
                            </label>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div id="dataTables-example_filter" class="dataTables_filter">
                            <label>文章标题: <input type="search" name="wenzhangbiaoti"
                                                class="form-control" value="${requestScope.wenzhangbiaoti}"/></label>
                            <label>文章类型:
                                <input type="text" name="wenzhangleixing" class="form-control"
                                       value="${requestScope.wenzhangleixing }"/>
                            </label> <input type="submit" value="查找" class="btn btn-default"/>
                        </div>
                    </div>
                    <table class="table table-striped table-bordered table-hover"
                           id="pagetable">
                        <thead id="wenzhangListBody">
                        <tr>
                            <th>id</th>
                            <th>文章标题</th>
                            <th>文章类型</th>
                            <th>发布日期</th>
                            <th>修改/删除</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.lists }" var="wenzhang1">
                            <tr>
                                <td id="wenzhangid">${wenzhang1.wenzhangid}</td>
                                <td><a
                                        href="/wenzhang/xiangxi.do?wenzhangid=${wenzhang1.wenzhangid }">${wenzhang1.wenzhangbiaoti}</a>
                                </td>
                                <td>${wenzhang1.wenzhangleixing}</td>
                                <td>${wenzhang1.wenzhangriqi}</td>
                                <td>
                                    <button type="button" class="btn btn-info"
                                            id="modify${wenzhang1.wenzhangid}" value="${wenzhang1.wenzhangid}">修改
                                    </button>
                                    <button type="button" class="btn btn-danger"
                                            id="deletewenzhang${wenzhang1.wenzhangid}" value="${wenzhang1.wenzhangid}">
                                        删除
                                    </button>
                                    <input type="hidden" id="deletneirong${wenzhang1.wenzhangid}"
                                           value="${wenzhang1.wenzhangbiaoti}"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </form>
                <button class="btn btn-default" id="addwenzhang">添加文章</button>
            </div>
            <!-- /.table-responsive -->
            <!-- 分页注入 -->
            <!-- <div id="fenye"></div> -->
            <ul id='fenye'></ul>
        </div>
        <!-- /.panel-body -->
    </div>
    <!-- /.panel -->
</div>
</div>
<jsp:include page="includes/modal.jsp"></jsp:include>
<jsp:include page="includes/basicjs.jsp"/>
</body>
</html>