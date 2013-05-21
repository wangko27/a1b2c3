<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("goods.notify.memberCenter.message.send")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/shop/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/shop.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/base.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/shop.js"></script>
<!--[if lte IE 6]>
	<script type="text/javascript" src="${base}/template/common/js/belatedPNG.js"></script>
	<script type="text/javascript">
		// 解决IE6透明PNG图片BUG
		DD_belatedPNG.fix(".belatedPNG");
	</script>
<![endif]-->
<script type="text/javascript">
$().ready( function() {
	
	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $messageForm = $("#messageForm");
	
	var $messageType = $(".messageType");
	var $toMemberTr = $("#toMemberTr");
	var $toMemberUsername = $("#toMemberUsername");
	
	$messageType.click( function(event) {
		if ($(this).val() == "member") {
			$toMemberTr.show();
			$toMemberUsername.attr("disabled", false);
		} else {
			$toMemberTr.hide();
			$toMemberUsername.attr("disabled", true);
		}
	});
	
	// 表单验证
	$messageForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"toMemberUsername": {
				"required": true,
				"notEqual": "${loginMember.username}",
				"remote": "message!checkUsername.action"
			},
			"message.title": "required",
			"message.content": "required"
		},
		messages: {
			"toMemberUsername": {
				"required": "${bundle("goods.message.send.username.require")}",
				"notEqual": "${bundle("goods.message.send.username.notme")}",
				"remote": "${bundle("goods.message.send.username.notexist")}"
			},
			"message.title": "${bundle("goods.message.reply.title.input")}",
			"message.content": "${bundle("goods.message.reply.title.context")}"
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
});
</script>
</head>
<body class="memberCenter">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body messageSend">
		<div class="bodyLeft">
			<div class="memberInfo">
				<div class="top"></div>
				<div class="middle">
					<p>${bundle("goods.notify.memberCenter.welcome")}!&nbsp;&nbsp;<span class="username">${loginMember.username}</span>&nbsp;&nbsp;[<a class="userLogout" href="member!logout.action"">${bundle("goods.common.logout")}</a>]</p>
					<p>${bundle("goods.notify.memberCenter.memberLevel")}: <span class="red"> ${loginMember.memberRank.name}</span></p>
				</div>
				<div class="bottom"></div>
			</div>
			<div class="blank"></div>
			<div class="memberMenu">
				<div class="top">
					<a href="member_center!index.action">${bundle("goods.notify.memberCenter.mainPage")}</a>
				</div>
				<div class="middle">
					<ul>
	                	<li class="order">
	                    	<ul>
	                        	<li><a href="order!list.action">${bundle("goods.notify.memberCenter.myOrder")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="category favorite">
	                    	<ul>
	                        	<li><a href="favorite!list.action">${bundle("goods.notify.memberCenter.favorite")}</a></li>
	                        	<li><a href="goods_notify!list.action">${bundle("goods.notify.memberCenter.notify")}</a></li>
	                        </ul>
	                    </li>
	                  	<li class="message">
	                    	<ul>
	                        	<li class="current"><a href="message!send.action">${bundle("goods.notify.memberCenter.message.send")}</a></li>
	                            <li><a href="message!inbox.action">${bundle("goods.notify.memberCenter.message.inbox")}</a></li>
	                            <li><a href="message!draftbox.action">${bundle("goods.notify.memberCenter.message.draftbox")}</a></li>
	                            <li><a href="message!outbox.action">${bundle("goods.notify.memberCenter.message.outbox")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="profile">
	                    	<ul>
	                        	<li><a href="profile!edit.action">${bundle("goods.notify.memberCenter.profile.profile")}</a></li>
	                            <li><a href="password!edit.action">${bundle("goods.notify.memberCenter.profile.password")}</a></li>
	                            <li><a href="receiver!list.action">${bundle("goods.notify.memberCenter.profile.receiver")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="deposit">
	                    	<ul>
	                    		<li><a href="deposit!list.action">${bundle("goods.notify.memberCenter.deposit.store")}</a></li>
	                        	<li><a href="deposit!recharge.action">${bundle("goods.notify.memberCenter.deposit.charge")}</a></li>
	                        </ul>
	                    </li>
	                </ul>
				</div>
				<div class="bottom"></div>
			</div>
		</div>
		<div class="bodyRight">
			<div class="memberCenterDetail">
				<div class="top">${bundle("goods.notify.memberCenter.message.send")}</div>
				<div class="middle">
					<div id="validateErrorContainer" class="validateErrorContainer">
						<div class="validateErrorTitle">${bundle("goods.message.reply.title.error.validate")}</div>
						<ul></ul>
					</div>
					<div class="blank"></div>
					<form id="messageForm" action="message!save.action" method="post">
						<table class="inputTable">
							<tr>
								<th>
									${bundle("goods.message.send.to")}: 
								</th>
								<td>
									<label><input type="radio" name="messageType" class="messageType" value="member"<#if (message == null || message.toMember??)!> checked</#if>>${bundle("goods.content.bottom.comment.other")}</label>
									<label><input type="radio" name="messageType" class="messageType" value="admin"<#if (message.toMember == null)!> checked</#if>>${bundle("goods.content.bottom.comment.admin")}</label>
								</td>
							</tr>
							<tr id="toMemberTr"<#if (!message.toMember??)!> class="hidden"</#if>>
								<th>
									${bundle("goods.message.send.username")}: 
								</th>
								<td>
									<input type="text" id="toMemberUsername" name="toMemberUsername" class="formText"<#if (!message.toMember??)!> disabled</#if> />
									<label class="requireField">*</label>
								</td>
							</tr>
							<tr>
								<th>
									${bundle("goods.message.push.title")}: 
								</th>
								<td>
									<input type="text" name="message.title" class="formText" value="${(message.title)!}" />
									<label class="requireField">*</label>
								</td>
							</tr>
							<tr>
								<th>
									${bundle("goods.message.context")}: 
								</th>
								<td>
									<textarea name="message.content" class="formTextarea" rows="5" cols="50">${(message.content)!}</textarea>
									<label class="requireField">*</label>
								</td>
							</tr>
							<tr>
								<th>
									${bundle("goods.message.radio")}: 
								</th>
								<td>
									<label><input type="radio" name="message.isSaveDraftbox" value="false" checked>${bundle("goods.message.push.send")}</label>
									<label><input type="radio" name="message.isSaveDraftbox" value="true">${bundle("goods.message.push.draftbox")}</label>
								</td>
							</tr>
							<tr>
								<th>
									&nbsp;
								</th>
								<td>
									<input type="submit" class="submitButton" value="${bundle("goods.message.push.submit")}" hidefocus />
								</td>
							</tr>
						</table>
					</form>
					<div class="blank"></div>
				</div>
				<div class="bottom"></div>
			</div>
		</div>
		<div class="blank"></div>
		<#include "/WEB-INF/template/shop/friend_link.ftl">
	</div>
	<div class="blank"></div>
	<#include "/WEB-INF/template/shop/footer.ftl">
</body>
</html>