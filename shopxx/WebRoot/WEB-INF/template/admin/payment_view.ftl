<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="payment.view.pagetitle"/> - Powered By SHOP++</title>
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
		<@s.text name="payment.view.pagetitle"/>
	</div>
	<div class="body">
		<table class="inputTable">
			<tr>
				<th>
					<@s.text name="payment.paymentSn"/>: 
				</th>
				<td>
					${payment.paymentSn}
				</td>
				<th>
					<@s.text name="payment.order.orderSn"/>: 
				</th>
				<td>
					${(payment.order.orderSn)!}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="payment.paymentType"/>: 
				</th>
				<td>
					${action.getText("PaymentType." + payment.paymentType)}
				</td>
				<th>
					<@s.text name="payment.paymentConfigName"/>: 
				</th>
				<td>
					${payment.paymentConfigName}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="payment.bankName"/>: 
				</th>
				<td>
					${payment.bankName}
				</td>
				<th>
					<@s.text name="payment.bankAccount"/>: 
				</th>
				<td>
					${payment.bankAccount}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="payment.totalAmount"/>: 
				</th>
				<td>
					${payment.totalAmount?string(currencyFormat)}
				</td>
				<th>
					<@s.text name="payment.paymentFee"/>: 
				</th>
				<td>
					${payment.paymentFee?string(currencyFormat)}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="payment.payer"/>: 
				</th>
				<td>
					${payment.payer}
				</td>
				<th>
					<@s.text name="payment.operator"/>: 
				</th>
				<td>
					${payment.operator}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="payment.paymentStatus"/>:  
				</th>
				<td>
					${action.getText("PaymentStatus." + payment.paymentStatus)}
				</td>
				<th>
					<@s.text name="payment.memo"/>: 
				</th>
				<td>
					${payment.memo}
				</td>
			</tr>
		</table>
		<div class="buttonArea">
			<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
		</div>
	</div>
</body>
</html>