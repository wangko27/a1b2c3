<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="leave.message.view"/> - Powered By SHOP++</title>
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
	
	var $deleteReply = $(".deleteReply");
	
	$deleteReply.click( function() {
		var $this = $(this);
		var replyId = $this.attr("replyId");
		$.dialog({type: "warn", content: "<@s.text name="goods.notify.javascript.deleteNotice"/>?", ok: "<@s.text name="goods.common.ok"/>", cancel: "<@s.text name="goods.common.cancel"/>", modal: true, okCallback: deleteReply});
		function deleteReply() {
			$.ajax({
				url: "leave_message!ajaxDeleteReply.action",
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
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"leaveMessage.title": {
				required: true
			},
			"leaveMessage.content": {
				required: true
			}
		},
		messages: {
			"leaveMessage.title": {
				required: "<@s.text name="leave.message.view.reply.title"/>"
			}, 
			"leaveMessage.content": {
				required: "<@s.text name="leave.message.view.reply.content"/>"
			}
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
	<div class="bar">
		<@s.text name="leave.message.view"/>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="leave_message!reply.action" method="post">
			<input type="hidden" name="id" value="${leaveMessage.id}" />
			<div class="tableItem">
				<table class="inputTable">
					<tr>
						<th colspan="2" class="title">
							<@s.text name="leave.message.view.leave.message"/>
						</th>
					</tr>
					<tr>
						<th>
							<@s.text name="leave.message.list.sender"/>: 
						</th>
						<td>
							${(leaveMessage.username)!"<@s.text name="comment.username.anonymous"/>"}
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="goods.message.push.title"/>: 
						</th>
						<td>
							${leaveMessage.title}
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="goods.message.context"/>: 
						</th>
						<td>
							${leaveMessage.content}
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="goods.content.bottom.comment.contact"/>: 
						</th>
						<td>
							${leaveMessage.contact}
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="leave.message.list.sender.date"/>: 
						</th>
						<td>
							${leaveMessage.createDate?string("yyyy-MM-dd HH:mm:ss")}
						</td>
					</tr>
					<tr>
						<th>
							IP: 
						</th>
						<td>
							${leaveMessage.ip}
						</td>
					</tr>
				</table>
				<#if (leaveMessage.replyLeaveMessageSet?? && leaveMessage.replyLeaveMessageSet?size > 0)>
					<div class="blank"></div>
					<table class="inputTable">
						<tr>
							<th colspan="2" class="title">
								<@s.text name="goods.common.reply"/>
							</th>
						</tr>
						<#list leaveMessage.replyLeaveMessageSet as replyLeaveMessage>
							<tr class="${replyLeaveMessage.id}">
								<th>
									<@s.text name="leave.message.view.title"/>: 
								</th>
								<td>
									${replyLeaveMessage.title}
									<a href="javascript: void(0);" class="red deleteReply" replyId="${replyLeaveMessage.id}">[<@s.text name="button.name.delete"/>]</a>
								</td>
							</tr>
							<tr class="${replyLeaveMessage.id}">
								<th>
									<@s.text name="comment.view.reply.time"/>: 
								</th>
								<td>
									${replyLeaveMessage.createDate?string("yyyy-MM-dd HH: mm")}
								</td>
							</tr>
							<tr class="${replyLeaveMessage.id}">
								<th>
									<@s.text name="comment.view.reply.content"/>: 
								</th>
								<td>
									${replyLeaveMessage.content}
								</td>
							</tr>
							<#if replyLeaveMessage_has_next>
								<tr class="${replyLeaveMessage.id}">
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
							<@s.text name="leave.message.view.title"/>: 
						</th>
						<td>
							<input type="text" name="leaveMessage.title" class="formText" />
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="comment.view.reply.content"/>: 
						</th>
						<td>
							<textarea name="leaveMessage.content" class="formTextarea"></textarea>
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