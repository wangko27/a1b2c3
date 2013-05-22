<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="page.index.pagetitle"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
</head>
<body class="index">
	<div class="bar">
		<@s.text name="page.index.bar"/>
	</div>
	<div class="body">
		<div class="bodyLeft">
			<table class="listTable">
				<tr>
					<th colspan="2">
						<@s.text name="page.index.waitforhandle"/>
					</th>
				</tr>
				<tr>
					<td width="110">
						<@s.text name="page.index.waitforhandle.unprocessedOrderCount"/>: 
					</td>
					<td>
						${unprocessedOrderCount} <a href="order!list.action">[<@s.text name="page.index.waitforhandle.unprocessedOrderCount.link"/>]</a>
					</td>
				</tr>
				<tr>
					<td width="110">
						<@s.text name="page.index.waitforhandle.paidUnshippedOrderCount"/>: 
					</td>
					<td>
						${paidUnshippedOrderCount} <a href="order!list.action">[<@s.text name="page.index.waitforhandle.unprocessedOrderCount.link"/>]</a>
					</td>
				</tr>
				<tr>
					<td>
						<@s.text name="page.index.waitforhandle.unreadMessageCount"/>: 
					</td>
					<td>
						${unreadMessageCount} <a href="message!inbox.action">[<@s.text name="page.index.waitforhandle.unreadMessageCount.link"/>]</a>
					</td>
				</tr>
				<tr>
					<td>
						<@s.text name="page.index.waitforhandle.unprocessedGoodsNotifyCount"/>: 
					</td>
					<td>
						${unprocessedGoodsNotifyCount} <a href="goods_notify!list.action">[<@s.text name="page.index.waitforhandle.unprocessedGoodsNotifyCount.link"/>]</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="bodyRight">
			<table class="listTable">
				<tr>
					<th colspan="2">
						<@s.text name="page.index.infostat"/>
					</th>
				</tr>
				<tr>
					<td width="110">
						<@s.text name="page.index.infostat.marketableGoodsCount"/>: 
					</td>
					<td>
						${marketableGoodsCount}
					</td>
				</tr>
				<tr>
					<td>
						<@s.text name="page.index.infostat.unMarketableGoodsCount"/>: 
					</td>
					<td>
						${unMarketableGoodsCount}
					</td>
				</tr>
				<tr>
					<td>
						<@s.text name="page.index.infostat.memberTotalCount"/>: 
					</td>
					<td>
						${memberTotalCount}
					</td>
				</tr>
				<tr>
					<td>
						<@s.text name="page.index.infostat.articleTotalCount"/>: 
					</td>
					<td>
						${articleTotalCount}
					</td>
				</tr>
			</table>
		</div>
		<p class="copyright">Copyright © 2005-2011 shopxx.net All Rights Reserved.</p>
	</div>
</body>
</html>