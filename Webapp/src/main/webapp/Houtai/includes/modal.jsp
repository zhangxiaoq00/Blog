<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- 添加文本模式框 -->
	<div class="modal fade" id="myModa1" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width: 60%">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">添加文章</h4>
				</div>
				<div class="modal-body" id="modaltext">
					<form action="/Houtai/addWenZhang.do" method="post" id="form1"
						class="form-horizontal">
						<input type="hidden" id="hiddentext" name="wenzhangneirong" /> 
						<input type="hidden" id="wenzhangchunwenben" name="wenzhangchunwenben" />
						<div class="form-group">
							<label class="col-sm-2 control-label">文章标题</label>
							<div class="col-sm-10" style="width: 300px">
								<input type="text" name="wenzhangbiaoti" class="form-control" id="wenzhangbiaoti"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">文章类型</label>
							<div class="col-sm-10" style="width: 300px">
								<input type="text" name="wenzhangleixing" class="form-control" />
							</div>
						</div>
						<div id="editor-container" class="container" style="width: 80%;">
							<div id="editor-trigger" style="height: 600px;">
								<p>文章内容</p>
							</div>
						</div>
					</form>
					<div id="upload"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="tijiao">提交文章</button>
				</div>
			</div>
			<!-- /.modal-content -->
			<!-- /.modal -->
		</div>
	</div>
	<!-- 修改文本模式框 -->
	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width: 60%">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">修改文章</h4>
				</div>
				<div class="modal-body" id="modaltext">
					<form action="/Houtai/modifywenzhangaction.do" method="post"
						id="form11" class="form-horizontal">
						<input type="hidden" name="wenzhangid1" id="wenzhangid1" /> <input
							type="hidden" id="wenzhangchunwenben1" name="wenzhangchunwenben" />
						<input type="hidden" id="hiddentext1" name="wenzhangneirong" />
						<div class="form-group">
							<label class="col-sm-2 control-label">文章标题</label>
							<div class="col-sm-10" style="width: 300px">
								<input id="wenzhangbiaoti1" type="text" name="wenzhangbiaoti"
									class="form-control" id="wenzhangbiaoti1"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">文章类型</label>
							<div class="col-sm-10" style="width: 300px">
								<input id="wenzhangleixing1" type="text" name="wenzhangleixing"
									class="form-control" />
							</div>
						</div>
						<div id="editor-container1" class="container" style="width: 80%">
							<div id="editor-trigger1" style="height: 600px;">
								<p>文章内容</p>
							</div>
						</div>
					</form>
					<div id="modify"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="tijiao1">修改文章</button>
				</div>
				<div id="modify"></div>
			</div>
			<!-- /.modal-content -->
			<!-- /.modal -->
		</div>
	</div>