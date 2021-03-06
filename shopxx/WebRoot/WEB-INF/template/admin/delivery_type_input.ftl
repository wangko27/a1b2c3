<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="delivery.type.input.title"/> - Powered By SHOP++</title>
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
			"deliveryType.name": "required",
			"deliveryType.firstWeight": {
				required: true,
				digits: true
			},
			"deliveryType.continueWeight": {
				required: true,
				positiveInteger: true
			},
			"deliveryType.firstWeightPrice": {
				required: true,
				min: 0
			},
			"deliveryType.continueWeightPrice": {
				required: true,
				min: 0
			},
			"deliveryType.orderList": {
				digits: true
			}
		},
		messages: {
			"deliveryType.name": "<@s.text name="delivery.type.input.name"/>",
			"deliveryType.firstWeight": {
				required: "<@s.text name="delivery.type.input.firstWeight"/>",
				digits: "<@s.text name="delivery.type.input.firstWeight.require"/>"
			},
			"deliveryType.continueWeight": {
				required: "<@s.text name="delivery.type.input.continueWeight"/>",
				positiveInteger: "<@s.text name="delivery.type.input.continueWeight.require"/>"
			},
			"deliveryType.firstWeightPrice": {
				required: "<@s.text name="delivery.type.input.firstPrice"/>",
				min: "<@s.text name="delivery.type.input.firstPrice.require"/>"
			},
			"deliveryType.continueWeightPrice": {
				required: "<@s.text name="delivery.type.input.continuePrice"/>",
				min: "<@s.text name="delivery.type.input.continuePrice.require"/>"
			},
			"deliveryType.orderList": {
				digits: "<@s.text name="goods.specification.edit.order.tips"/>"
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
		<#if isAddAction><@s.text name="delivery.type.input.add"/><#else><@s.text name="delivery.type.input.edit"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>delivery_type!save.action<#else>delivery_type!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${id}" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="shipping.deliveryTypeName"/>: 
					</th>
					<td>
						<input type="text" name="deliveryType.name" class="formText" value="${(deliveryType.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="delivery.type.list.type"/>: 
					</th>
					<td>
						<select name="deliveryType.deliveryMethod">
							<#list deliveryMethodList as deliveryMethod>
								<option value="${deliveryMethod}"<#if (deliveryMethod == deliveryType.deliveryMethod)!> selected</#if>>
									${action.getText("DeliveryMethod." + deliveryMethod)}
								</option>
							</#list>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="delivery.type.input.company.default"/>: 
					</th>
					<td>
						<select name="deliveryType.defaultDeliveryCorp.id">
							<option value=""><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
							<#list allDeliveryCorpList as deliveryCorp>
								<option value="${deliveryCorp.id}" <#if (deliveryCorp == deliveryType.defaultDeliveryCorp)!> selected</#if>>
									${deliveryCorp.name}
								</option>
							</#list>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="delivery.type.input.first"/>: 
					</th>
					<td>
						<input type="text" name="deliveryType.firstWeight" class="formText" value="${(deliveryType.firstWeight)!}" title="<@s.text name="delivery.type.input.unit"/>: <@s.text name="goods.common.unit.gram"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="delivery.type.input.continue"/>: 
					</th>
					<td>
						<input type="text" name="deliveryType.continueWeight" class="formText" value="${(deliveryType.continueWeight)!}" title="<@s.text name="delivery.type.input.unit"/>: <@s.text name="goods.common.unit.gram"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="delivery.type.list.weightPrice"/>: 
					</th>
					<td>
						<input type="text" name="deliveryType.firstWeightPrice" class="formText" value="${(deliveryType.firstWeightPrice)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="delivery.type.list.continueweight"/>: 
					</th>
					<td>
						<input type="text" name="deliveryType.continueWeightPrice" class="formText" value="${(deliveryType.continueWeightPrice)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.specification.list.search.result.header.order"/>: 
					</th>
					<td>
						<input type="text" name="deliveryType.orderList" class="formText" value="${(deliveryType.orderList)!}" title="<@s.text name="admin.category.article.require.positive"/>" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="payment.config.desc"/>: 
					</th>
					<td>
						<textarea name="deliveryType.description" id="editor" class="editor">${(deliveryType.description)!}</textarea>
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