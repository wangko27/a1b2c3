<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("goods.notify.memberCenter.profile.password.find")} - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
</head>
<body>
<p>${bundle("goods.head.login.dear")}${member.username}: </p>
<p>${bundle("goods.head.login.hello")}!${bundle("goods.head.login.thank")}${setting.shopName}。</p>
<p>
	${bundle("goods.mail.password.notice")}<a href="${setting.shopUrl}/shop/member!passwordModify.action?id=${member.id}&passwordRecoverKey=${member.passwordRecoverKey}">${bundle("goods.notify.memberCenter.profile.password.modify")}</a>${bundle("goods.mail.password.modifyNotice")}
</p>
</body>
</html>