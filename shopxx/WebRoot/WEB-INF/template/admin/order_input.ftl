<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="order.input.pagetitle"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
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
	
	var $tab = $("#tab");
	var $areaSelect = $("#areaSelect");
	var $totalProductQuantity = $("#totalProductQuantity");
	var $totalProductPrice = $("#totalProductPrice");
	var $deliveryFee = $("#deliveryFee");
	var $paymentFee = $("#paymentFee");
	var $totalAmount = $("#totalAmount");
	var $productPrice = $("#orderItemTable input.productPrice");
	var $productQuantity = $("#orderItemTable input.productQuantity");
	var $deleteOrderItem = $("#orderItemTable .deleteOrderItem");
	
	var totalProductPrice = parseFloat("${order.totalProductPrice}");// 商品总价格
	var deliveryFee = parseFloat("${order.deliveryFee}");// 配送费用
	var paymentFee = parseFloat("${order.paymentFee}");// 支付费用

	// Tab效果
	$tab.tabs(".tabContent", {
		tabs: "input"
	});
	
	// 地区选择菜单
	$areaSelect.lSelect({
		url: "${base}/shop/area!ajaxArea.action"// AJAX数据获取url
	});
	
	// 修改商品总金额
	function modifyTotalProductPrice() {
		totalProductPrice = 0.0;
		$("#orderItemTable input.productPrice").each(function(){
			var $this = $(this);
			var productPrice = $this.val();
			var productQuantity = $this.parent().parent().find("input.productQuantity").val();
			totalProductPrice = floatAdd(totalProductPrice, floatMul(productPrice, productQuantity));
		});
		$totalProductPrice.text(currencyFormat(totalProductPrice));
	}
	
	// 修改订单总金额
	function modifyTotalAmount() {
		var totalAmount = floatAdd(floatAdd(totalProductPrice, deliveryFee), paymentFee);
		$totalAmount.text(currencyFormat(totalAmount));
	}
	
	// 根据配送费用修改订单总金额
	$deliveryFee.change( function() {
		$this = $(this);
		var deliveryFeeValue = $this.val();
		if (!/^(([0-9]+\.?[0-9]+)|[0-9])$/.test(deliveryFeeValue)) {
			$this.val(deliveryFee);
			$.message({type: "warn", content: "<@s.text name="order.input.error.deliveryFee"/>"});
		} else {
			deliveryFee = deliveryFeeValue;
			modifyTotalAmount();
		}
	});
	
	// 根据支付费用修改订单总金额
	$paymentFee.change( function() {
		$this = $(this);
		var paymentFeeValue = $this.val();
		if (!/^(([0-9]+\.?[0-9]+)|[0-9])$/.test(paymentFeeValue)) {
			$this.val(paymentFee);
			$.message({type: "warn", content: "<@s.text name="order.input.error.paymentFee"/>"});
		} else {
			paymentFee = paymentFeeValue;
			modifyTotalAmount();
		}
	});
	
	// 记录初始商品价格
	$productPrice.each(function(){
		$this = $(this);
		$this.data("previousProductPrice", $this.val());
	});
	
	// 记录初始商品购买数
	$productQuantity.each(function(){
		$this = $(this);
		$this.data("previousProductQuantity", $this.val());
	});
	
	// 商品价格修改
	$productPrice.change( function() {
		$this = $(this);
		var productPriceValue = $this.val();
		if (!/^(([0-9]+\.?[0-9]+)|[0-9])$/.test(productPriceValue)) {
			var previousProductPrice = $this.data("previousProductPrice");
			$this.val(previousProductPrice);
			$.message({type: "warn", content: "<@s.text name="order.input.error.productPrice"/>"});
		} else {
			$this.data("previousProductPrice", productPriceValue);
			modifyTotalProductPrice();
			modifyTotalAmount();
		}
	});
	
	// 商品数量修改
	$productQuantity.change( function() {
		$this = $(this);
		var productQuantityValue = $this.val();
		var availableStore = $this.attr("availableStore");
		if (!/^[0-9]*[1-9][0-9]*$/.test(productQuantityValue)) {
			var previousProductQuantity = $this.data("previousProductQuantity");
			$this.val(previousProductQuantity);
			$.message({type: "warn", content: "<@s.text name="order.input.error.productQuantity"/>"});
		} else {
			if (availableStore != null && parseInt(productQuantityValue) > parseInt(availableStore)) {
				var previousProductQuantity = $this.data("previousProductQuantity");
				$this.val(previousProductQuantity);
				$.message({type: "warn", content: "<@s.text name="order.input.error.productQuantity.over"/>"});
				return false;
			}
			$this.data("previousProductQuantity", productQuantityValue);
			modifyTotalProductPrice();
			modifyTotalAmount();
		}
	});
	
	// 删除订单项
	$deleteOrderItem.click( function() {
		$this = $(this);
		if ($("#orderItemTable input.productPrice").size() <= 1) {
			$.dialog({type: "warn", content: "<@s.text name="order.input.error.deleteOrderItem"/>", modal: true, autoCloseTime: 2000});
			return false;
		}
		$.dialog({type: "warn", content: "<@s.text name="item.delete.tipmessage"/>", ok: "<@s.text name="button.name.confirm"/>", cancel: "<@s.text name="button.name.cancel"/>", modal: true, okCallback: deleteOrderItem});
		function deleteOrderItem() {
			$this.parent().parent().remove();
			modifyTotalProductPrice();
			modifyTotalAmount();
		}
		return false;
	});
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		onfocusout: false,
		onkeyup: false,
		onclick: false,
		rules: {
			"order.deliveryFee": {
				required: true,
				min: 0
			},
			"order.paymentFee": {
				required: true,
				min: 0
			},
			"order.totalProductWeight": {
				required: true,
				min: 0
			},
			"order.shipName": "required",
			"shipAreaId": "required",
			"order.shipAddress": "required",
			"order.shipMobile": {
				requiredOne: "#orderShipPhone"
			}
		},
		messages: {
			"order.deliveryFee": {
				required: "<@s.text name="order.input.messages.deliveryFee.required"/>",
				min: "<@s.text name="order.input.messages.deliveryFee.min"/>"
			},
			"order.paymentFee": {
				required: "<@s.text name="order.input.messages.paymentFee.required"/>",
				min: "<@s.text name="order.input.messages.paymentFee.min"/>"
			},
			"order.totalProductWeight": {
				required: "<@s.text name="order.input.messages.totalProductWeight.required"/>",
				min: "<@s.text name="order.input.messages.totalProductWeight.min"/>"
			},
			"order.shipName": "<@s.text name="order.input.messages.shipName"/>",
			"shipAreaId": "<@s.text name="order.input.messages.shipAreaId"/>",
			"order.shipAddress": "<@s.text name="order.input.messages.shipAddress"/>",
			"order.shipMobile": {
				requiredOne: "<@s.text name="order.input.messages.shipMobile"/>"
			}
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
	$.validator.addMethod("priceRequired", $.validator.methods.required, "<@s.text name="order.input.messages.priceRequired"/>");
	$.validator.addMethod("priceMin", $.validator.methods.min, "<@s.text name="order.input.messages.priceMin"/>");
	$.validator.addMethod("productQuantityPositiveInteger", $.validator.methods.positiveInteger, "<@s.text name="order.input.messages.productQuantityPositiveInteger"/>");
	
	$.validator.addClassRules("productPrice", {
		priceRequired: true,
		priceMin: 0
	});
	
	$.validator.addClassRules("productQuantity", {
		productQuantityPositiveInteger: true
	});

});
</script>
</head>
<body class="input">
	<div class="bar"><@s.text name="order.input.pagetitle"/></div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="common.validateErrorTitle"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="order!update.action" method="post">
			<input type="hidden" name="id" value="${order.id}" />
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="<@s.text name="order.view.tab.orderinfo"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="order.view.tab.goodsinfo"/>" hidefocus />
				</li>
			</ul>
			<table class="inputTable tabContent">
				<tr>
					<th>
						<@s.text name="order.orderSn"/>: 
					</th>
					<td>
						${order.orderSn}
					</td>
					<th>
						<@s.text name="order.createDate"/>: 
					</th>
					<td>
						${order.createDate?string("yyyy-MM-dd HH:mm:ss")}
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="order.totalProductPrice"/>: 
					</th>
					<td>
						<span id="totalProductPrice" class="red">${order.totalProductPrice?string(currencyFormat)}</span>
					</td>
					<th>
						<@s.text name="order.totalAmount"/>: 
					</th>
					<td>
						<span id="totalAmount" class="red">${order.totalAmount?string(currencyFormat)}</span>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="order.deliveryTypeName"/>: 
					</th>
					<td>
						<select name="deliveryType.id">
							<#list allDeliveryTypeList as deliveryType>
								<option value="${deliveryType.id}"<#if (deliveryType == order.deliveryType)!> selected</#if>>
									${deliveryType.name}
								</option>
							</#list>
						</select>
						<label class="requireField">*</label>
					</td>
					<th>
						<@s.text name="order.paymentConfigName"/>: 
					</th>
					<td>
						<select name="paymentConfig.id">
							<option value=""><@s.text name="order.paymentConfig.offline"/></option>
							<#list allPaymentConfigList as paymentConfig>
								<option value="${paymentConfig.id}"<#if (paymentConfig == order.paymentConfig)!> selected</#if>>
									${paymentConfig.name}
								</option>
							</#list>
						</select>
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="order.deliveryFee"/>: 
					</th>
					<td>
						<input type="text" id="deliveryFee" name="order.deliveryFee" class="formText" value="${order.deliveryFee}" />
						<label class="requireField">*</label>
					</td>
					<th>
						<@s.text name="order.paymentFee"/>: 
					</th>
					<td>
						<input type="text" id="paymentFee" name="order.paymentFee" class="formText" value="${order.paymentFee}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="order.totalProductWeight"/>: 
					</th>
					<td>
						<input type="text" name="order.totalProductWeight" class="formText" value="${order.totalProductWeight}" title="<@s.text name="order.totalProductWeight.tips"/>" />
					</td>
					<th>
						<@s.text name="order.memo"/>: 
					</th>
					<td>
						${(order.memo)!}
					</td>
				</tr>
				<tr>
					<td colspan="4">
						&nbsp;
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="order.shipName"/>: 
					</th>
					<td>
						<input type="text" name="order.shipName" class="formText" value="${order.shipName}" />
					</td>
					<th>
						<@s.text name="order.shipArea.displayName"/>: 
					</th>
					<td>
						<input type="text" id="areaSelect" name="shipAreaId" class="hidden" value="${(order.shipArea.id)!}" defaultSelectedPath="${(order.shipArea.path)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="order.shipAddress"/>: 
					</th>
					<td>
						<input type="text" name="order.shipAddress" class="formText" value="${order.shipAddress}" />
					</td>
					<th>
						<@s.text name="order.shipZipCode"/>: 
					</th>
					<td>
						<input type="text" name="order.shipZipCode" class="formText" value="${order.shipZipCode}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="order.shipPhone"/>: 
					</th>
					<td>
						<input type="text" id="orderShipPhone" name="order.shipPhone" class="formText" value="${order.shipPhone}" />
					</td>
					<th>
						<@s.text name="order.shipMobile"/>: 
					</th>
					<td>
						<input type="text" name="order.shipMobile" class="formText" value="${order.shipMobile}" />
					</td>
				</tr>
				<tr>
					<td colspan="4">
						&nbsp;
					</td>
				</tr>
				<#if order.member??>
					<#assign member = order.member />
					<tr>
						<th>
							<@s.text name="member.username"/>: 
						</th>
						<td>
							${member.username}
						</td>
						<th>
							<@s.text name="member.memberRank"/>: 
						</th>
						<td>
							${member.memberRank.name}
							<#if member.memberRank.preferentialScale != 100>
								<span class="red">[<@s.text name="member.memberRank.preferentialScale"/>: ${member.memberRank.preferentialScale}%]</span>
							</#if>
						</td>
					</tr>
					<tr>
						<th>
							E-mail: 
						</th>
						<td>
							${member.email}
						</td>
						<th>
							<@s.text name="member.createDate"/>: 
						</th>
						<td>
							${member.createDate}
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="member.loginDate"/>: 
						</th>
						<td>
							${member.loginDate}
						</td>
						<th>
							<@s.text name="member.loginIp"/>: 
						</th>
						<td>
							${member.loginIp}
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="member.deposit"/>: 
						</th>
						<td>
							${member.deposit?string(currencyFormat)}
						</td>
						<th>
							<@s.text name="member.score"/>: 
						</th>
						<td>
							${member.score}
						</td>
					</tr>
				<#else>
					<tr>
						<th>
							<@s.text name="member.status"/>: 
						</th>
						<td colspan="3">
							<span class="red"><@s.text name="member.status.none"/></span>
						</td>
					</tr>
				</#if>
			</table>
			<table id="orderItemTable" class="inputTable tabContent">
				<tr class="title">
					<th><@s.text name="order.orderItem.productSn"/></th>
					<th><@s.text name="order.orderItem.productName"/></th>
					<th><@s.text name="order.orderItem.productPrice"/></th>
					<th><@s.text name="order.orderItem.productQuantity"/></th>
					<th><@s.text name="common.button.delete"/></th>
				</tr>
				<#list order.orderItemSet as orderItem>
					<#assign product = orderItem.product />
					<tr>
						<td>
							<input type="hidden" name="orderItemList[${orderItem_index}].id" value="${orderItem.id}" />
							<a href="${base}${orderItem.goodsHtmlPath}" target="_blank">
								${orderItem.productSn}
							</a>
						</td>
						<td>
							<a href="${base}${orderItem.goodsHtmlPath}" target="_blank">
								${orderItem.productName}
							</a>
						</td>
						<td>
							<input type="text" name="orderItemList[${orderItem_index}].productPrice" class="formText productPrice" value="${orderItem.productPrice}" style="width: 50px;" />
						</td>
						<td>
							<#if product.store??>
								<#if (setting.storeFreezeTime == "payment" && order.paymentStatus == "unpaid") || (setting.storeFreezeTime == "ship" && order.shippingStatus == "unshipped")>
									<#assign availableStore = product.store - product.freezeStore />
								<#else>
									<#assign availableStore = product.store - product.freezeStore + orderItem.totalProductQuantity />
								</#if>
							</#if>
							<input type="text" name="orderItemList[${orderItem_index}].productQuantity" class="formText productQuantity"<#if product.store??> availableStore="${availableStore}"</#if> value="${orderItem.productQuantity}" style="width: 50px;" />
						</td>
						<td>
							<a href="javascript: void(0);" class="deleteOrderItem"><@s.text name="common.button.delete"/></a>
						</td>
					</tr>
				</#list>
			</table>
			<div class="buttonArea">
				<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>