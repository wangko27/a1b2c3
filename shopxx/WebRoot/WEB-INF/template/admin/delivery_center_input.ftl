<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="delivery.center.input.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.lSelect.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
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
			"deliveryCenter.name": "required",
			"deliveryCenter.consignor": "required",
			"areaId": "required",
			"deliveryCenter.address": "required"
		},
		messages: {
			"deliveryCenter.name": "<@s.text name="delivery.center.input.name"/>",
			"deliveryCenter.consignor": "<@s.text name="delivery.center.input.sender"/>",
			"areaId": "<@s.text name="goods.receiver.select.area"/>",
			"deliveryCenter.address": "<@s.text name="goods.receiver.input.address.fill"/>"
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
		<#if isAddAction><@s.text name="delivery.center.list.add"/><#else><@s.text name="delivery.center.list.edit"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>delivery_center!save.action<#else>delivery_center!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${(deliveryCenter.id)!}" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="delivery.center.list.name"/>: 
					</th>
					<td>
						<input type="text" name="deliveryCenter.name" class="formText" value="${(deliveryCenter.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="delivery.center.list.consignor"/>: 
					</th>
					<td>
						<input type="text" name="deliveryCenter.consignor" class="formText" value="${(deliveryCenter.consignor)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.common.area"/>: 
					</th>
					<td>
						<input type="text" id="areaSelect" name="areaId" class="hidden" value="${(deliveryCenter.area.id)!}" defaultSelectedPath="${(deliveryCenter.area.path)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.common.address"/>: 
					</th>
					<td>
						<input type="text" name="deliveryCenter.address" class="formText" value="${(deliveryCenter.address)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.order.ship.zipcode"/>: 
					</th>
					<td>
						<input type="text" name="deliveryCenter.zipCode" class="formText" value="${(deliveryCenter.zipCode)!}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.order.ship.phone"/>: 
					</th>
					<td>
						<input type="text" name="deliveryCenter.phone" class="formText" value="${(deliveryCenter.phone)!}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.order.ship.mobile"/>: 
					</th>
					<td>
						<input type="text" name="deliveryCenter.mobile" class="formText" value="${(deliveryCenter.mobile)!}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.common.setting"/>: 
					</th>
					<td>
						<label>
							<@checkbox name="deliveryCenter.isDefault" value="${(deliveryCenter.isDefault)!false}" /><@s.text name="delivery.template.isDefault"/>
						</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.specification.list.search.option2"/>: 
					</th>
					<td>
						<textarea name="deliveryCenter.memo" class="formTextarea">${(deliveryCenter.memo)!}</textarea>
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