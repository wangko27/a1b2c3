<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="goods.specification.edit.pagetitle"/> - Powered By SHOP++</title>
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

	var $specificationTable = $("#specificationTable");
	var $specificationSpecificationType = $("#specificationSpecificationType");
	var $addSpecificationValueButton = $("#addSpecificationValueButton");
	
	// 变更商品规格类型
	$specificationSpecificationType.change( function() {
		if ($(this).val() == "text") {
			$("#specificationTable :file").attr("disabled", true);
		} else {
			$("#specificationTable :file").attr("disabled", false);
		}
	})

	// 增加商品规格值
	var specificationValueIndex = ${(specification.specificationValueList?size)!1};
	$addSpecificationValueButton.click( function() {
		
		if ($specificationSpecificationType.val() == "text") {
			<@compress single_line = true>
				var specificationValueTrHtml = 
				'<tr class="specificationValueTr">
					<td>
						&nbsp;
					</td>
					<td>
						<input type="text" name="specificationValueList[' + specificationValueIndex + '].name" class="formText specificationValueListName" />
					</td>
					<td>
						<input type="file" name="specificationValueImageList[' + specificationValueIndex + ']" class="specificationValueImageList" disabled />
					</td>
					<td>
						<input type="text" name="specificationValueList[' + specificationValueIndex + '].orderList" class="formText specificationValueListOrderList" style="width: 30px;" />
					</td>
					<td>
						<span class="deleteIcon deleteSpecificationValueIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
					</td>
				</tr>';
			</@compress>
		} else {
			<@compress single_line = true>
				var specificationValueTrHtml = 
				'<tr class="specificationValueTr">
					<td>
						&nbsp;
					</td>
					<td>
						<input type="text" name="specificationValueList[' + specificationValueIndex + '].name" class="formText specificationValueListName" />
					</td>
					<td>
						<input type="file" name="specificationValueImageList[' + specificationValueIndex + ']" class="specificationValueImageList" />
					</td>
					<td>
						<input type="text" name="specificationValueList[' + specificationValueIndex + '].orderList" class="formText specificationValueListOrderList" style="width: 30px;" />
					</td>
					<td>
						<span class="deleteIcon deleteSpecificationValueIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
					</td>
				</tr>';
			</@compress>
		}
		
		$specificationTable.append(specificationValueTrHtml);
		specificationValueIndex ++;
	});
	
	// 删除商品规格值
	$("#specificationTable .deleteSpecificationValueIcon").live("click", function() {
		var $this = $(this);
		if ($specificationTable.find(".specificationValueTr").length <= 1) {
			$.dialog({type: "warn", content: "<@s.text name="goods.specification.edit.deletewarn"/>", modal: true, autoCloseTime: 3000});
		} else {
			$this.parent().parent().remove();
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
			"specification.name": "required",
			"specification.orderList": "digits"
		},
		messages: {
			"specification.name": "<@s.text name="goods.specification.edit.name.tips"/>",
			"specification.orderList": "<@s.text name="goods.specification.edit.order.tips"/>"
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
	$.validator.addMethod("specificationValueListNameRequired", $.validator.methods.required, "<@s.text name="goods.specification.edit.message.value.required"/>");
	$.validator.addMethod("specificationValueImageListImageFile", $.validator.methods.imageFile, "<@s.text name="goods.specification.edit.message.value.imageFile"/>");
	$.validator.addMethod("specificationValueListOrderListDigits", $.validator.methods.digits, "<@s.text name="goods.specification.edit.message.value.digits"/>");
	
	$.validator.addClassRules("specificationValueListName", {
		specificationValueListNameRequired: true
	});
	$.validator.addClassRules("specificationValueImageList", {
		specificationValueImageListImageFile: true
	});
	$.validator.addClassRules("specificationValueListOrderList", {
		specificationValueListOrderListDigits: true
	});

});
</script>
</head>
<body class="input specification">
	<div class="bar">
		<#if isAddAction><@s.text name="goods.specification.edit.bar1"/><#else><@s.text name="goods.specification.edit.bar2"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="goods.specification.edit.errortitle"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>specification!save.action<#else>specification!update.action</#if>" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${id}" />
			<table id="specificationTable" class="inputTable">
				<tr class="titleTr">
					<th>
						<@s.text name="goods.specification.list.search.result.header.name"/>: 
					</th>
					<td colspan="4">
						<input type="text" name="specification.name" class="formText" value="${(specification.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.specification.list.search.result.header.type"/>: 
					</th>
					<td colspan="4">
						<select id="specificationSpecificationType" name="specification.specificationType">
							<#list specificationTypeList as list>
								<option value="${list}"<#if (list == specification.specificationType)!> selected</#if>>
									${action.getText("SpecificationType." + list)}
								</option>
							</#list>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.specification.header.memo"/>: 
					</th>
					<td colspan="4">
						<input type="text" name="specification.memo" class="formText" value="${(specification.memo)!}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.specification.list.search.result.header.order"/>: 
					</th>
					<td colspan="4">
						<input type="text" name="specification.orderList" class="formText" value="${(specification.orderList)!}" />
					</td>
				</tr>
				<#if (specification.goodsSet?? && specification.goodsSet?size > 0)!>
					<th>&nbsp;</th>
					<td colspan="4">
						<span class="warnInfo"><@s.text name="goods.specification.edit.warn"/></span>
					</td>
				</#if>
				<tr class="noneHover">
					<th>&nbsp;</th>
					<td colspan="4">
						<input type="button" id="addSpecificationValueButton" class="formButton" value="<@s.text name="goods.specification.edit.button"/>" hidefocus />
					</td>
				</tr>
				<tr class="title">
					<th>
						&nbsp;
					</th>
					<td>
						<@s.text name="goods.specification.header.name"/>
					</td>
					<td>
						<@s.text name="goods.specification.header.pic"/>
					</td>
					<td>
						<@s.text name="goods.specification.list.search.result.header.order"/>
					</td>
					<td>
						<@s.text name="goods.specification.list.search.result.header.delete"/>
					</td>
				</tr>
				<#if isAddAction>
					<tr class="specificationValueTr">
						<td>
							&nbsp;
						</td>
						<td>
							<input type="text" name="specificationValueList[0].name" class="formText specificationValueListName" />
						</td>
						<td>
							<input type="file" name="specificationValueImageList[0]" class="specificationValueImageList" disabled />
						</td>
						<td>
							<input type="text" name="specificationValueList[0].orderList" class="formText specificationValueListOrderList" style="width: 30px;" />
						</td>
						<td>
							<span class="deleteIcon deleteSpecificationValueIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
						</td>
					</tr>
				</#if>
				<#if (specification.goodsSet?? && specification.goodsSet?size > 0)!>
					<#list (specification.specificationValueList)! as specificationValue>
						<tr class="specificationValueTr">
							<td>
								<input type="hidden" name="specificationValueList[${specificationValue_index}].id" value="${specificationValue.id}" />
								<input type="hidden" name="specificationValueList[${specificationValue_index}].imagePath" value="${specificationValue.imagePath}" />
								<input type="hidden" name="specificationValueList[${specificationValue_index}].name" value="${specificationValue.name}" />
							</td>
							<td>
								<input type="text" name="specificationValueList.name" class="formText" value="${specificationValue.name}" title="<@s.text name="goods.specification.other.title"/>" disabled />
							</td>
							<td>
								<#if (specification.specificationType == "text")!>
									<input type="file" name="specificationValueImageList[${specificationValue_index}]" class="specificationValueImageList" disabled />
								<#else>
									<input type="file" name="specificationValueImageList[${specificationValue_index}]" class="specificationValueImageList" />
								</#if>
								<#if specificationValue.imagePath??>
									&nbsp;&nbsp;<img src="${base}${specificationValue.imagePath}" style="width: 20px; height: 20px; padding: 1px; vertical-align: middle; border: 1px solid #b2d3f4;" />
								<#else>
									&nbsp;&nbsp;<img src="${base}/template/shop/images/default_specification.gif" style="width: 20px; height: 20px; padding: 1px; vertical-align: middle; border: 1px solid #b2d3f4;" title="无规格图片" />
								</#if>
							</td>
							<td>
								<input type="text" name="specificationValueList[${specificationValue_index}].orderList" class="formText specificationValueListOrderList" value="${specificationValue.orderList}" style="width: 30px;" />
							</td>
							<td>
								<span class="deleteIcon" title="<@s.text name="goods.specification.other.title"/>">&nbsp;</span>
							</td>
						</tr>
					</#list>
				<#else>
					<#list (specification.specificationValueList)! as specificationValue>
						<tr class="specificationValueTr">
							<td>
								<input type="hidden" name="specificationValueList[${specificationValue_index}].id" value="${specificationValue.id}" />
								<input type="hidden" name="specificationValueList[${specificationValue_index}].imagePath" value="${specificationValue.imagePath}" />
							</td>
							<td>
								<input type="text" name="specificationValueList[${specificationValue_index}].name" class="formText specificationValueListName" value="${specificationValue.name}" />
							</td>
							<td>
								<#if (specification.specificationType == "text")!>
									<input type="file" name="specificationValueImageList[${specificationValue_index}]" class="specificationValueImageList" disabled />
								<#else>
									<input type="file" name="specificationValueImageList[${specificationValue_index}]" class="specificationValueImageList" />
								</#if>
								<#if specificationValue.imagePath??>
									&nbsp;&nbsp;<img src="${base}${specificationValue.imagePath}" style="width: 20px; height: 20px; padding: 1px; vertical-align: middle; border: 1px solid #b2d3f4;" />
								<#else>
									&nbsp;&nbsp;<img src="${base}/template/shop/images/default_specification.gif" style="width: 20px; height: 20px; padding: 1px; vertical-align: middle; border: 1px solid #b2d3f4;" title="<@s.text name="goods.specification.other.title2"/>" />
								</#if>
							</td>
							<td>
								<input type="text" name="specificationValueList[${specificationValue_index}].orderList" class="formText specificationValueListOrderList" value="${specificationValue.orderList}" style="width: 30px;" />
							</td>
							<td>
								<span class="deleteIcon deleteSpecificationValueIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
							</td>
						</tr>
					</#list>
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