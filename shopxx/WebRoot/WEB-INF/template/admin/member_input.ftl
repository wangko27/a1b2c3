<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="member.input.pagetitle"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.lSelect.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/common/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready( function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $validateForm = $("#validateForm");

	var $areaSelect = $("#areaSelect");

	// 地区选择菜单
	$areaSelect.lSelect({
		url: "${base}/shop/area!ajaxArea.action"// AJAX数据获取url
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
				"member.username": {
					required: true,
					minlength: 2,
					maxlength: 20,
					username: true,
					remote: "member!checkUsername.action"
				},
			</#if>
			"member.password": {
				<#if isAddAction>
					required: true,
				</#if>
				minlength: 4,
				maxlength: 20
			},
			"rePassword": {
				<#if isAddAction>
					required: true,
				</#if>
				equalTo: "#password"
			},
			"member.email": {
				required: true,
				email: true
			},
			"member.score": {
				required: true,
				digits: true
			},
			"member.deposit": {
				required: true,
				min: 0
			}
			<#list memberAttributeList as memberAttribute>
				<#if memberAttribute.isRequired || memberAttribute.attributeType == "number" || memberAttribute.attributeType == "alphaint">
					,"memberAttributeValueMap['${memberAttribute.id}']": {
						<#if memberAttribute.isRequired>
							<#if memberAttribute.attributeType == "number" || memberAttribute.attributeType == "alphaint">
								required: true,
							<#else>
								required: true
							</#if>
						</#if>
						<#if memberAttribute.attributeType == "number">
							<#if memberAttribute.attributeType == "alphaint">
								number: true,
							<#else>
								number: true
							</#if>
						</#if>
						<#if memberAttribute.attributeType == "alphaint">
							lettersonly: true
						</#if>
					}
				</#if>
			</#list>
		},
		messages: {
			<#if isAddAction>
				"member.username": {
					required: "<@s.text name="member.username.required"/>",
					minlength: "<@s.text name="member.username.minlength"/>",
					maxlength: "<@s.text name="member.username.maxlength"/>",
					username: "<@s.text name="member.username.remote"/>",
					remote: "<@s.text name="member.username.remote"/>"
				},
			</#if>
			"member.password": {
				<#if isAddAction>
					required: "<@s.text name="member.password.required"/>",
				</#if>
				minlength: "<@s.text name="member.password.minlength"/>",
				maxlength: "<@s.text name="member.password.maxlength"/>"
			},
			"rePassword": {
				<#if isAddAction>
					required: "<@s.text name="member.rePassword.required"/>",
				</#if>
				equalTo: "<@s.text name="member.rePassword.equalTo"/>"
			},
			"member.email": {
				required: "<@s.text name="member.email.required"/>",
				email: "<@s.text name="member.email.email"/>"
			},
			"member.score": {
				required: "<@s.text name="member.score.required"/>",
				digits: "<@s.text name="member.score.digits"/>"
			},
			"member.deposit": {
				required: "<@s.text name="member.deposit.required"/>",
				min: "<@s.text name="member.deposit.min"/>"
			}
			<#list memberAttributeList as memberAttribute>
				<#if memberAttribute.isRequired || memberAttribute.attributeType == "number" || memberAttribute.attributeType == "alphaint">
					,"memberAttributeValueMap['${memberAttribute.id}']": {
						<#if memberAttribute.isRequired>
							<#if memberAttribute.attributeType == "number" || memberAttribute.attributeType == "alphaint">
								required: "<@s.text name="member.attribute.required"/>${memberAttribute.name}",
							<#else>
								required: "<@s.text name="member.attribute.required"/>${memberAttribute.name}"
							</#if>
						</#if>
						<#if memberAttribute.attributeType == "number">
							<#if memberAttribute.attributeType == "alphaint">
								number: "${memberAttribute.name}<@s.text name="member.attribute.digits"/>",
							<#else>
								number: "${memberAttribute.name}<@s.text name="member.attribute.digits"/>"
							</#if>
						</#if>
						<#if memberAttribute.attributeType == "alphaint">
							lettersonly: "${memberAttribute.name}<@s.text name="member.attribute.char"/>"
						</#if>
					}
				</#if>
			</#list>
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});

});
</script>
</head>
<body class="input">
	<div class="bar">
		<#if isAddAction><@s.text name="member.input.bar1"/><#else><@s.text name="member.input.bar2"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="common.validateErrorTitle"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>member!save.action<#else>member!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${id}" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="member.username"/>: 
					</th>
					<td>
						<#if isAddAction>
							<input type="text" name="member.username" class="formText" />
							<label class="requireField">*</label>
						<#else>
							${member.username}
							<input type="hidden" name="member.username" value="${(member.username)!}" />
						</#if>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="member.password"/>: 
					</th>
					<td>
						<input type="password" id="password" name="member.password" class="formText" />
						<#if isAddAction><label class="requireField">*</label></#if>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="member.rePassword"/>: 
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
						<input type="text" name="member.email" class="formText" value="${(member.email)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name=""/>member.score: 
					</th>
					<td>
						<input type="text" name="member.score" class="formText" value="${(member.score)!"0"}" title="<@s.text name="member.score.title"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="member.deposit"/>: 
					</th>
					<td>
						<input type="text" name="member.deposit" class="formText" value="${(member.deposit)!"0"}" title="<@s.text name="member.deposit.title"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="member.memberRank"/>
					</th>
					<td>
						<select name="member.memberRank.id">
							<#list allMemberRankList as memberRank>
								<option value="${memberRank.id}"<#if ((isAddAction && memberRank.isDefault) || (isEditAction && memberRank == member.memberRank))!> selected</#if>>${memberRank.name}</option>
							</#list>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="member.setting="/>: 
					</th>
					<td>
						<label>
							<@checkbox name="member.isAccountEnabled" value="${(member.isAccountEnabled)!true}" /><@s.text name="memberAttribute.setting.enable"/>
						</label>
					</td>
				</tr>
				<tr>
					<th>
						&nbsp;
					</th>
					<td>
						&nbsp;
					</td>
				</tr>
				<#if isEditAction>
					<tr>
						<th>
							<@s.text name="member.createDate"/>
						</th>
						<td>
							${(member.createDate?string("yyyy-MM-dd HH:mm:ss"))!}
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="member.registerIp"/>
						</th>
						<td>
							${(member.registerIp)!}
						</td>
					</tr>
				</#if>
				<#list memberAttributeList as memberAttribute>
					<tr>
						<th>
							${memberAttribute.name}: 
						</th>
						<td>
							<#if memberAttribute.systemAttributeType??>
								<#if memberAttribute.systemAttributeType == "name">
									<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								<#elseif memberAttribute.systemAttributeType == "gender">
									<label><input type="radio" name="memberAttributeValueMap['${memberAttribute.id}']" value="male"<#if (member.getMemberAttributeValue(memberAttribute) == "male")!> checked</#if> /><@s.text name="common.gender.male"/></label>
									<label><input type="radio" name="memberAttributeValueMap['${memberAttribute.id}']" value="female"<#if (member.getMemberAttributeValue(memberAttribute) == "female")!> checked</#if> /><@s.text name="common.gender.female"/></label>
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								<#elseif memberAttribute.systemAttributeType == "birth">
									<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" onclick="WdatePicker()" />
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								<#elseif memberAttribute.systemAttributeType == "area">
									<input type="text" id="areaSelect" name="memberAttributeValueMap['${memberAttribute.id}']" class="hidden" value="${(member.getMemberAttributeValue(memberAttribute).id)!}" defaultSelectedPath="${(member.getMemberAttributeValue(memberAttribute).path)!}" />
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								<#elseif memberAttribute.systemAttributeType == "address">
									<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								<#elseif memberAttribute.systemAttributeType == "zipCode">
									<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								<#elseif memberAttribute.systemAttributeType == "phone">
									<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								<#elseif memberAttribute.systemAttributeType == "mobile">
									<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								</#if>
							<#else>
								<#if memberAttribute.attributeType == "text">
									<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								<#elseif memberAttribute.attributeType == "number">
									<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								<#elseif memberAttribute.attributeType == "alphaint">
									<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								<#elseif memberAttribute.attributeType == "select">
									<select name="memberAttributeValueMap['${memberAttribute.id}']">
										<option value=""><@s.text name="common.tips.select"/></option>
										<#list memberAttribute.optionList as option>
											<option value="${option}"<#if (option == member.getMemberAttributeValue(memberAttribute))!> selected</#if>>
												${option}
											</option>
										</#list>
									</select>
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								<#elseif memberAttribute.attributeType == "checkbox">
									<#list memberAttribute.optionList as option>
										<label>
											<input type="checkbox" name="memberAttributeValueMap['${memberAttribute.id}']" value="${option}"<#if (member.getMemberAttributeValue(memberAttribute).contains(option))!> checked</#if> />${option}
										</label>
									</#list>
									<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
								</#if>
							</#if>
						</td>
					</tr>
				</#list>
				<#if isEditAction>
					<tr>
						<th>
							&nbsp;
						</th>
						<td>
							<span class="warnInfo"><span class="icon">&nbsp;</span><@s.text name="member.password.warn"/></span>
						</td>
					</tr>
				</#if>
			</table>
			<div class="buttonArea">
				<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>