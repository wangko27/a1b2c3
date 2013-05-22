<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="order.view.pagetitle"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready( function() {

	var $tab = $("#tab");
	
	// Tab效果
	$tab.tabs(".tabContent", {
		tabs: "input"
	});

});
</script>
</head>
<body class="input">
	<div class="bar">
		<@s.text name="order.view.pagetitle"/>
	</div>
	<div class="body">
		<ul id="tab" class="tab" style="padding-left: 80px;">
			<li>
				<input type="button" value="<@s.text name="order.view.tab.orderinfo"/>" hidefocus />
			</li>
			<li>
				<input type="button" value="<@s.text name="order.view.tab.goodsinfo"/>" hidefocus />
			</li>
			<li>
				<input type="button" value="<@s.text name="order.view.tab.receivemoney"/>" hidefocus />
			</li>
			<li>
				<input type="button" value="<@s.text name="order.view.tab.refund"/>" hidefocus />
			</li>
			<li>
				<input type="button" value="<@s.text name="order.view.tab.receivegoods"/>" hidefocus />
			</li>
			<li>
				<input type="button" value="<@s.text name="order.view.tab.returngoods"/>" hidefocus />
			</li>
			<li>
				<input type="button" value="<@s.text name="order.view.tab.orderlog"/>" hidefocus />
			</li>
		</ul>
		<table class="inputTable tabContent">
			<tr>
				<th>
					<@s.text name="order.orderStatus"/>: 
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
					<span class="red">${order.totalProductPrice?string(currencyFormat)}</span>
				</td>
				<th>
					<@s.text name="order.totalAmount"/>: 
				</th>
				<td>
					<span class="red">${order.totalAmount?string(currencyFormat)}</span>&nbsp;&nbsp;
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
					<@s.text name="order.deliveryTypeName"/>: 
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
					<@s.text name="order.totalProductWeight"/>: 
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
					<@s.text name="order.shipName"/>: 
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
					<@s.text name="order.shipZipCode"/>: 
				</th>
				<td>
					${order.shipZipCode}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="order.shipPhone"/>: 
				</th>
				<td>
					${order.shipPhone}
				</td>
				<th>
					<@s.text name="order.shipMobile"/>: 
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
		<table class="inputTable tabContent">
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
		</table>
		<table class="inputTable tabContent">
			<tr class="title">
				<th><@s.text name="payment.index"/></th>
				<th><@s.text name="payment.paymentSn"/></th>
				<th><@s.text name="payment.paymentType"/></th>
				<th><@s.text name="payment.paymentConfigName"/></th>
				<th><@s.text name="payment.totalAmount"/></th>
				<th><@s.text name="payment.paymentFee"/></th>
				<th><@s.text name="payment.payer"/></th>
				<th><@s.text name="payment.paymentStatus"/></th>
				<th><@s.text name="payment.createDate"/></th>
			</tr>
			<#list order.paymentSet as payment>
				<tr>
					<td>${payment_index + 1}</td>
					<td>
						<a href="payment!view.action?id=${payment.id}">
							${payment.paymentSn}
						</a>
					</td>
					<td>
						${action.getText("PaymentType." + payment.paymentType)}
					</td>
					<td>
						${payment.paymentConfigName}
					</td>
					<td>
						${payment.totalAmount?string(currencyFormat)}
					</td>
					<td>
						${payment.paymentFee?string(currencyFormat)}
					</td>
					<td>
						${payment.payer}
					</td>
					<td>
						${action.getText("PaymentStatus." + payment.paymentStatus)}
					</td>
					<td>
						<span title="${payment.createDate?string("yyyy-MM-dd HH:mm:ss")}">${payment.createDate}</span>
					</td>
				</tr>
			</#list>
		</table>
		<table class="inputTable tabContent">
			<tr class="title">
				<th><@s.text name="refund.index"/></th>
				<th><@s.text name="refund.refundSn"/></th>
				<th><@s.text name="refund.refundType"/></th>
				<th><@s.text name="refund.paymentConfigName"/></th>
				<th><@s.text name="refund.totalAmount"/></th>
				<th><@s.text name="refund.payee"/></th>
				<th><@s.text name="refund.createDate"/></th>
			</tr>
			<#list order.refundSet as refund>
				<tr>
					<td>${refund_index + 1}</td>
					<td>
						<a href="refund!view.action?id=${refund.id}">
							${refund.refundSn}
						</a>
					</td>
					<td>
						${action.getText("RefundType." + refund.refundType)}
					</td>
					<td>
						${refund.paymentConfigName}
					</td>
					<td>
						${refund.totalAmount?string(currencyFormat)}
					</td>
					<td>
						${refund.payee}
					</td>
					<td>
						<span title="${refund.createDate?string("yyyy-MM-dd HH:mm:ss")}">${refund.createDate}</span>
					</td>
				</tr>
			</#list>
		</table>
		<table class="inputTable tabContent">
			<tr class="title">
				<th><@s.text name="shipping.index"/></th>
				<th><@s.text name="shipping.shippingSn"/></th>
				<th><@s.text name="shipping.deliveryTypeName"/></th>
				<th><@s.text name="shipping.deliveryCorpName"/></th>
				<th><@s.text name="shipping.deliverySn"/></th>
				<th><@s.text name="shipping.deliveryFee"/></th>
				<th><@s.text name="shipping.shipName"/></th>
				<th><@s.text name="shipping.shipArea.displayName"/></th>
				<th><@s.text name="shipping.createDate"/></th>
			</tr>
			<#list order.shippingSet as shipping>
				<tr>
					<td>${shipping_index + 1}</td>
					<td>
						<a href="shipping!view.action?id=${shipping.id}">
							${shipping.shippingSn}
						</a>
					</td>
					<td>
						${shipping.deliveryTypeName}
					</td>
					<td>
						${shipping.deliveryCorpName}
					</td>
					<td>
						${shipping.deliverySn}
					</td>
					<td>
						${shipping.deliveryFee?string(currencyFormat)}
					</td>
					<td>
						${shipping.shipName}
					</td>
					<td>
						${shipping.shipArea.displayName}
					</td>
					<td>
						<span title="${shipping.createDate?string("yyyy-MM-dd HH:mm:ss")}">${shipping.createDate}</span>
					</td>
				</tr>
			</#list>
		</table>
		<table class="inputTable tabContent">
			<tr class="title">
				<th><@s.text name="reship.index"/></th>
				<th><@s.text name="reship.reshipSn"/></th>
				<th><@s.text name="reship.deliveryTypeName"/></th>
				<th><@s.text name="reship.deliveryCorpName"/></th>
				<th><@s.text name="reship.deliverySn"/></th>
				<th><@s.text name="reship.deliveryFee"/></th>
				<th><@s.text name="reship.reshipName"/></th>
				<th><@s.text name="reship.reshipArea.displayName"/></th>
				<th><@s.text name="reship.createDate"/></th>
			</tr>
			<#list order.reshipSet as reship>
				<tr>
					<td>${reship_index + 1}</td>
					<td>
						<a href="reship!view.action?id=${reship.id}">
							${reship.reshipSn}
						</a>
					</td>
					<td>
						${reship.deliveryTypeName}
					</td>
					<td>
						${reship.deliveryCorpName}
					</td>
					<td>
						${reship.deliverySn}
					</td>
					<td>
						${reship.deliveryFee?string(currencyFormat)}
					</td>
					<td>
						${reship.reshipName}
					</td>
					<td>
						${reship.reshipArea.displayName}
					</td>
					<td>
						<span title="${reship.createDate?string("yyyy-MM-dd HH:mm:ss")}">${reship.createDate}</span>
					</td>
				</tr>
			</#list>
		</table>
		<table class="inputTable tabContent">
			<tr class="title">
				<th><@s.text name="orderLog.index"/></th>
				<th><@s.text name="orderLog.orderLogType"/></th>
				<th><@s.text name="orderLog.operator"/></th>
				<th><@s.text name="orderLog.info"/></th>
				<th><@s.text name="orderLog.createDate"/></th>
			</tr>
			<#list order.orderLogSet as orderLog>
				<tr>
					<td>${orderLog_index + 1}</td>
					<td>
						${action.getText("OrderLogType." + orderLog.orderLogType)}
					</td>
					<td>
						${orderLog.operator!"[<@s.text name="orderLog.operator.user"/>]"}
					</td>
					<td>
						${orderLog.info!"-"}
					</td>
					<td>
						<span title="${orderLog.createDate?string("yyyy-MM-dd HH:mm:ss")}">${orderLog.createDate}</span>
					</td>
				</tr>
			</#list>
		</table>
		<div class="buttonArea">
			<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
		</div>
	</div>
</body>
</html>