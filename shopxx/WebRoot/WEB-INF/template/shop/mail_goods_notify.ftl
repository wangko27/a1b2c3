<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("goods.notify.product.notice")} - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
</head>
<body>
<p>${bundle("goods.head.login.dear")}${(goodsNotify.member.username)!"${bundle("goods.common.consumer")}"}: </p>
<p>${bundle("goods.notify.memberCenter.notify.notify")}</p>
<p>&nbsp;</p>
<p>${bundle("goods.notify.memberCenter.goods.name")}: ${goodsNotify.product.name}</p>
<p>${bundle("goods.notify.product.sn")}: ${goodsNotify.product.productSn}</p>
<p>
	${bundle("goods.notify.product.detail")}: <a href="${setting.shopUrl}${goodsNotify.product.goods.htmlPath}" target="_blank">${bundle("goods.common.clickshow")}</a>
</p>
</body>
</html>