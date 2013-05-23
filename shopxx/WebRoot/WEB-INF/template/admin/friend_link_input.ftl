<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="friend.link.input.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $validateForm = $("#validateForm");
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"friendLink.name": "required",
			"friendLink.url": "required",
			"logo": "imageFile",
			"friendLink.orderList": "digits"
		},
		messages: {
			"friendLink.name": "<@s.text name="friend.link.input.name"/>",
			"friendLink.url": "<@s.text name="friend.link.input.url"/>",
			"logo": "LOGO<@s.text name="goods.notify.javascript.email.error"/>",
			"friendLink.orderList": "<@s.text name="goods.specification.edit.order.tips"/>"
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
		<#if isAddAction><@s.text name="friend.link.input.add"/><#else><@s.text name="friend.link.input.edit"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="goods.specification.edit.errortitle"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>friend_link!save.action<#else>friend_link!update.action</#if>" enctype="multipart/form-data" method="post">
			<input type="hidden" name="id" value="${id}" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="friend.link.list.name"/>: 
					</th>
					<td>
						<input type="text" name="friendLink.name" class="formText" value="${(friendLink.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="friend.link.list.address"/>: 
					</th>
					<td>
						<input type="text" name="friendLink.url" class="formText" value="${(friendLink.url)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						LOGO: 
					</th>
					<td>
						<input type="file" name="logo" />
							<#if (friendLink.logoPath??)!>
								&nbsp;&nbsp;&nbsp;<a href="${base}${friendLink.logoPath}" target="_blank"><@s.text name="shipping.list.single.view"/></a>
							</#if>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="payment.config.order"/>: 
					</th>
					<td>
						<input type="text" name="friendLink.orderList" class="formText" value="${(friendLink.orderList)!}" title="<@s.text name="admin.category.article.require.positive"/>" />
					</td>
				</tr>
			</table>
			<div class="buttonArea">
				<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>