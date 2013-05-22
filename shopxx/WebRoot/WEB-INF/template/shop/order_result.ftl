<#assign s=JspTaglibs["/WEB-INF/tld/struts.tld"] />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("goods.order.result")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/shop/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/shop.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/base.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/shop.js"></script>
<!--[if lte IE 6]>
	<script type="text/javascript" src="${base}/template/common/js/belatedPNG.js"></script>
	<script type="text/javascript">
		// 解决IE6透明PNG图片BUG
		DD_belatedPNG.fix(".belatedPNG");
	</script>
<![endif]-->
</head>
<body class="orderResult">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body">
		<div class="blank"></div>
		<div class="orderResultDetail">
			<div class="message"><span class="icon">&nbsp;</span>&nbsp;&nbsp;${bundle("goods.order.submited")}!</div>
			<div class="blank"></div>
			<table class="listTable">
				<tr>
					<th colspan="2">${bundle("goods.order.info")}</th>
				</tr>
				<tr>
					<td class="title">${bundle("goods.notify.memberCenter.order.sn")}</td>
					<td>
						${order.orderSn}
						<a href="${base}/shop/order!view.action?id=${order.id}">[${bundle("goods.order.view.show")}]</a>
					</td>
				</tr>
				<tr>
					<td class="title">${bundle("goods.payment.order.cost")}</td>
					<td><span class="red">${order.totalAmount?string(currencyFormat)}</span></td>
				</tr>
			</table>
			<div class="blank"></div>
			<table class="listTable">
				<tr>
					<th colspan="2">${bundle("goods.payment.delivery.info")}</th>
				</tr>
				<tr>
					<td class="title">${bundle("goods.payment.delivery")}</td>
					<td>${order.deliveryTypeName}</td>
				</tr>
			</table>
			<#if order.paymentConfig??>
				<form action="${base}/shop/payment!submit.action" method="post">
					<@s.token />
					<#if paymentConfig.paymentConfigType == "deposit">
						<input type="hidden" name="paymentType" value="deposit" />
					<#elseif  paymentConfig.paymentConfigType == "offline">
						<input type="hidden" name="paymentType" value="offline" />
					<#else>
						<input type="hidden" name="paymentType" value="online" />
					</#if>
					<input type="hidden" name="order.id" value="${order.id}" />
					<div class="blank"></div>
					<table class="listTable">
						<tr>
							<th colspan="2">${bundle("goods.payment.info")}</th>
						</tr>
						<tr>
							<td class="title">${bundle("goods.payment.way")}</td>
							<td>${order.paymentConfigName}</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="submit" class="formButton" value="${bundle("goods.payment.rightnow")}" />
							</td>
						</tr>
					</table>
				</form>
			<#else>
				<table class="listTable">
					<tr>
						<th colspan="2">${bundle("goods.payment.info")}</th>
					</tr>
					<tr>
						<td class="title">${bundle("goods.payment.way")}</td>
						<td>${order.paymentConfigName}</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="button" class="formButton" onclick="window.location.href='${base}/'" value="${bundle("goods.common.ok")}" />
						</td>
					</tr>
				</table>
			</#if>
		</div>
		<div class="blank"></div>
		<#include "/WEB-INF/template/shop/friend_link.ftl">
	</div>
	<div class="blank"></div>
	<#include "/WEB-INF/template/shop/footer.ftl">
</body>
</html>