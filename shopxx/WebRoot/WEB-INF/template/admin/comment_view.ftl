<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="comment.view.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready(function() {
	
	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $validateForm = $("#validateForm");
	var $showComment = $("#showComment");
	var $hiddenComment = $("#hiddenComment");
	var $deleteReply = $(".deleteReply");
	var $showReply = $(".showReply");
	var $hiddenReply = $(".hiddenReply");
	
	$hiddenComment.click( function() {
		var $this = $(this);
		$.dialog({type: "warn", content: "<@s.text name="comment.view.closeMsg"/>?", ok: "<@s.text name="button.name.confirm"/>", cancel: "<@s.text name="button.name.cancel"/>", modal: true, okCallback: hiddenComment});
		function hiddenComment() {
			$.ajax({
				url: "comment!ajaxHiddenComment.action",
				data: {"id": "${comment.id}"},
				type: "POST",
				dataType: "json",
				cache: false,
				success: function(data) {
					$this.hide();
					$this.prev().show();
					$.message({type: data.status, content: data.message});
				}
			});
		}
	});
	
	$showComment.click( function() {
		var $this = $(this);
		$.dialog({type: "warn", content: "<@s.text name="comment.view.showMsg"/>?", ok: "<@s.text name="button.name.confirm"/>", cancel: "<@s.text name="button.name.cancel"/>", modal: true, okCallback: showComment});
		function showComment() {
			$.ajax({
				url: "comment!ajaxShowComment.action",
				data: {"id": "${comment.id}"},
				type: "POST",
				dataType: "json",
				cache: false,
				success: function(data) {
					$this.hide();
					$this.next().show();
					$.message({type: data.status, content: data.message});
				}
			});
		}
	});
	
	$deleteReply.click( function() {
		var $this = $(this);
		var replyId = $this.attr("replyId");
		$.dialog({type: "warn", content: "<@s.text name="item.delete.tipmessage"/>", ok: "<@s.text name="button.name.confirm"/>", cancel: "<@s.text name="button.name.cancel"/>", modal: true, okCallback: deleteReply});
		function deleteReply() {
			$.ajax({
				url: "comment!ajaxDeleteReply.action",
				data: {"id": replyId},
				type: "POST",
				dataType: "json",
				cache: false,
				success: function(data) {
					if (data.status == "success") {
						$("." + replyId).remove();
					}
					$.message({type: data.status, content: data.message});
				}
			});
		}
	});
	
	$hiddenReply.click( function() {
		var $this = $(this);
		var replyId = $this.attr("replyId");
		$.dialog({type: "warn", content: "<@s.text name="comment.view.closeMsg"/>?", ok: "<@s.text name="button.name.confirm"/>", cancel: "<@s.text name="button.name.cancel"/>", modal: true, okCallback: hiddenReply});
		function hiddenReply() {
			$.ajax({
				url: "comment!ajaxHiddenReply.action",
				data: {"id": replyId},
				type: "POST",
				dataType: "json",
				cache: false,
				success: function(data) {
					$this.hide();
					$this.prev().show();
					$.message({type: data.status, content: data.message});
				}
			});
		}
	});
	
	$showReply.click( function() {
		var $this = $(this);
		var replyId = $this.attr("replyId");
		$.dialog({type: "warn", content: "<@s.text name="comment.view.showMsg"/>?", ok: "<@s.text name="button.name.confirm"/>", cancel: "<@s.text name="button.name.cancel"/>", modal: true, okCallback: showReply});
		function showReply() {
			$.ajax({
				url: "comment!ajaxShowReply.action",
				data: {"id": replyId},
				type: "POST",
				dataType: "json",
				cache: false,
				success: function(data) {
					$this.hide();
					$this.next().show();
					$.message({type: data.status, content: data.message});
				}
			});
		}
	});
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"comment.content": "required"
		},
		messages: {
			"comment.content": "<@s.text name="comment.view.reply.content"/>"
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
})
</script>
</head>
<body class="input">
	<div class="bar"><@s.text name="comment.list.title"/></div>
	<div class="body">
		<div id="validateErrorContainer" class="validateErrorContainer">
			<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
			<ul></ul>
		</div>
		<form id="validateForm" action="comment!reply.action" method="post">
			<input type="hidden" name="id" value="${comment.id}" />
			<div class="tableItem">
				<table class="inputTable">
					<tr>
						<th colspan="2" class="title">
							<@s.text name="comment.list.title"/>
						</th>
					</tr>
					<tr>
						<th>
							<@s.text name="comment.list.comment.username"/>: 
						</th>
						<td>
							${(comment.username)!"<@s.text name="comment.username.anonymous"/>"}
							<#if comment.isShow>
								<a href="javascript: void(0);" id="showComment" class="red hidden">[<@s.text name="comment.view.show"/>]</a>
								<a href="javascript: void(0);" id="hiddenComment" class="red">[<@s.text name="comment.view.close"/>]</a>
							<#else>
								<a href="javascript: void(0);" id="showComment" class="red">[<@s.text name="comment.view.show"/>]</a>
								<a href="javascript: void(0);" id="hiddenComment" class="red hidden">[<@s.text name="comment.view.close"/>]</a>
							</#if>
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="comment.list.comment.goods"/>: 
						</th>
						<td>
							<a href="${base}${comment.goods.htmlPath}" target="_blank" title="${comment.goods.name}">
								${substring(comment.goods.name, 60, "...")}
							</a>
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="goods.message.context"/>: 
						</th>
						<td>
							${comment.content}
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="goods.content.bottom.comment.contact"/>: 
						</th>
						<td>
							${comment.contact}
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="comment.list.comment.date"/>: 
						</th>
						<td>
							${comment.createDate?string("yyyy-MM-dd HH:mm:ss")}
						</td>
					</tr>
					<tr>
						<th>
							IP: 
						</th>
						<td>
							${comment.ip}
						</td>
					</tr>
				</table>
				<#if (comment.replyCommentSet?? && comment.replyCommentSet?size > 0)>
					<div class="blank"></div>
					<table class="inputTable">
						<tr>
							<th colspan="2" class="title"><@s.text name="goods.common.reply"/></th>
						</tr>
						<#list comment.replyCommentSet as replyComment>
							<tr class="${replyComment.id}">
								<th>
									<@s.text name="comment.view.reply.user"/>: 
								</th>
								<td>
									<#if replyComment.isAdminReply>
										<@s.text name="comment.admin"/>
									<#else>
										${(replyComment.username)!"<@s.text name="comment.username.anonymous"/>"}
									</#if>
									<a href="javascript: void(0);" class="red deleteReply" replyId="${replyComment.id}">[<@s.text name="goods.common.delete"/>]</a>
									<#if replyComment.isShow>
										<a href="javascript: void(0);" class="red hidden showReply" replyId="${replyComment.id}">[<@s.text name="comment.view.show"/>]</a>
										<a href="javascript: void(0);" class="red hiddenReply" replyId="${replyComment.id}">[<@s.text name="comment.view.close"/>]</a>
									<#else>
										<a href="javascript: void(0);" class="red showReply" replyId="${replyComment.id}">[<@s.text name="comment.view.show"/>]</a>
										<a href="javascript: void(0);" class="red hidden hiddenReply" replyId="${replyComment.id}">[<@s.text name="comment.view.close"/>]</a>
									</#if>
								</td>
							</tr>
							<tr class="${replyComment.id}">
								<th>
									<@s.text name="comment.view.reply.content"/>: 
								</th>
								<td>
									${replyComment.content}
								</td>
							</tr>
							<tr class="${replyComment.id}">
								<th>
									<@s.text name="comment.view.reply.time"/>: 
								</th>
								<td>
									${replyComment.createDate?string("yyyy-MM-dd HH: mm")}
								</td>
							</tr>
							<#if replyComment_has_next>
								<tr class="${replyComment.id}">
									<td colspan="2">
										&nbsp;
									</td>
								</tr>
							</#if>
						</#list>
					</table>
				</#if>
				<div class="blank"></div>
				<table class="inputTable">
					<tr>
						<th colspan="2" class="title">
							<@s.text name="comment.view.reply.admin"/>
						</th>
					</tr>
					<tr>
						<th>
							<@s.text name="comment.view.reply.content"/>: 
						</th>
						<td>
							<textarea name="comment.content" class="formTextarea"></textarea>
						</td>
					</tr>
				</table>
				<div class="buttonArea">
					<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
					<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
				</div>
			</div>
		</form>
	</div>
</body>
</html>