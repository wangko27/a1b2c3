<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="reship.view.pagetitle"/> - Powered By SHOP++</title>
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
		<@s.text name="reship.list.pagetitle"/>
	</div>
	<div class="body">
		<table class="inputTable">
			<tr>
				<th>
					<@s.text name="reship.reshipSn"/>: 
				</th>
				<td>
					${reship.reshipSn}
				</td>
				<th>
					<@s.text name="reship.order.orderSn"/>: 
				</th>
				<td>
					${(reship.order.orderSn)!}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="reship.createDate"/>: 
				</th>
				<td>
					${reship.createDate?string("yyyy-MM-dd HH:mm:ss")}
				</td>
				<th>
					<@s.text name="reship.deliveryTypeName"/>: 
				</th>
				<td>
					${reship.deliveryTypeName}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="reship.deliveryCorpName"/>: 
				</th>
				<td>
					${reship.deliveryCorpName}
				</td>
				<th>
					<@s.text name="reship.deliverySn"/>: 
				</th>
				<td>
					${reship.deliverySn}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="reship.deliveryFee"/>: 
				</th>
				<td>
					${reship.deliveryFee?string(currencyFormat)}
				</td>
				<th>
					<@s.text name="reship.reshipName"/>:
				</th>
				<td>
					${reship.reshipName}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="reship.reshipArea.displayName"/>:
				</th>
				<td>
					${reship.reshipArea.displayName}
				</td>
				<th>
					<@s.text name="reship.reshipAddress"/>:
				</th>
				<td>
					${reship.reshipAddress}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="reship.reshipZipCode"/>: 
				</th>
				<td>
					${reship.reshipZipCode}
				</td>
				<th>
					<@s.text name="reship.reshipPhone"/>: 
				</th>
				<td>
					${reship.reshipPhone}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="reship.reshipMobile"/>: 
				</th>
				<td>
					${reship.reshipMobile}
				</td>
				<th>
					<@s.text name="reship.memo"/>: 
				</th>
				<td>
					${reship.memo}
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
				<th><@s.text name="reship.deliveryItem.deliveryQuantity"/></th>
			</tr>
			<#list reship.deliveryItemSet as deliveryItem>
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