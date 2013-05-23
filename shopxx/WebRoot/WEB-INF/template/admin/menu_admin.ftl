<#assign sec=JspTaglibs["/WEB-INF/tld/security.tld"] />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="menu.pagetitle"/></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
</head>
<body class="menu">
	<div class="body">
		<@sec.authorize ifAnyGranted="ROLE_ADMIN,ROLE_ROLE">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.admin"/>&nbsp;</span>
				</dt>
				<@sec.authorize ifAnyGranted="ROLE_ADMIN">
					<dd>
						<a href="admin!list.action" target="mainFrame"><@s.text name="menu.manage.admin.list"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_ROLE">
					<dd>
						<a href="role!list.action" target="mainFrame"><@s.text name="menu.manage.admin.role"/></a>
					</dd>
				</@sec.authorize>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_MESSAGE">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.message"/>&nbsp;</span>
				</dt>
				<dd>
					<a href="message!inbox.action" target="mainFrame"><@s.text name="menu.manage.inbox"/></a>
				</dd>
				<dd>
					<a href="message!outbox.action" target="mainFrame"><@s.text name="menu.manage.outbox"/></a>
				</dd>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_LOG">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.operatelog"/>&nbsp;</span>
				</dt>
				<dd>
					<a href="log!list.action" target="mainFrame"><@s.text name="menu.manage.operatelog.view"/></a>
				</dd>
			</dl>
		</@sec.authorize>
	</div>
</body>
</html>