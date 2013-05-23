<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="delivery.template.input.title"/> - Powered By SHOP++</title>
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
$().ready( function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $validateForm = $("#validateForm");
	var $deliveryTemplateTag = $("#deliveryTemplateTag");
	
	// 插入标签
	$deliveryTemplateTag.change( function() {
		var $this = $(this);
		if ($this.val() != "") {
			editor.insertHtml($this.val());
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
			"deliveryTemplate.name": "required",
			"deliveryTemplate.content": "required"
		},
		messages: {
			"deliveryTemplate.name": "<@s.text name="delivery.template.input.name"/>",
			"deliveryTemplate.content": "<@s.text name="delivery.template.input.content"/>"
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
		<#if isAddAction><@s.text name="delivery.template.input.add"/><#else><@s.text name="delivery.template.input.edit"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>delivery_template!save.action<#else>delivery_template!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${(deliveryTemplate.id)!}" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="printConfigTemplate.name"/>: 
					</th>
					<td>
						<input type="text" name="deliveryTemplate.name" class="formText" value="${(deliveryTemplate.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="delivery.template.input.insert"/>: 
					</th>
					<td>
						<#noparse>
							<select id="deliveryTemplateTag">
								<option value=""><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
								<option value="${deliveryCenter.name}"><@s.text name="delivery.center.list.consignor"/> - <@s.text name="admin.list.name"/></option>
								<option value="${deliveryCenter.area.displayName}"><@s.text name="delivery.center.list.consignor"/> - <@s.text name="goods.common.area"/></option>
								<option value="${deliveryCenter.address}"><@s.text name="delivery.center.list.consignor"/> - <@s.text name="goods.common.address"/></option>
								<option value="${deliveryCenter.zipCode}"><@s.text name="delivery.center.list.consignor"/> - <@s.text name="goods.order.ship.zipcode"/></option>
								<option value="${deliveryCenter.phone}"><@s.text name="delivery.center.list.consignor"/> - <@s.text name="goods.order.ship.phone"/></option>
								<option value="${deliveryCenter.mobile}"><@s.text name="delivery.center.list.consignor"/> - <@s.text name="goods.order.ship.mobile"/></option>
								<option value=""></option>
								<option value="${order.shipName}"><@s.text name="goods.order.ship.name"/> - <@s.text name="admin.list.name"/></option>
								<option value="${order.shipArea.displayName}"><@s.text name="goods.order.ship.name"/> - <@s.text name="goods.common.area"/></option>
								<option value="${order.shipAddress}"><@s.text name="goods.order.ship.name"/> - <@s.text name="goods.common.address"/></option>
								<option value="${order.shipZipCode}"><@s.text name="goods.order.ship.name"/> - <@s.text name="goods.order.ship.zipcode"/></option>
								<option value="${order.shipPhone}"><@s.text name="goods.order.ship.name"/> - <@s.text name="goods.order.ship.phone"/></option>
								<option value="${order.shipMobile}"><@s.text name="goods.order.ship.name"/> - <@s.text name="goods.order.ship.mobile"/></option>
								<option value=""></option>
								<option value="${currentYear}"><@s.text name="delivery.template.input.currentDate"/> - <@s.text name="delivery.template.date.year"/></option>
								<option value="${currentMonth}"><@s.text name="delivery.template.input.currentDate"/> - <@s.text name="delivery.template.date.month"/></option>
								<option value="${currentDay}"><@s.text name="delivery.template.input.currentDate"/> - <@s.text name="delivery.template.date.day"/></option>
								<option value=""></option>
								<option value="${order.orderSn}"><@s.text name="delivery.template.input.order"/> - <@s.text name="goods.notify.memberCenter.order.sn"/></option>
								<option value="${order.totalProductPrice}">}"><@s.text name="delivery.template.input.order"/> - <@s.text name="delivery.template.goods.payment"/></option>
								<option value="${order.deliveryFee}">}"><@s.text name="delivery.template.input.order"/> - <@s.text name="goods.order.price"/></option>
								<option value="${order.paymentFee}">}"><@s.text name="delivery.template.input.order"/> - <@s.text name="goods.payment.fee"/></option>
								<option value="${order.totalAmount}">}"><@s.text name="delivery.template.input.order"/> - <@s.text name="delivery.template.order.payment"/></option>
								<option value="${order.totalProductWeight}">}"><@s.text name="delivery.template.input.order"/> - <@s.text name="order.totalProductWeight"/></option>
								<option value="${order.totalProductQuantity}">}"><@s.text name="delivery.template.input.order"/> - <@s.text name="delivery.template.goods.total"/></option>
								<option value="${order.totalAmount}">}"><@s.text name="delivery.template.input.order"/> - <@s.text name="delivery.template.order.payment"/></option>
								<option value="${order.memo}">}"><@s.text name="delivery.template.input.order"/> - <@s.text name="order.memo"/></option>
								<option value=""></option>
								<option value="${setting.shopName}">}"><@s.text name="delivery.template.input.web"/> - <@s.text name="goods.specification.list.search.option1"/></option>
								<option value="${setting.shopUrl}"><@s.text name="delivery.template.input.web"/> - <@s.text name="brand.list.website"/></option>
								<option value="${setting.address}"><@s.text name="delivery.template.input.web"/> - <@s.text name="goods.common.address"/></option>
								<option value="${setting.phone}"><@s.text name="delivery.template.input.web"/> - <@s.text name="goods.order.ship.phone"/></option>
								<option value="${setting.zipCode}"><@s.text name="delivery.template.input.web"/> - <@s.text name="goods.order.ship.zipcode"/></option>
								<option value="${setting.email}"><@s.text name="delivery.template.input.web"/> - Email</option>
							</select>
						</#noparse>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="delivery.template.input.content"/>: 
					</th>
					<td>
						<textarea id="editor" name="deliveryTemplate.content" class="editor">${(deliveryTemplate.content)!}</textarea>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.common.setting"/>: 
					</th>
					<td>
						<label>
							<@checkbox name="deliveryTemplate.isDefault" value="${(deliveryTemplate.isDefault)!false}" /><@s.text name="delivery.template.isDefault"/>
						</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="refund.memo"/>: 
					</th>
					<td>
						<textarea name="deliveryTemplate.memo" class="formTextarea">${(deliveryTemplate.memo)!}</textarea>
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