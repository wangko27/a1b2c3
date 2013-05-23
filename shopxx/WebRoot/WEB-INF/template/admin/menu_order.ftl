<#assign sec=JspTaglibs["/WEB-INF/tld/security.tld"] />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="menu.pagetitle"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
</head>
<body class="menu">
	<div class="body">
		<@sec.authorize ifAnyGranted="ROLE_ORDER,ROLE_PAYMENT,ROLE_REFUND,ROLE_SHIPPING,ROLE_RESHIP">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.order"/></span>
				</dt>
				<@sec.authorize ifAnyGranted="ROLE_ORDER">
					<dd>
						<a href="order!list.action" target="mainFrame"><@s.text name="menu.manage.order.list"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_PAYMENT">
					<dd>
						<a href="payment!list.action" target="mainFrame"><@s.text name="menu.manage.order.payment"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_REFUND">
					<dd>
						<a href="refund!list.action" target="mainFrame"><@s.text name="menu.manage.order.refund"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_SHIPPING">
					<dd>
						<a href="shipping!list.action" target="mainFrame"><@s.text name="menu.manage.order.shipping"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_RESHIP">
					<dd>
						<a href="reship!list.action" target="mainFrame"><@s.text name="menu.manage.order.reship"/></a>
					</dd>
				</@sec.authorize>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_DELIVERY_CENTER,ROLE_DELIVERY_TEMPLATE">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.delivery"/></span>
				</dt>
				<@sec.authorize ifAnyGranted="ROLE_DELIVERY_CENTER">
					<dd>
						<a href="delivery_center!list.action" target="mainFrame"><@s.text name=""/><@s.text name="menu.manage.delivery.center"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_DELIVERY_TEMPLATE">
					<dd>
						<a href="delivery_template!list.action" target="mainFrame"><@s.text name="menu.manage.delivery.template"/></a>
					</dd>
				</@sec.authorize>
			</dl>
		</@sec.authorize>
	</div>
</body>
</html>