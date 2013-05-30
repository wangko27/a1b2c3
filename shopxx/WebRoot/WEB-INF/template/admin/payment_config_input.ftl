<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="payment.config.input.pagetitle"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/common/editor/kindeditor.js"></script>
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
			"paymentConfig.name": "required",
			<#if paymentConfig.paymentConfigType == "online">
				"paymentConfig.bargainorId": "required",
				"paymentConfig.bargainorKey": "required",
			</#if>
			"paymentConfig.paymentFee": {
				required: true,
				min: 0
			},
			"paymentConfig.orderList": "digits"
		},
		messages: {
			"paymentConfig.name": "<@s.text name="payment.config.message.name"/>",
			<#if paymentConfig.paymentConfigType == "online">
				"paymentConfig.bargainorId": "<@s.text name="payment.config.message.bargainorId"/>",
				"paymentConfig.bargainorKey": "<@s.text name="payment.config.message.bargainorKey"/>",
			</#if>
			"paymentConfig.paymentFee": {
				required: "<@s.text name="payment.config.message.paymentFee.required"/>",
				min: "<@s.text name="payment.config.message.paymentFee.min"/>"
			},
			"paymentConfig.orderList": "<@s.text name="payment.config.message.orderList"/>"
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
		<#if isAddAction><@s.text name="payment.config.input.title1"/><#else><@s.text name="payment.config.input.title2"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="common.validateErrorTitle"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>payment_config!save.action<#else>payment_config!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${id}" />
			<input type="hidden" name="paymentConfig.paymentConfigType" value="${paymentConfig.paymentConfigType}" />
			<input type="hidden" name="paymentConfig.paymentProductId" value="${paymentConfig.paymentProductId}" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="payment.config.paymentConfigType"/>: 
					</th>
					<td>
						<#if paymentConfig.paymentConfigType != "online">
							${action.getText("PaymentConfigType." + paymentConfig.paymentConfigType)}
						<#else>
							${paymentProduct.name}
						</#if>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="payment.config.name"/>: 
					</th>
					<td>
						<input type="text" name="paymentConfig.name" class="formText" value="${(paymentConfig.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<#if paymentConfig.paymentConfigType == "online">
					<tr>
						<th>
							${(payment.bargainorIdName)!bundle("payment.config.bargainorId")}: 
						</th>
						<td>
							<input type="text" name="paymentConfig.bargainorId" class="formText" value="${(paymentConfig.bargainorId)!}" />
							<label class="requireField">*</label>
						</td>
					</tr>
					<tr>
						<th>
							${(payment.bargainorKeyName)!bundle("payment.config.bargainorKey")}: 
						</th>
						<td>
							<input type="text" name="paymentConfig.bargainorKey" class="formText" value="${(paymentConfig.bargainorKey)!}" />
							<label class="requireField">*</label>
						</td>
					</tr>
				</#if>
				<tr>
					<th>
						<@s.text name="payment.config.paymentFeeType"/>: 
					</th>
					<td>
						<#list paymentFeeTypeList as list>
							<label class="requireField">
								<input type="radio" name="paymentConfig.paymentFeeType" value="${list}"<#if ((isAddAction && list == "scale") || list == paymentConfig.paymentFeeType)!> checked </#if>>
								${action.getText("PaymentFeeType." + list)}
							</label>
						</#list>
					</td>
				</tr>
					<th>
						<@s.text name="payment.config.paymentFee"/>: 
					</th>
					<td>
						<input type="text" name="paymentConfig.paymentFee" class="formText" value="${(paymentConfig.paymentFee)!"0"}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="payment.config.order"/>: 
					</th>
					<td>
						<input type="text" name="paymentConfig.orderList" class="formText" value="${(paymentConfig.orderList)!}" title="只允许输入零或正整数" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="payment.config.desc"/>: 
					</th>
					<td>
						<textarea name="paymentConfig.description" id="editor" class="editor">${(paymentConfig.description)!}</textarea>
					</td>
				</tr>
			</table>
			<div class="buttonArea">
				<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="button.name.cancel"/>" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>