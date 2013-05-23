<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="admin.input.title"/> - Powered By SHOP++</title>
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
$().ready( function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $validateForm = $("#validateForm");
	
	var $tab = $("#tab");

	// Tab效果
	$tab.tabs(".tabContent", {
		tabs: "input"
	});
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			<#if isAddAction>
				"admin.username": {
					required: true,
					username: true,
					minlength: 2,
					maxlength: 	 20,
					remote: "admin!checkUsername.action"
				},
			</#if>
			"admin.password": {
				<#if isAddAction>
					required: true,
				</#if>
				minlength: 4,
				maxlength: 	 20
			},
			"rePassword": {
				<#if isAddAction>
					required: true,
				</#if>
				equalTo: "#password"
			},
			"admin.email": {
				required: true,
				email: true
			},
			"roleList.id": "required"
		},
		messages: {
			<#if isAddAction>
				"admin.username": {
					required: "<@s.text name="admin.input.admin.username"/>",
					username: "<@s.text name="admin.input.admin.username.require"/>",
					minlength: "<@s.text name="admin.input.admin.username.require.min"/>",
					maxlength: 	 "<@s.text name="admin.input.admin.username.require.max"/>",
					remote: "<@s.text name="admin.input.admin.username.require.exist"/>"
				},
			</#if>
			"admin.password": {
				<#if isAddAction>
					required: "<@s.text name="admin.input.admin.password"/>",
				</#if>
				minlength: "<@s.text name="profile.edit.password.min4"/>",
				maxlength: 	 "<@s.text name="profile.edit.password.max20"/>"
			},
			"rePassword": {
				<#if isAddAction>
					required: "<@s.text name="admin.input.admin.repassword"/>",
				</#if>
				equalTo: "<@s.text name="goods.password.input.different"/>"
			},
			"admin.email": {
				required: "<@s.text name="goods.profile.input"/>E-mail",
				email: "E-mail<@s.text name="goods.profile.input.invalid"/>"
			},
			"roleList.id": "<@s.text name="admin.input.admin.role.choose"/>"
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});

});
</script>
</head>
<body class="input admin">
	<div class="bar">
		<#if isAddAction><@s.text name="admin.list.add"/><#else><@s.text name="admin.list.edit"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>admin!save.action<#else>admin!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${id}" />
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="<@s.text name="goods.compare.head1"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="page.header.menu.profile"/>" hidefocus />
				</li>
			</ul>
			<table class="inputTable tabContent">
				<tr>
					<th>
						<@s.text name="member.username"/>: 
					</th>
					<td>
						<#if isAddAction>
							<input type="text" name="admin.username" class="formText" title="<@s.text name="admin.input.admin.username.require"/>" />
							<label class="requireField">*</label>
						<#else>
							${(admin.username)!}
							<input type="hidden" name="admin.username" class="formText" value="${(admin.username)!}" />
						</#if>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.common.password"/>: 
					</th>
					<td>
						<input type="password" name="admin.password" id="password" class="formText" title="<@s.text name="goods.common.password.require"/>" />
						<#if isAddAction><label class="requireField">*</label></#if>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.common.repassword"/>: 
					</th>
					<td>
						<input type="password" name="rePassword" class="formText" />
						<#if isAddAction><label class="requireField">*</label></#if>
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
				<tr class="roleList">
					<th>
						<@s.text name="admin.input.admin.role"/>: 
					</th>
					<td>
						<#assign roleSet = (admin.roleSet)! />
						<#list allRoleList as role>
							<label>
								<input type="checkbox" name="roleList.id" value="${role.id}"<#if (roleSet.contains(role))!> checked</#if> />${role.name}
							</label>
						</#list>
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.common.setting"/>: 
					</th>
					<td>
						<label>
							<@checkbox name="admin.isAccountEnabled" value="${(admin.isAccountEnabled)!true}" /><@s.text name="setting.isGzipEnabled"/>
						</label>
					</td>
				</tr>
				<#if isEditAction>
					<tr>
						<th>&nbsp;</th>
						<td>
							<span class="warnInfo"><span class="icon">&nbsp;</span><@s.text name="admin.input.admin.password.modifyNotice"/>!</span>
						</td>
					</tr>
				</#if>
			</table>
			<table class="inputTable tabContent">
				<tr>
					<th>
						<@s.text name="admin.input.admin.department"/>: 
					</th>
					<td>
						<input type="text" name="admin.department" class="formText" value="${(admin.department)!}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.list.name"/>: 
					</th>
					<td>
						<input type="text" name="admin.name" class="formText" value="${(admin.name)!}" />
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