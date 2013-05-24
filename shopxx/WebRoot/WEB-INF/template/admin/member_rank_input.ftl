<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="member.rank.input.pagetitle"/> - Powered By SHOP++</title>
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
			"memberRank.name": {
				required: true,
				<#if isAddAction>
					remote: "member_rank!checkName.action"
				<#else>
					remote: "member_rank!checkName.action?oldValue=${memberRank.name?url}"
				</#if>
			},
			"memberRank.preferentialScale": {
				required: true,
				min: 0
			},
			"memberRank.score": {
				required: true,
				digits: true
			}
		},
		messages: {
			"memberRank.name": {
				required: "<@s.text name="member.rank.messages.name.required"/>",
				remote: "<@s.text name="member.rank.messages.name.remote"/>"
			},
			"memberRank.preferentialScale": {
				required: "<@s.text name="member.rank.messages.preferentialScale.required"/>",
				min: "<@s.text name="member.rank.messages.preferentialScale.min"/>"
			},
			"memberRank.score": {
				required: "<@s.text name="member.rank.messages.score.required"/>",
				digits: "<@s.text name="member.rank.messages.score.digits"/>"
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
		<#if isAddAction><@s.text name="member.rank.input.bar1"/><#else><@s.text name="member.rank.input.bar2"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="common.validateErrorTitle"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>member_rank!save.action<#else>member_rank!update.action</#if>" method="post">
			<table class="inputTable">
				<input type="hidden" name="id" value="${id}" />
				<tr>
					<th>
						<@s.text name="member.rank.name"/>: 
					</th>
					<td>
						<input type="text" name="memberRank.name" class="formText" value="${(memberRank.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="member.rank.preferentialScale"/>: 
					</th>
					<td>
						<input type="text" name="memberRank.preferentialScale" class="formText" value="${(memberRank.preferentialScale)!"100"}" title="<@s.text name="member.rank.preferentialScale.title"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="member.rank.score"/>: 
					</th>
					<td>
						<input type="text" name="memberRank.score" class="formText" value="${(memberRank.score)!}" title="<@s.text name="member.rank.score.title"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="member.rank.setting"/>: 
					</th>
					<td>
						<label>
							<@checkbox name="memberRank.isDefault" value="${(memberRank.isDefault)!false}" /><@s.text name="member.rank.isDefault.yes"/>
						</label>
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