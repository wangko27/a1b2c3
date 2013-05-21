<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="shipping.view.pagetitle"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
</head>
<body class="input">
	<div class="bar">
		<@s.text name="ship.view.pagetitle"/>
	</div>
	<div class="body">
		<table class="inputTable">
			<tr>
				<th>
					<@s.text name="shipping.shippingSn"/>: 
				</th>
				<td>
					${shipping.shippingSn}
				</td>
				<th>
					<@s.text name="shipping.order.orderSn"/>: 
				</th>
				<td>
					${(shipping.order.orderSn)!}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="shipping.createDate"/>: 
				</th>
				<td>
					${shipping.createDate?string("yyyy-MM-dd HH:mm:ss")}
				</td>
				<th>
					<@s.text name="shipping.deliveryTypeName"/>: 
				</th>
				<td>
					${shipping.deliveryTypeName}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="shipping.deliveryCorpName"/>: 
				</th>
				<td>
					${shipping.deliveryCorpName}
				</td>
				<th>
					<@s.text name="shipping.deliveryCorpName"/>: 
				</th>
				<td>
					${shipping.deliverySn}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="shipping.deliveryCorpName"/>: 
				</th>
				<td>
					${shipping.deliveryFee?string(currencyFormat)}
				</td>
				<th>
					<@s.text name="shipping.shipName"/>: 
				</th>
				<td>
					${shipping.shipName}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="shipping.shipArea.displayName"/>: 
				</th>
				<td>
					${shipping.shipArea.displayName}
				</td>
				<th>
					<@s.text name="shipping.shipAddress"/>: 
				</th>
				<td>
					${shipping.shipAddress}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="shipping.shipZipCode"/>: 
				</th>
				<td>
					${shipping.shipZipCode}
				</td>
				<th>
					<@s.text name="shipping.shipPhone"/>: 
				</th>
				<td>
					${shipping.shipPhone}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="shipping.shipMobile"/>: 
				</th>
				<td>
					${shipping.shipMobile}
				</td>
				<th>
					<@s.text name="shipping.memo"/>: 
				</th>
				<td>
					${shipping.memo}
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
				<th><@s.text name="deliveryItem.productSn"/></th>
				<th><@s.text name="deliveryItem.productName"/></th>
				<th><@s.text name="deliveryItem.deliveryQuantity"/></th>
			</tr>
			<#list shipping.deliveryItemSet as deliveryItem>
				<tr>
					<td>
						<a href="${base}${deliveryItem.goodsHtmlPath}" target="_blank">
							${deliveryItem.productSn}
						</a>
					</td>
					<td>
						<a href="${base}${deliveryItem.goodsHtmlPath}" target="_blank">
							${deliveryItem.productName}
						</a>
					</td>
					<td>
						${deliveryItem.deliveryQuantity}
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