<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="order.process.pagetitle"/> - Powered By SHOP++</title>
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
	var $paymentTabButton = $("#paymentTabButton");
	var $shippingTabButton = $("#shippingTabButton");
	var $refundTabButton = $("#refundTabButton");
	var $reshipTabButton = $("#reshipTabButton");

	var $areaSelect = $(".areaSelect");
	var $paymentForm = $("#paymentForm");
	var $shippingForm = $("#shippingForm");
	var $refundForm = $("#refundForm");
	var $reshipForm= $("#reshipForm");
	var $paymentProcessButton = $("#paymentProcessButton");
	var $shippingProcessButton = $("#shippingProcessButton");
	var $completedProcessButton = $("#completedProcessButton");
	var $refundProcessButton = $("#refundProcessButton");
	var $reshipProcessButton = $("#reshipProcessButton");
	var $invalidProcessButton = $("#invalidProcessButton");
	var $shippingDeliveryQuantity = $("#shippingForm .shippingDeliveryQuantity");
	var $reshipDeliveryQuantity = $("#reshipForm .reshipDeliveryQuantity");
	
	// Tab效果
	$tab.tabs(".tabContent", {
		tabs: "input"
	});
	
	// 地区选择菜单
	$areaSelect.lSelect({
		url: "${base}/shop/area!ajaxArea.action"// AJAX数据获取url
	});

	var tabs = $("ul.tab").tabs();
	
	// 订单支付
	$paymentProcessButton.click( function() {
		tabs.click(2);
	});
	
	// 订单发货
	$shippingProcessButton.click( function() {
		tabs.click(3);
	});
	
	// 订单完成
	$completedProcessButton.click( function() {
		var $this = $(this);
		$.dialog({type: "warn", content: "<@s.text name="order.process.complete.content"/>", ok: "<@s.text name="button.name.confirm"/>", cancel: "<@s.text name="button.name.cancel"/>", width: 420, modal: true, okCallback: orderCompleted});
		function orderCompleted() {
			$.ajax({
				url: "order!completed.action",
				data: {id: "${order.id}"},
				type: "POST",
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$this.attr("disabled", true);
				},
				success: function(data) {
					$.message({type: data.status, content: data.message});
					if (data.status == "success") {
						$paymentTabButton.attr("disabled", true);
						$shippingTabButton.attr("disabled", true);
						$refundTabButton.attr("disabled", true);
						$reshipTabButton.attr("disabled", true);
						
						$paymentProcessButton.attr("disabled", true);
						$shippingProcessButton.attr("disabled", true);
						$completedProcessButton.attr("disabled", true);
						$refundProcessButton.attr("disabled", true);
						$reshipProcessButton.attr("disabled", true);
						$invalidProcessButton.attr("disabled", true);
					} else {
						$this.attr("disabled", true);
					}
				}
			});
		}
	});
	
	// 退款
	$refundProcessButton.click( function() {
		tabs.click(4);
	});
	
	// 退货
	$reshipProcessButton.click( function() {
		tabs.click(5);
	});
	
	// 作废
	$invalidProcessButton.click( function() {
		var $this = $(this);
		$.dialog({type: "warn", content: "<@s.text name="order.process.invalid.content"/>", ok: "<@s.text name="button.name.confirm"/>", cancel: "<@s.text name="button.name.cancel"/>", modal: true, okCallback: orderInvalid});
		function orderInvalid() {
			$.ajax({
				url: "order!invalid.action",
				data: {id: "${order.id}"},
				type: "POST",
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$this.attr("disabled", true);
				},
				success: function(data) {
					$.message({type: data.status, content: data.message});
					if (data.status == "success") {
						$paymentTabButton.attr("disabled", true);
						$shippingTabButton.attr("disabled", true);
						$refundTabButton.attr("disabled", true);
						$reshipTabButton.attr("disabled", true);
						
						$paymentProcessButton.attr("disabled", true);
						$shippingProcessButton.attr("disabled", true);
						$completedProcessButton.attr("disabled", true);
						$refundProcessButton.attr("disabled", true);
						$reshipProcessButton.attr("disabled", true);
						$invalidProcessButton.attr("disabled", true);
					} else {
						$this.attr("disabled", false);
					}
				}
			});
		}
	});
	
	// 订单支付表单验证
	$paymentForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"payment.totalAmount": {
				required: true,
				positive: true,
				max: ${order.totalAmount - order.paidAmount}
			}
		},
		messages: {
			"payment.totalAmount": {
				required: "<@s.text name="goods.order.payment.require"/>",
				positive: "<@s.text name="goods.order.payment.positive"/>",
				max: "<@s.text name="goods.order.payment.minimize"/>${order.totalAmount - order.paidAmount}"
			}
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
	// 发货数修改
	$shippingDeliveryQuantity.change( function() {
		var $this = $(this);
		var maxDeliveryQuantity = $this.attr("maxDeliveryQuantity");
		if (/^[0-9]*[1-9][0-9]*$/.test($this.val()) && parseInt($this.val()) > parseInt(maxDeliveryQuantity)) {
			$.dialog({type: "warn", content: "<@s.text name="order.process.delivery.content"/>", modal: true, autoCloseTime: 2000});
			$this.val(maxDeliveryQuantity);
			return false;
		}
	});
	
	// 订单发货表单验证
	$shippingForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"shipping.deliveryFee": {
				required: true,
				min: 0
			},
			"shipping.shipName": "required",
			"shipAreaId": "required",
			"shipping.shipAddress": "required",
			"shipping.shipZipCode": "required",
			"shipping.shipMobile": {
				"requiredOne": "#shipPhone"
			}
		},
		messages: {
			"shipping.deliveryFee": {
				required: "<@s.text name="goods.order.payment.shipFee"/>",
				min: "<@s.text name="goods.order.payment.number"/>"
			},
			"shipping.shipName": "<@s.text name="goods.receiver.input.name"/>",
			"shipAreaId": "<@s.text name="goods.order.payment.areaId"/>",
			"shipping.shipAddress": "<@s.text name="goods.order.payment.areaId.input"/>",
			"shipping.shipZipCode": "<@s.text name="goods.receiver.input.zipcode"/>",
			"shipping.shipMobile": {
				"requiredOne": "<@s.text name="goods.order.payment.mobile.requireOne"/>"
			}
		},
		submitHandler: function(form) {
			var totalShippingDeliveryQuantity = 0;
			$shippingDeliveryQuantity.each(function(){
				var $this = $(this);
				totalShippingDeliveryQuantity += $this.val();
			});
			if (totalShippingDeliveryQuantity == 0) {
				$.dialog({type: "warn", content: "<@s.text name="goods.order.payment.warn.total"/>!", modal: true, autoCloseTime: 2000});
			} else {
				$(form).find(":submit").attr("disabled", true);
				form.submit();
			}
		}
	});
	
	$.validator.addMethod("shippingDeliveryQuantityRequired", $.validator.methods.required, "<@s.text name="goods.order.payment.total"/>");
	$.validator.addMethod("shippingDeliveryQuantityDigits", $.validator.methods.digits, "<@s.text name="goods.order.payment.total.require"/>");
	
	$.validator.addClassRules("shippingDeliveryQuantity", {
		shippingDeliveryQuantityRequired: true,
		shippingDeliveryQuantityDigits: 0
	});
	
	// 订单退款表单验证
	$refundForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"refund.totalAmount": {
				required: true,
				positive: true,
				max: ${order.paidAmount}
			}
		},
		messages: {
			"refund.totalAmount": {
				required: "<@s.text name="goods.order.payment.refund"/>",
				positive: "<@s.text name="goods.order.payment.refund.number"/>",
				max: "<@s.text name="goods.order.payment.refund.max"/>${order.paidAmount}"
			}
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
	// 退货数修改
	$reshipDeliveryQuantity.change( function() {
		var $this = $(this);
		var maxDeliveryQuantity = $this.attr("maxDeliveryQuantity");
		if (/^[0-9]*[1-9][0-9]*$/.test($this.val()) && parseInt($this.val()) > parseInt(maxDeliveryQuantity)) {
			$.dialog({type: "warn", content: "<@s.text name="goods.order.payment.refund.warn"/>!", modal: true, autoCloseTime: 2000});
			$this.val(maxDeliveryQuantity);
			return false;
		}
	});
	
	// 订单退货表单验证
	$reshipForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"reship.deliveryFee": {
				required: true,
				min: 0
			},
			"reship.reshipName": "required",
			"reshipAreaId": "required",
			"reship.reshipAddress": "required",
			"reship.reshipZipCode": "required",
			"reship.reshipMobile": {
				"requiredOne": "#reshipPhone"
			}
		},
		messages: {
			"reship.deliveryFee": {
				required: "<@s.text name="goods.order.payment.refund.fee"/>",
				min: "<@s.text name="goods.order.payment.number"/>"
			},
			"reship.reshipName": "<@s.text name="goods.order.payment.refund.name"/>",
			"reshipAreaId": "<@s.text name="goods.order.payment.refund.area"/>",
			"reship.reshipAddress": "<@s.text name="goods.order.payment.refund.address"/>",
			"reship.reshipZipCode": "<@s.text name="goods.receiver.input.zipcode"/>",
			"reship.reshipMobile": {
				"requiredOne": "<@s.text name="goods.order.payment.mobile.requireOne"/>"
			}
		},
		submitHandler: function(form) {
			var totalReshipDeliveryQuantity = 0;
			$reshipDeliveryQuantity.each(function(){
				var $this = $(this);
				totalReshipDeliveryQuantity += $this.val();
			});
			if (totalReshipDeliveryQuantity == 0) {
				$.dialog({type: "warn", content: "<@s.text name="goods.order.payment.refund.warn.total"/>!", modal: true, autoCloseTime: 2000});
			} else {
				$(form).find(":submit").attr("disabled", true);
				form.submit();
			}
		}
	});
	
	$.validator.addMethod("reshipDeliveryQuantityRequired", $.validator.methods.required, "<@s.text name="goods.order.payment.refund.total"/>");
	$.validator.addMethod("reshipDeliveryQuantityDigits", $.validator.methods.digits, "<@s.text name="goods.order.payment.refund.total.require"/>");
	
	$.validator.addClassRules("reshipDeliveryQuantity", {
		reshipDeliveryQuantityRequired: true,
		reshipDeliveryQuantityDigits: 0
	});

});
</script>
</head>
<body class="input">
	<div class="bar"><@s.text name="order.process.pagetitle"/></div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="goods.message.reply.title.error.validate"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<ul id="tab" class="tab">
			<li>
				<input type="button" value="<@s.text name="goods.compare.head1"/>" hidefocus />
			</li>
			<li>
				<input type="button" value="<@s.text name="order.view.tab.goodsinfo"/>" hidefocus />
			</li>
			<li>
				<input type="button" id="paymentTabButton" value="<@s.text name="goods.order.payment.payment"/>"<#if order.orderStatus == "completed" || order.orderStatus == "invalid" || order.paymentStatus == "paid" || order.paymentStatus == "partRefund" || order.paymentStatus == "refunded"> disabled</#if> hidefocus />
			</li>
			<li>
				<input type="button" id="shippingTabButton" value="<@s.text name="goods.order.payment.shipping"/>"<#if order.orderStatus == "completed" || order.orderStatus == "invalid" || order.shippingStatus == "shipped"> disabled</#if> hidefocus />
			</li>
			<li>
				<input type="button" id="refundTabButton" value="<@s.text name="goods.order.refund"/>"<#if order.orderStatus == "completed" || order.orderStatus == "invalid" || order.paymentStatus == "unpaid" || order.paymentStatus == "refunded"> disabled</#if> hidefocus />
			</li>
			<li>
				<input type="button" id="reshipTabButton" value="<@s.text name="goods.order.reship"/>"<#if order.orderStatus == "completed" || order.orderStatus == "invalid" || order.shippingStatus == "unshipped" || order.shippingStatus == "reshiped"> disabled</#if> hidefocus />
			</li>
		</ul>
		<div class="tabContent">
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="goods.order.status.operator"/>: 
					</th>
					<td>
						<input type="button" id="paymentProcessButton" name="paymentProcess" class="formButton" value="<@s.text name="goods.order.payment.payment"/>"<#if order.orderStatus == "completed" || order.orderStatus == "invalid" || order.paymentStatus == "paid" || order.paymentStatus == "partRefund" || order.paymentStatus == "refunded"> disabled</#if> hidefocus />
						<input type="button" id="shippingProcessButton" name="shippingProcess" class="formButton" value="<@s.text name="goods.order.payment.shipping"/>"<#if order.orderStatus == "completed" || order.orderStatus == "invalid" || order.shippingStatus == "shipped"> disabled</#if> hidefocus />
						<input type="button" id="completedProcessButton" name="completedProcess" class="formButton" value="<@s.text name="goods.order.payment.complete"/>"<#if order.orderStatus == "completed" || order.orderStatus == "invalid"> disabled</#if> hidefocus />
					</td>
					<td colspan="2">
						<input type="button" id="refundProcessButton" name="refundProcess" class="formButton" value="<@s.text name="goods.order.refund"/>"<#if order.orderStatus == "completed" || order.orderStatus == "invalid" || order.paymentStatus == "unpaid" || order.paymentStatus == "refunded"> disabled</#if> hidefocus />
						<input type="button" id="reshipProcessButton" name="reshipProcess" class="formButton" value="<@s.text name="goods.order.reship"/>"<#if order.orderStatus == "completed" || order.orderStatus == "invalid" || order.shippingStatus == "unshipped" || order.shippingStatus == "reshiped"> disabled</#if> hidefocus />
						<input type="button" id="invalidProcessButton" name="invalidProcess" class="formButton" value="<@s.text name="goods.order.invalid"/>"<#if order.orderStatus == "completed" || order.orderStatus == "invalid" || order.paymentStatus != "unpaid" || order.shippingStatus != "unshipped"> disabled</#if> hidefocus />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.order.status"/>: 
					</th>
					<td colspan="3">
						<span class="red">
							[${action.getText("OrderStatus." + order.orderStatus)}]
							[${action.getText("PaymentStatus." + order.paymentStatus)}]
							[${action.getText("ShippingStatus." + order.shippingStatus)}]
						</span>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						&nbsp;
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="refund.order.orderSn"/>: 
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
						<span id="totalAmount" class="red">${order.totalAmount?string(currencyFormat)}</span>&nbsp;&nbsp;
						<strong class="red">[<@s.text name="order.paidAmount"/>: ${order.paidAmount?string(currencyFormat)}]</strong>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="order.deliveryTypeName"/>: 
					</th>
					<td>
						${order.deliveryTypeName}
					</td>
					<th>
						<@s.text name="order.paymentConfigName"/>: 
					</th>
					<td>
						${order.paymentConfigName}
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="order.deliveryFee"/>: 
					</th>
					<td>
						${order.deliveryFee?string(currencyFormat)}
					</td>
					<th>
						<@s.text name="order.paymentFee"/>: 
					</th>
					<td>
						${order.paymentFee?string(currencyFormat)}
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.order.weight"/>: 
					</th>
					<td>
						${order.totalProductWeight} <@s.text name="order.totalProductWeightunit"/>
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
						<@s.text name="shipping.shipName"/>: 
					</th>
					<td>
						${order.shipName}
					</td>
					<th>
						<@s.text name="order.shipArea.displayName"/>: 
					</th>
					<td>
						${order.shipArea.displayName}
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="order.shipAddress"/>: 
					</th>
					<td>
						${order.shipAddress}
					</td>
					<th>
						<@s.text name="shipping.shipZipCode"/>: 
					</th>
					<td>
						${order.shipZipCode}
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="shipping.shipPhone"/>: 
					</th>
					<td>
						${order.shipPhone}
					</td>
					<th>
						<@s.text name="shipping.shipMobile"/>: 
					</th>
					<td>
						${order.shipMobile}
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
					<tr>
						<td colspan="4">
							<div class="buttonArea">
								<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
							</div>
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
		</div>
		<div class="tabContent">
			<table class="inputTable">
				<tr class="title">
					<th><@s.text name="order.orderItem.productSn"/></th>
					<th><@s.text name="order.orderItem.productName"/></th>
					<th><@s.text name="order.orderItem.productPrice"/></th>
					<th><@s.text name="order.orderItem.productQuantity"/></th>
				</tr>
				<#list order.orderItemSet as orderItem>
					<tr>
						<td>
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
							${orderItem.productPrice?string(currencyFormat)}
						</td>
						<td>
							${orderItem.productQuantity}
						</td>
					</tr>
				</#list>
				<tr>
					<td colspan="4">
						<div class="buttonArea">
							<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="tabContent">
			<#if order.orderStatus != "completed" && order.orderStatus != "invalid" && order.paymentStatus != "paid" && order.paymentStatus != "partRefund" && order.paymentStatus != "refunded">
				<form id="paymentForm" action="order!payment.action" method="post">
					<input type="hidden" name="id" value="${order.id}" />
					<table class="inputTable">
						<tr>
							<th>
								<@s.text name="shipping.order.orderSn"/>: 
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
								<@s.text name="order.totalAmount"/>: 
							</th>
							<td>
								<span class="red">${order.totalAmount?string(currencyFormat)}</span>
							</td>
							<th>
								<@s.text name="order.paidAmount"/>: 
							</th>
							<td>
								<span class="red">${order.paidAmount?string(currencyFormat)}</span>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="goods.order.bank.name"/>: 
							</th>
							<td>
								<input type="text" name="payment.bankName" class="formText" />
							</td>
							<th>
								<@s.text name="goods.order.bank.account"/>: 
							</th>
							<td>
								<input type="text" name="payment.bankAccount" class="formText" />
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="payment.paymentType"/>: 
							</th>
							<td>
								<select name="payment.paymentType">
									<#list nonRechargePaymentTypeList as paymentType>
										<option value="${paymentType}">
											${action.getText("PaymentType." + paymentType)}
										</option>
									</#list>
								</select>
							</td>
							<th>
								<@s.text name="payment.paymentConfigName"/>: 
							</th>
							<td>
								<select name="paymentConfig.id">
									<#list allPaymentConfigList as paymentConfig>
										<option value="${paymentConfig.id}"<#if (paymentConfig == order.paymentConfig)!> selected</#if>>
											${paymentConfig.name}
										</option>
									</#list>
								</select>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="goods.order.payment.fees"/>: 
							</th>
							<td>
								<input type="text" name="payment.totalAmount" class="formText" value="${order.totalAmount - order.paidAmount}" />
							</td>
							<th>
								<@s.text name="payment.payer"/>: 
							</th>
							<td>
								<input type="text" name="payment.payer" class="formText" />
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="goods.order.payment.memo"/>: 
							</th>
							<td colspan="3">
								<input type="text" name="payment.memo" class="formText" />
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div class="buttonArea">
									<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
									<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
								</div>
							</td>
						</tr>
					</table>
				</form>
			</#if>
		</div>
		<div class="tabContent">
			<#if order.orderStatus != "completed" && order.orderStatus != "invalid" && order.shippingStatus != "shipped">
				<form id="shippingForm" action="order!shipping.action" method="post">
					<input type="hidden" name="id" value="${order.id}" />
					<table class="inputTable">
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
							</td>
							<th>
								<@s.text name="order.deliveryFee"/>: 
							</th>
							<td>
								<span class="red">${order.deliveryFee?string(currencyFormat)}</span>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="goods.order.delivery.company"/>: 
							</th>
							<td>
								<select name="deliveryCorp.id">
									<#list allDeliveryCorpList as deliveryCorp>
										<option value="${deliveryCorp.id}"<#if (deliveryCorp == order.deliveryType.defaultDeliveryCorp)!> selected</#if>>
											${deliveryCorp.name}
										</option>
									</#list>
								</select>
							</td>
							<th>
								<@s.text name="reship.deliverySn"/>: 
							</th>
							<td>
								<input type="text" name="shipping.deliverySn" class="formText" />
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="reship.deliveryFee"/>: 
							</th>
							<td colspan="3">
								<input type="text" name="shipping.deliveryFee" class="formText" value="${order.deliveryFee}" />
								<label class="requireField">*</label>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								&nbsp;
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="goods.order.ship.username"/>: 
							</th>
							<td>
								<input type="text" name="shipping.shipName" class="formText" value="${order.shipName}" />
								<label class="requireField">*</label>
							</td>
							<th>
								<@s.text name="goods.order.ship.area"/>: 
							</th>
							<td>
								<input type="text" name="shipAreaId" class="areaSelect" value="${order.shipArea.id}" defaultSelectedPath="${order.shipArea.path}" />
								<label class="requireField">*</label>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="goods.order.ship.address"/>: 
							</th>
							<td>
								<input type="text" name="shipping.shipAddress" class="formText" value="${order.shipAddress}" />
								<label class="requireField">*</label>
							</td>
							<th>
								<@s.text name="goods.order.ship.zipcode"/>: 
							</th>
							<td>
								<input type="text" name="shipping.shipZipCode" class="formText" value="${order.shipZipCode}" />
								<label class="requireField">*</label>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="goods.order.ship.phone"/>: 
							</th>
							<td>
								<input type="text" id="shipPhone" name="shipping.shipPhone" class="formText" value="${order.shipPhone}" />
								<label class="requireField">*</label>
							</td>
							<th>
								<@s.text name="goods.order.ship.mobile"/>: 
							</th>
							<td>
								<input type="text" name="shipping.shipMobile" class="formText" value="${order.shipMobile}" />
								<label class="requireField">*</label>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="goods.order.storage.pay.memo"/>: 
							</th>
							<td colspan="3">
								<input type="text" name="shipping.memo" class="formText" />
							</td>
						</tr>
						<tr>
							<td colspan="4">
								&nbsp;
							</td>
						</tr>
					</table>
					<table class="inputTable">
						<tr class="title">
							<th><@s.text name="order.orderItem.productSn"/></th>
							<th><@s.text name="order.orderItem.productName"/></th>
							<th><@s.text name="order.orderItem.productQuantity"/></th>
							<th><@s.text name="goods.order.storage.current"/></th>
							<th><@s.text name="goods.order.storage.pay"/></th>
							<th><@s.text name="goods.order.storage.this"/></th>
						</tr>
						<#list order.orderItemSet as orderItem>
							<tr>
								<td>
									<input type="hidden" name="deliveryItemList[${orderItem_index}].product.id" value="${orderItem.product.id}" />
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
									${orderItem.productQuantity}
								</td>
								<td>
									<#if (orderItem.product.store)??>
										${orderItem.product.store}
										[<@s.text name="goods.order.storage.freeze"/>: ${orderItem.product.freezeStore}]
									<#else>
										<@s.text name="goods.order.storage.not.calculate"/>
									</#if>
								</td>
								<td>
									${orderItem.deliveryQuantity}
								</td>
								<td>
									<input type="text" name="deliveryItemList[${orderItem_index}].deliveryQuantity" class="formText shippingDeliveryQuantity" value="${orderItem.productQuantity - orderItem.deliveryQuantity}" maxDeliveryQuantity="${orderItem.productQuantity - orderItem.deliveryQuantity}" style="width: 50px;" />
								</td>
							</tr>
						</#list>
						<tr>
							<td colspan="6">
								<div class="buttonArea">
									<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
									<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
								</div>
							</td>
						</tr>
					</table>
				</form>
			</#if>
		</div>
		<div class="tabContent">
			<#if order.orderStatus != "completed" && order.orderStatus != "invalid" && order.paymentStatus != "unpaid" && order.paymentStatus != "refunded">
				<form id="refundForm" action="order!refund.action" method="post">
					<input type="hidden" name="id" value="${order.id}" />
					<table class="inputTable">
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
								<@s.text name="order.totalAmount"/>: 
							</th>
							<td>
								<span class="red">${order.totalAmount?string(currencyFormat)}</span>
							</td>
							<th>
								<@s.text name="order.paidAmount"/>: 
							</th>
							<td>
								<span class="red">${order.paidAmount?string(currencyFormat)}</span>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="goods.order.bank.refund.name"/>: 
							</th>
							<td>
								<input type="text" name="refund.bankName" class="formText" />
							</td>
							<th>
								<@s.text name="goods.order.bank.refund.account"/>: 
							</th>
							<td>
								<input type="text" name="refund.bankAccount" class="formText" />
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="refund.refundType"/>: 
							</th>
							<td>
								<select name="refund.refundType">
									<#list refundTypeList as refundType>
										<option value="${refundType}">
											${action.getText("RefundType." + refundType)}
										</option>
									</#list>
								</select>
							</td>
							<th>
								<@s.text name="refund.paymentConfigName"/>: 
							</th>
							<td>
								<select name="paymentConfig.id">
									<#list allPaymentConfigList as paymentConfig>
										<option value="${paymentConfig.id}"<#if (paymentConfig == order.paymentConfig)!> selected</#if>>
											${paymentConfig.name}
										</option>
									</#list>
								</select>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="refund.totalAmount"/>: 
							</th>
							<td>
								<input type="text" name="refund.totalAmount" class="formText" value="${order.paidAmount}" />
								<label class="requireField">*</label>
							</td>
							<th>
								<@s.text name="refund.payee"/>: 
							</th>
							<td>
								<input type="text" name="refund.payee" class="formText" />
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="goods.order.bank.refund.memo"/>: 
							</th>
							<td colspan="3">
								<input type="text" name="refund.memo" class="formText" />
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div class="buttonArea">
									<input type="submit" class="formButton" value="确  定" hidefocus />&nbsp;&nbsp;
									<input type="button" class="formButton" onclick="window.history.back(); return false;" value="返  回" hidefocus />
								</div>
							</td>
						</tr>
					</table>
				</form>
			</#if>
		</div>
		<div class="tabContent">
			<#if order.orderStatus != "completed" && order.orderStatus != "invalid" && order.shippingStatus != "unshipped" && order.shippingStatus != "reshiped">
				<form id="reshipForm" action="order!reship.action" method="post">
					<input type="hidden" name="id" value="${order.id}" />
					<table class="inputTable">
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
							</td>
							<th>
								<@s.text name="goods.order.delivery.company"/>: 
							</th>
							<td>
								<select name="deliveryCorp.id">
									<#list allDeliveryCorpList as deliveryCorp>
										<option value="${deliveryCorp.id}">
											${deliveryCorp.name}
										</option>
									</#list>
								</select>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="shipping.deliveryFee"/>: 
							</th>
							<td>
								<input type="text" name="reship.deliveryFee" class="formText" value="${order.deliveryFee}" />
								<label class="requireField">*</label>
							</td>
							<th>
								<@s.text name="shipping.deliverySn"/>: 
							</th>
							<td>
								<input type="text" name="reship.deliverySn" class="formText" />
							</td>
						</tr>
						<tr>
							<td colspan="4">
								&nbsp;
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="reship.reshipName"/>: 
							</th>
							<td>
								<input type="text" name="reship.reshipName" class="formText" value="${order.shipName}" />
								<label class="requireField">*</label>
							</td>
							<th>
								<@s.text name="reship.reshipArea.displayName"/>: 
							</th>
							<td>
								<input type="text" name="reshipAreaId" class="areaSelect" value="${order.shipArea.id}" defaultSelectedPath="${order.shipArea.path}" />
								<label class="requireField">*</label>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="reship.reshipAddress"/>: 
							</th>
							<td>
								<input type="text" name="reship.reshipAddress" class="formText" value="${order.shipAddress}" />
								<label class="requireField">*</label>
							</td>
							<th>
								<@s.text name="reship.reshipZipCode"/>: 
							</th>
							<td>
								<input type="text" name="reship.reshipZipCode" class="formText" value="${order.shipZipCode}" />
								<label class="requireField">*</label>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="reship.reshipPhone"/>: 
							</th>
							<td>
								<input type="text" id="reshipPhone" name="reship.reshipPhone" class="formText" value="${order.shipPhone}" />
								<label class="requireField">*</label>
							</td>
							<th>
								<@s.text name="reship.reshipMobile"/>: 
							</th>
							<td>
								<input type="text" name="reship.reshipMobile" class="formText" value="${order.shipMobile}" />
								<label class="requireField">*</label>
							</td>
						</tr>
						<tr>
							<th>
								<@s.text name="goods.order.storage.refund.memo"/>: 
							</th>
							<td colspan="3">
								<input type="text" name="reship.memo" class="formText" />
							</td>
						</tr>
						<tr>
							<td colspan="4">
								&nbsp;
							</td>
						</tr>
					</table>
					<table class="inputTable">
						<tr class="title">
							<th><@s.text name="reship.deliveryItem.productSn"/></th>
							<th><@s.text name="reship.deliveryItem.productName"/></th>
							<th><@s.text name="order.orderItem.productQuantity"/></th>
							<th><@s.text name="goods.order.storage.pay"/></th>
							<th><@s.text name="goods.order.storage.refund.this"/></th>
						</tr>
						<#list order.orderItemSet as orderItem>
							<tr>
								<td>
									<input type="hidden" name="deliveryItemList[${orderItem_index}].product.id" value="${orderItem.product.id}" />
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
									${orderItem.productQuantity}
								</td>
								<td>
									${orderItem.deliveryQuantity}
								</td>
								<td>
									<input type="text" name="deliveryItemList[${orderItem_index}].deliveryQuantity" class="formText reshipDeliveryQuantity" value="${orderItem.deliveryQuantity}" maxDeliveryQuantity="${orderItem.deliveryQuantity}" style="width: 50px;" />
								</td>
							</tr>
						</#list>
						<tr>
							<td colspan="6">
								<div class="buttonArea">
									<input type="submit" class="formButton" value="<@s.text name="caritem.delete.confirm"/>" hidefocus />&nbsp;&nbsp;
									<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
								</div>
							</td>
						</tr>
					</table>
				</form>
			</#if>
		</div>
	</div>
</body>
</html>