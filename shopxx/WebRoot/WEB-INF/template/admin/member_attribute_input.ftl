<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="member.attribute.input.pagetitle"/>  - Powered By SHOP++</title>
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

	var $memberAttributeTable = $("#memberAttributeTable");
	var $memberAttributeType = $("#memberAttributeType");
	var $addOptionButton = $("#addOptionButton");
	var $deleteOptionIcon = $("#memberAttributeTable .deleteOptionIcon");
	
	// 显示/隐藏“增加选项”按钮
	$memberAttributeType.change(function() {
		if($memberAttributeType.val() == "select" || $memberAttributeType.val() == "checkbox") {
			$memberAttributeTable.find(".optionTr").remove();
			$addOptionButton.show();
			addOption();
		} else {
			$addOptionButton.hide();
			$memberAttributeTable.find(".optionTr").remove();
		}
	})
	
	// 增加选项内容
	$addOptionButton.click( function() {
		addOption();
	});
		
	// 删除选项内容
	$("#memberAttributeTable .deleteOptionIcon").live("click", function() {
		if ($memberAttributeTable.find(".optionTr").length <= 1) {
			$.dialog({type: "warn", content: "<@s.text name="memberAttribute.messages.content"/>", modal: true, autoCloseTime: 3000});
		} else {
			$(this).parent().parent().remove();
		}
	});
	
	// 增加选项内容
	function addOption() {
		<@compress single_line = true>
			var optionTrHtml = 
			'<tr class="optionTr">
				<th><@s.text name="memberAttribute.content"/>: </th>
				<td>
					<input type="text" name="optionList" class="formText optionList" />&nbsp;
					<span class="deleteIcon deleteOptionIcon" title="<@s.text name="common.button.delete"/>">&nbsp;</span>
				</td>
			</tr>';
		</@compress>
		
		$memberAttributeTable.append(optionTrHtml);
	}
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"memberAttribute.attributeType": "required",
			"memberAttribute.name": "required",
			"memberAttribute.orderList": "digits"
		},
		messages: {
			"memberAttribute.attributeType": "<@s.text name="memberAttribute.messages.attributeType"/>",
			"memberAttribute.name": "<@s.text name="memberAttribute.messages.name"/>",
			"memberAttribute.orderList": "<@s.text name="memberAttribute.messages.orderList"/>"
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
	$.validator.addMethod("optionListRequired", $.validator.methods.required, "<@s.text name="memberAttribute.messages.content.required"/>");
	
	$.validator.addClassRules("optionList", {
		optionListRequired: true
	});

})
</script>
</head>
<body class="input">
	<div class="bar">
		<#if isAddAction><@s.text name="member.attribute.input.bar1"/><#else><@s.text name="member.attribute.input.bar2"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="common.validateErrorTitle"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>member_attribute!save.action<#else>member_attribute!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${id}" />
			<table id="memberAttributeTable" class="inputTable">
				<tr>
					<th>
						<@s.text name="memberAttribute.systemAttributeType"/>: 
					</th>
					<td>
						<#if isAddAction>
							<#if (memberAttribute.systemAttributeType)??>
								${action.getText("SystemAttributeType." + memberAttribute.systemAttributeType)} [<@s.text name="memberAttribute.systemAttributeType.default"/>]
							<#else>
								<select id="memberAttributeType" name="memberAttribute.attributeType">
									<option value=""><@s.text name="common.tips.select"/></option>
									<#list attributeTypeList as attributeType>
										<option value="${attributeType}"<#if (attributeType == memberAttribute.attributeType)!> selected</#if>>
											${action.getText("AttributeType." + attributeType)}
										</option>
									</#list>
								</select>
								<label class="requireField">*</label>
							</#if>
						<#else>
							<#if memberAttribute.systemAttributeType??>
								${action.getText("SystemAttributeType." + memberAttribute.systemAttributeType)}
								[<@s.text name="memberAttribute.systemAttributeType.default"/>]
							<#else>
								${action.getText("AttributeType." + memberAttribute.attributeType)}
							</#if>
						</#if>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="memberAttribute.name"/>: 
					</th>
					<td>
						<input type="text" name="memberAttribute.name" class="formText" value="${(memberAttribute.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="memberAttribute.orderList"/>: 
					</th>
					<td>
						<input type="text" name="memberAttribute.orderList" class="formText" value="${(memberAttribute.orderList)!}" title="<@s.text name="memberAttribute.orderList.title"/>" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="memberAttribute.setting"/>: 
					</th>
					<td>
						<label>
							<@checkbox name="memberAttribute.isEnabled" value="${(memberAttribute.isEnabled)!true}" /><@s.text name="memberAttribute.setting.enable"/>
						</label>
						<label>
							<@checkbox name="memberAttribute.isRequired" value="${(memberAttribute.isRequired)!false}" /><@s.text name="memberAttribute.setting.require"/>
						</label>
					</td>
				</tr>
				<#if (memberAttribute.systemAttributeType == "gender")!>
					<tr>
						<th><@s.text name="memberAttribute.content"/>: </th>
						<td>
							<label><input type="radio" name="gender" value="male" checked disabled /><@s.text name="common.gender.male"/></label>
							<label><input type="radio" name="gender" value="female" disabled /><@s.text name="common.gender.female"/></label>
						</td>
					</tr>
				</#if>
				<tr>
					<th>&nbsp;</th>
					<td>
						<#if (memberAttribute.attributeType == "select" || memberAttribute.attributeType == "checkbox")!>
							<input type="button" id="addOptionButton" class="formButton" value="<@s.text name="memberAttribute.input.button.add"/>" hidefocus />
						<#else>
							<input type="button" id="addOptionButton" class="hidden formButton" value="<@s.text name="memberAttribute.input.button.add"/>" hidefocus />
						</#if>
					</td>
				</tr>
				<#if (memberAttribute.attributeType == "select" || memberAttribute.attributeType == "checkbox")!>
					<#list memberAttribute.optionList as option>
						<tr class="optionTr">
							<th><@s.text name="memberAttribute.content"/>: </th>
							<td>
								<input type="text" name="optionList" class="formText optionList" value="${option}" />
								&nbsp;
								<span class="deleteIcon deleteOptionIcon" title="<@s.text name="common.button.delete"/>">&nbsp;</span>
							</td>
						</tr>
					</#list>
				</#if>
			</table>
			<div class="buttonArea">
				<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="button.name.confirm"/>" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>