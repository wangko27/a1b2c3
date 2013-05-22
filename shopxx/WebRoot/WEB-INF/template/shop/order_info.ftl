<#assign s=JspTaglibs["/WEB-INF/tld/struts.tld"] />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("goods.order.fillin")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/shop/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/shop.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.lSelect.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/base.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/shop.js"></script>
<!--[if lte IE 6]>
	<script type="text/javascript" src="${base}/template/common/js/belatedPNG.js"></script>
	<script type="text/javascript">
		// 解决IE6透明PNG图片BUG
		DD_belatedPNG.fix(".belatedPNG");
	</script>
<![endif]-->
<script type="text/javascript">
$().ready( function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $orderInfoForm = $("#orderInfoForm");
	
	var $receiverId = $("#receiverTr .receiverId");
	var $areaSelect = $("#areaSelect");
	var $otherReceiver = $("#otherReceiver");
	var $otherReceiverTable = $("#otherReceiverTable");
	var $otherReceiverInput = $("#otherReceiverTable :input");
	var $deliveryTypeId = $("#deliveryTypeTable input");
	var $paymentConfigTr = $("#paymentConfigTr");
	var $paymentConfigId = $("#paymentConfigTable input");
	var $totalProductPrice = $("#totalProductPrice");
	var $deliveryFee = $("#deliveryFee");
	var $paymentFee = $("#paymentFee");
	var $orderAmount = $("#orderAmount");
	
	var totalProductPrice = ${totalProductPrice};// 商品总价格
	var deliveryFee = 0;// 配送费用
	var paymentFee = 0;// 支付费用
	
	// 地区选择菜单
	$areaSelect.lSelect({
		url: "${base}/shop/area!ajaxArea.action"// AJAX数据获取url
	});
	
	// 如果默认选择“其它收货地址”,则显示“其它收货地址输入框”
	if ($receiverId.val() == "") {
		$otherReceiverTable.show();
		$otherReceiverInput.attr("disabled", false);
	} else {
		$otherReceiverInput.attr("disabled", true);
	}
	
	// 隐藏“其它收货地址输入框”
	$receiverId.click( function() {
		$this = $(this);
		if ($this.val() == "") {
			$otherReceiverTable.show();
			$otherReceiverInput.attr("disabled", false);
		} else {
			$otherReceiverTable.hide();
			$otherReceiverInput.attr("disabled", true);
		}
	});
	
	// 显示“其它收货地址输入框”
	$otherReceiver.click( function() {
		$otherReceiverTable.show();
		$otherReceiverInput.attr("disabled", false);
	});
	
	// 根据配送方式修改配送费用、订单总金额,并显示/隐藏支付方式
	$deliveryTypeId.click( function() {
		var $this = $(this);
		$paymentConfigId.attr("checked", false);
		paymentFee = 0;
		var deliveryMethod = $this.attr("deliveryMethod");
		if (deliveryMethod == "deliveryAgainstPayment") {
			$paymentConfigId.attr("disabled", false);
			$paymentConfigTr.show();
		} else {
			$paymentConfigId.attr("disabled", true);
			$paymentConfigTr.hide();
		}
		deliveryFee = $this.attr("deliveryFee");
		$deliveryFee.text(currencyFormat(deliveryFee));
		$paymentFee.text(currencyFormat(paymentFee));
		$orderAmount.text(currencyFormat(floatAdd(floatAdd(totalProductPrice, deliveryFee), paymentFee)));
	});
	
	// 根据支付方式修改订单总金额
	$paymentConfigId.click( function() {
		var $this = $(this);
		var paymentFeeType = $this.attr("paymentFeeType");
		var paymentFee = $this.attr("paymentFee");
		if (paymentFeeType == "scale") {
			paymentFee = floatMul(floatAdd(totalProductPrice, deliveryFee), floatDiv(paymentFee, 100));
		}
		$paymentFee.text(currencyFormat(paymentFee));
		$orderAmount.text(currencyFormat(floatAdd(totalProductPrice, floatAdd(deliveryFee, paymentFee))));
	});
	
	// 表单验证
	$orderInfoForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"receiver.id": "required",
			"receiver.name": "required",
			"areaId": "required",
			"receiver.address": "required",
			"receiver.mobile": {
				"requiredOne": "#receiverPhone"
			},
			"receiver.zipCode": "required",
			"deliveryType.id": "required",
			"paymentConfig.id": "required",
			"memo": {
				maxlength: 200
			}
		},
		messages: {
			"receiver.id": "${bundle("goods.receiver.input.address.id")}",
			"receiver.name": "${bundle("goods.receiver.input.username")}",
			"areaId": "${bundle("goods.receiver.select.area")}",
			"receiver.address": "${bundle("goods.receiver.input.address.fill")}",
			"receiver.mobile": {
				"requiredOne": "${bundle("goods.receiver.input.invalid")}"
			},
			"receiver.zipCode": "${bundle("goods.receiver.input.zipcode")}",
			"deliveryType.id": "${bundle("goods.receiver.input.delivery")}",
			"paymentConfig.id": "${bundle("goods.receiver.input.payment")}",
			"memo": {
				maxlength: "${bundle("goods.receiver.input.length")}"
			}
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});

});
</script>
</head>
<body class="orderInfo">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body">
		<div id="validateErrorContainer" class="validateErrorContainer">
			<div class="validateErrorTitle">${bundle("goods.message.reply.title.error.validate")}</div>
			<ul></ul>
		</div>
		<div class="orderInfoDetail">
			<form id="orderInfoForm" action="order!save.action" method="post">
				<@s.token />
				<table class="orderInfoTable">
					<tr id="receiverTr">
						<th>${bundle("goods.order.ship.info")}</th>
						<td>
							<ul>
								<#list loginMember.receiverSet as receiver>
									<li>
										<label>
											<input type="radio" name="receiver.id" class="receiverId" value="${receiver.id}"<#if receiver.isDefault> checked</#if> />
											<strong>${bundle("goods.order.ship.name")}: </strong>${receiver.name}&nbsp;&nbsp;
											<#if receiver.mobile?? && receiver.mobile != "">
												<strong>${bundle("goods.order.ship.mobile")}: </strong>${receiver.mobile}&nbsp;&nbsp;
											<#else>
												<strong>${bundle("goods.order.ship.phone")}: </strong>${receiver.phone}&nbsp;&nbsp;
											</#if>
											<strong>${bundle("goods.order.ship.address")}: </strong>${receiver.area.displayName}${receiver.address}
										</label>
									</li>
								</#list>
								<li>
									<label>
										<input type="radio" id="otherReceiver" name="receiver.id"  class="receiverId" value=""<#if (!loginMember.receiverSet?? || loginMember.receiverSet?size == 0)> checked</#if> />
										<strong>${bundle("goods.order.ship.address.fill")}</strong>
									</label>
									<div class="blank"></div>
									<table id="otherReceiverTable" class="otherReceiverTable">
										<tr>
											<th>
												${bundle("goods.order.ship.username")}: 
											</th>
											<td>
												<input type="text" name="receiver.name" class="formText" />
												<label class="requireField">*</label>
											</td>
										</tr>
										<tr>
											<th>
												${bundle("goods.common.area")}: 
											</th>
											<td>
												<input type="text" id="areaSelect" name="areaId" class="hidden" />
												<label class="requireField">*</label>
											</td>
										</tr>
										<tr>
											<th>
												${bundle("goods.common.address")}: 
											</th>
											<td>
												<input type="text" name="receiver.address" class="formText" />
												<label class="requireField">*</label>
											</td>
										</tr>
										<tr>
											<th>
												${bundle("goods.order.ship.phone")}: 
											</th>
											<td>
												<input type="text" id="receiverPhone" name="receiver.phone" class="formText" />
												<label class="requireField">*</label>
											</td>
										</tr>
										<tr>
											<th>
												${bundle("goods.order.ship.mobile")}: 
											</th>
											<td>
												<input type="text" name="receiver.mobile" class="formText" />
												<label class="requireField">*</label>
											</td>
										</tr>
										<tr>
											<th>
												${bundle("goods.order.ship.zipcode")}: 
											</th>
											<td>
												<input type="text" name="receiver.zipCode" class="formText" />
												<label class="requireField">*</label>
											</td>
										</tr>
										<tr>
											<th>
												${bundle("goods.common.setting")}: 
											</th>
											<td>
												<label>
													<@checkbox name="isSaveReceiver" value="true" />${bundle("goods.order.ship.address.save")}
												</label>
											</td>
										</tr>
									</table>
								</li>
							</ul>
						</td>
					</tr>
					<tr>
						<th>${bundle("goods.payment.delivery")}</th>
						<td>
							<table id="deliveryTypeTable" class="deliveryTypeTable">
								<#list allDeliveryTypeList as deliveryType>
									<tr>
										<th>
											<label>
												<input type="radio" name="deliveryType.id" value="${deliveryType.id}" deliveryFee="${deliveryType.getDeliveryFee(totalProductWeight)}" deliveryMethod="${deliveryType.deliveryMethod}" /> ${deliveryType.name}
											</label>
										</th>
										<td>
											<strong class="red">+ ${(deliveryType.getDeliveryFee(totalProductWeight)?string(currencyFormat))!}</strong>
											<#if deliveryType.description??>
												<p>${deliveryType.description}</p>
											</#if>
										</td>
									</tr>
								</#list>
							</table>
						</td>
					</tr>
					<tr id="paymentConfigTr" class="paymentConfigTr">
						<th>${bundle("goods.payment.way")}</th>
						<td>
							<table id="paymentConfigTable" class="paymentConfigTable">
								<#list allPaymentConfigList as paymentConfig>
									<tr>
										<th>
											<label>
												<input type="radio" name="paymentConfig.id" value="${paymentConfig.id}" paymentFeeType="${paymentConfig.paymentFeeType}" paymentFee="${paymentConfig.paymentFee}" /> ${paymentConfig.name}
											</label>
										</th>
										<td>
											<#if paymentConfig.paymentFeeType == "scale" && paymentConfig.paymentFee != 0>
												[${bundle("goods.payment.ratio")}: ${paymentConfig.paymentFee}%]
											<#elseif paymentConfig.paymentFeeType == "fixed" && paymentConfig.paymentFee != 0>
												[${bundle("goods.payment.fee")}: ${paymentConfig.paymentFee?string(currencyFormat)}]
											</#if>
											<#if paymentConfig.description??>
												<p>${paymentConfig.description}</p>
											</#if>
										</td>
									</tr>
								</#list>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<th>${bundle("goods.order.ship.addition")}</th>
						<td>
							<input type="text" name="memo" class="formText" />
						</td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
				</table>
				<div class="blank"></div>
				<table class="cartItemTable">
					<tr>
						<th>${bundle("goods.notify.memberCenter.goods.image")}</th>
						<th>${bundle("goods.notify.memberCenter.goods.name")}</th>
						<th>${bundle("goods.order.sale.price")}</th>
						<#if (loginMember.memberRank.preferentialScale != 100)!>
							<th>${bundle("goods.order.sale.scale")}</th>
						</#if>
						<th>${bundle("goods.order.weight")}</th>
						<th>${bundle("goods.order.calculate")}</th>
						<th>${bundle("goods.common.number")}</th>
					</tr>
					<#list cartItemSet as cartItem>
						<#assign product = cartItem.product />
						<#assign goods = cartItem.product.goods />
						<tr>
							<td class="goodsImage">
								<a href="${base}${goods.htmlPath}" target="_blank">
									<img src="${base}${goods.defaultThumbnailGoodsImagePath}" />
								</a>
							</td>
							<td>
								<a href="${base}${goods.htmlPath}" target="_blank">
									${product.name}
								</a>
							</td>
							<#if (loginMember.memberRank.preferentialScale != 100)!>
								<td class="priceTd">
									<span class="lineThrough">${product.price?string(currencyFormat)}</span>
								</td>
								<td class="priceTd">
									${cartItem.preferentialPrice?string(currencyFormat)}
								</td>
							<#else>
								<td class="priceTd">
									${product.price?string(currencyFormat)}
								</td>
							</#if>
							<td>
								${product.weight} ${bundle("goods.common.unit.gram")}
							</td>
							<td>
								<span class="subtotalPrice">${cartItem.subtotalPrice?string(currencyFormat)}</span>
							</td>
							<td>
								${cartItem.quantity}
							</td>
						</tr>
					</#list>
					<tr>
						<td class="info" colspan="<#if (loginMember.memberRank.preferentialScale != 100)!>7<#else>6</#if>">
							${bundle("goods.order.total")}: <span class="red">${totalProductQuantity}</span> ${bundle("goods.common.unit.goods")}&nbsp;&nbsp;
							<#if setting.scoreType != "disable">
								${bundle("goods.common.score")}: <span id="totalScore" class="red">${totalScore}</span>&nbsp;&nbsp;
							</#if>
							${bundle("goods.payment.goods.cost")}: <span id="totalProductPrice" class="red">${totalProductPrice?string(currencyFormat)}</span>&nbsp;&nbsp;
							${bundle("goods.order.price")}: <span id="deliveryFee" class="red">${0?string(currencyFormat)}</span>&nbsp;&nbsp;
							${bundle("goods.payment.goods.payment.fee")}: <span id="paymentFee" class="red">${0?string(currencyFormat)}</span>&nbsp;&nbsp;
							${bundle("goods.payment.order.cost")}: <span id="orderAmount" class="red">${(totalProductPrice)?string(currencyFormat)}</span>
						</td>
					</tr>
				</table>
				<div class="blank"></div>
				<a class="backCartItem" href="${base}/shop/cart_item!list.action"><span class="icon">&nbsp;</span>${bundle("goods.order.return")}</a>
				<input type="submit" class="formButton" value="${bundle("goods.order.payment")}" />
				<div class="blank"></div>
			</form>
		</div>
		<div class="blank"></div>
		<#include "/WEB-INF/template/shop/friend_link.ftl">
	</div>
	<div class="blank"></div>
	<#include "/WEB-INF/template/shop/footer.ftl">
</body>
</html>