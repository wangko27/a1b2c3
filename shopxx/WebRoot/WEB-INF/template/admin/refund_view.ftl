<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="refund.view.pagetitle"/> - Powered By SHOP++</title>
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
		<@s.text name="refund.view.pagetitle"/>
	</div>
	<div class="body">
		<table class="inputTable">
			<tr>
				<th>
					<@s.text name="refund.refundSn"/>: 
				</th>
				<td>
					${refund.refundSn}
				</td>
				<th>
					<@s.text name="refund.order.orderSn"/>: 
				</th>
				<td>
					${(refund.order.orderSn)!}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="refund.refundType"/>: 
				</th>
				<td>
					${action.getText("PaymentType." + refund.refundType)}
				</td>
				<th>
					<@s.text name="refund.paymentConfigName"/>: 
				</th>
				<td>
					${refund.paymentConfigName}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="refund.bankName"/>: 
				</th>
				<td>
					${refund.bankName}
				</td>
				<th>
					<@s.text name="refund.bankAccount"/>: 
				</th>
				<td>
					${refund.bankAccount}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="refund.totalAmount"/>: 
				</th>
				<td>
					${refund.totalAmount?string(currencyFormat)}
				</td>
				<th>
					<@s.text name="refund.payee"/>: 
				</th>
				<td>
					${refund.payee}
				</td>
			</tr>
			<tr>
				<th>
					<@s.text name="refund.operator"/>: 
				</th>
				<td>
					${refund.operator}
				</td>
				<th>
					<@s.text name="refund.memo"/>: 
				</th>
				<td>
					${refund.memo}
				</td>
			</tr>
		</table>
		<div class="buttonArea">
			<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
		</div>
	</div>
</body>
</html>