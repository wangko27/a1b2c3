<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="order.print.pagetitle"/></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<!--[if lte IE 6]>
	<script type="text/javascript" src="${base}/template/common/js/belatedPNG.js"></script>
	<script type="text/javascript">
		// 解决IE6透明PNG图片BUG
		DD_belatedPNG.fix(".belatedPNG");
	</script>
<![endif]-->
<script type="text/javascript">
$().ready(function() {
	
	var $printButton = $("#printButton");
	
	$printButton.click(function(){
		window.print();
		return false;
	});

})

try {
	var WScriptShell = new ActiveXObject("WScript.Shell");
	WScriptShell.RegWrite("HKEY_CURRENT_USER\\Software\\Microsoft\\Internet Explorer\\PageSetup\\header", "");
	WScriptShell.RegWrite("HKEY_CURRENT_USER\\Software\\Microsoft\\Internet Explorer\\PageSetup\\footer", "");
} catch(e) {

}

</script>
<style type="text/css" media="screen,print">
<!--

.print .header {
	height: 30px;
	clear: both;
}

.print .printBar {
	width: 100%;
	height: 30px;
	padding: 5px 0px;
	position: fixed;
	top: 0px;
	_position: absolute;
	_top: expression(eval(document.documentElement.scrollTop));
	z-index: 99;
	text-align: center;
	border-bottom: 1px solid #7b7b7b;
	background-color: #e9f0f4;
}

.print .body {
	padding: 20px 20px 60px 20px;
	position: absolute;
	font-size: 12px;
}

.print .title {
	height: 60px;
	line-height: 30px;
	font-size: 12px;
}

.print .title strong {
	font-size: 14px;
}

.print table {
	width: 100%;
	text-align: left;
}

.print table tr {
	line-height: 30px;
}

.print table tr td, .print table tr th {
	padding: 0px 2px;
}

.print .separated th, .print .separated td {
	border-top: 2px solid #000000;
	border-bottom: 2px solid #000000;
}

-->
</style>
<style type="text/css" media="print">

.print .header {
	display: none;
}

</style>
</head>
<body class="print">
	<div class="header">
		<div class="printBar">
			<input type="button" id="printButton" class="formButton" value="打 印" />
		</div>
	</div>
	<div class="body">
		<table>
			<tr class="title">
				<td colspan="2">
					<img class="belatedPNG" src="${base}${(setting.shopLogoPath)!}" />
				</td>
				<td>
					<strong>${(setting.shopName)!}</strong><br />
					${(setting.shopUrl)!}
				</td>
				<td>
					&nbsp;
				</td>
				<td colspan="2">
					<@s.text name="order.print.shipName"/>: ${order.shipName}<br />
					<@s.text name="order.print.member.username"/>: ${(order.member.username)!"-"}
				</td>
			</tr>
			<tr class="separated">
				<th colspan="2">
					<@s.text name="order.print.orderSn"/>: ${order.orderSn}
				</th>
				<th colspan="2">
					<@s.text name="order.print.createDate"/>: ${order.createDate?string("yyyy-MM-dd")}
				</th>
				<th colspan="2">
					<@s.text name="order.print.printdate"/>: <strong>${currentDate?string("yyyy-MM-dd")}</strong>
				</th>
			</tr>
			<tr>
				<td colspan="6">
					&nbsp;
				</td>
			</tr>
			<tr class="separated">
				<th>
					<@s.text name="order.orderItem.index"/>
				</th>
				<th>
                    <@s.text name="order.orderItem.productSn"/>
				</th>
				<th>
                    <@s.text name="order.orderItem.productName"/>
				</th>
				<th>
                    <@s.text name="order.orderItem.productPrice"/>
				</th>
				<th>
                    <@s.text name="order.orderItem.productQuantity"/>
				</th>
				<th>
					<@s.text name="order.orderItem.subtotal"/>
				</th>
			</tr>
			<#list order.orderItemSet as orderItem>
				<tr>
					<td>
						${orderItem_index + 1}
					</td>
					<td>
						${orderItem.productSn}
					</td>
					<td>
						${orderItem.productName}
					</td>
					<td>
						${orderItem.productPrice?string(currencyFormat)}
					</td>
					<td>
						${orderItem.productQuantity}
					</td>
					<td>
						${orderItem.subtotalPrice?string(currencyFormat)}
					</td>
				</tr>
			</#list>
			<tr>
				<td colspan="6">
					&nbsp;
				</td>
			</tr>
			<tr class="separated">
				<td colspan="3">
					<@s.text name="order.print.memo"/>: ${order.memo}<br />
				</td>
				<td colspan="3">
					<@s.text name="order.print.totalProductPrice"/>: ${order.totalProductPrice?string(currencyFormat)}<br />
					<@s.text name="order.print.deliveryFee"/>: ${order.deliveryFee?string(currencyFormat)}<br />
					<@s.text name="order.print.paymentFee"/>: ${order.paymentFee?string(currencyFormat)}<br />
					<@s.text name="order.print.totalAmount"/>: ${order.totalAmount?string(currencyFormat)}
				</td>
			</tr>
			<tr>
				<td colspan="6">
					&nbsp;
				</td>
			</tr>
			<tr class="separated">
				<td colspan="3">
					&nbsp;
				</td>
				<td colspan="3">
					<@s.text name="order.print.shipName"/>: ${order.shipName}<br />
					<@s.text name="order.print.shipAddress"/>: ${order.shipArea.displayName}${order.shipAddress}<br />
					<@s.text name="order.print.shipZipCode"/>: ${order.shipZipCode}<br />
					<@s.text name="order.print.shipPhone"/>: ${order.shipPhone}<br />
					<@s.text name="order.print.shipMobile"/>: ${order.shipMobile}<br />
					<@s.text name="order.print.deliveryTypeName"/>: ${order.deliveryTypeName}
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td colspan="2">
					Powered By shopxx.net
				</td>
			</tr>
		</table>
	</div>
</body>
</html>