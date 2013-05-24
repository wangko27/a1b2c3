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
		<@sec.authorize ifAnyGranted="ROLE_SETTING,ROLE_INSTANT_MESSAGING">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.sitesetting"/></span>
				</dt>
				<@sec.authorize ifAnyGranted="ROLE_SETTING">
					<dd>
						<a href="setting!edit.action" target="mainFrame"><@s.text name="menu.manage.sitesetting.system"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_INSTANT_MESSAGING">
					<dd>
						<a href="instant_messaging!edit.action" target="mainFrame"><@s.text name="menu.manage.sitesetting.service"/></a>
					</dd>
				</@sec.authorize>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_PAYMENT_CONFIG">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.payment"/></span>
				</dt>
				<dd>
					<a href="payment_config!list.action" target="mainFrame"><@s.text name="menu.manage.payment.config"/></a>
				</dd>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_DELIVERY_TYPE,ROLE_AREA,ROLE_DELIVERY_CORP">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.delivertype"/></span>
				</dt>
				<@sec.authorize ifAnyGranted="ROLE_DELIVERY_TYPE">
					<dd>
						<a href="delivery_type!list.action" target="mainFrame"><@s.text name="menu.manage.delivertype.type"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_AREA">
					<dd>
						<a href="area!list.action" target="mainFrame"><@s.text name="menu.manage.area"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_DELIVERY_CORP">
					<dd>
						<a href="delivery_corp!list.action" target="mainFrame"><@s.text name="menu.manage.delivery.corp"/></a>
					</dd>
				</@sec.authorize>
			</dl>
		</@sec.authorize>
	</div>
</body>
</html>