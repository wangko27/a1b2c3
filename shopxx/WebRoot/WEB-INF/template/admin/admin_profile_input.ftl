<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="profile.edit.title"/> - Powered By SHOP++</title>
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
			"currentPassword": {
				remote: "admin_profile!checkCurrentPassword.action"
			},
			"admin.password": {
				requiredTo: "#currentPassword",
				minlength: 4,
				maxlength: 	 20
			},
			"rePassword": {
				equalTo: "#password"
			},
			"admin.email": {
				required: true,
				email: true
			}
		},
		messages: {
			"currentPassword": {
				remote: "<@s.text name="profile.edit.password.error"/>"
			},
			"admin.password": {
				requiredTo: "<@s.text name="goods.password.input.new"/>",
				minlength: "<@s.text name="profile.edit.password.min4"/>",
				maxlength: 	 "<@s.text name="profile.edit.password.max20"/>"
			},
			"rePassword": {
				equalTo: "<@s.text name="goods.password.input.different"/>"
			},
			"admin.email": {
				required: "<@s.text name="goods.profile.input"/>E-mail",
				email: "E-mail<@s.text name="goods.profile.input.invalid"/>"
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
		<@s.text name="profile.edit.title"/>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="common.validateErrorTitle"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="admin_profile!update.action" method="post">
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="login.field.username"/>: 
					</th>
					<td>
						${(admin.username)!}
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="profile.edit.username"/>: 
					</th>
					<td>
						${(admin.name)!}
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="profile.edit.department"/>: 
					</th>
					<td>
						${(admin.department)!}
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="profile.edit.password.current"/>: 
					</th>
					<td>
						<input type="password" id="currentPassword" name="currentPassword" class="formText"  />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.notify.memberCenter.profile.password.new"/>: 
					</th>
					<td>
						<input type="password" id="password" name="admin.password" class="formText" title="<@s.text name="goods.notify.javascript.password.length"/>" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.notify.memberCenter.profile.password.renew"/>: 
					</th>
					<td>
						<input type="password" name="rePassword" class="formText" />
					</td>
				</tr>
				<tr>
					<th>
						E-mail: 
					</th>
					<td>
						<input type="text" name="admin.email" class="formText" value="${(admin.email)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						&nbsp;
					</th>
					<td>
						<span class="warnInfo"><span class="icon">&nbsp;</span><@s.text name="profile.edit.password.notice"/></span>
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