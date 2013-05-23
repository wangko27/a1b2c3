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
		<@sec.authorize ifAnyGranted="ROLE_NAVIGATION,ROLE_ARTICLEE,ROLE_ARTICLE_CATEGORY,ROLE_FRIEND_LINK">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.content"/></span>
				</dt>
				<@sec.authorize ifAnyGranted="ROLE_NAVIGATION">
					<dd>
						<a href="navigation!list.action" target="mainFrame"><@s.text name="menu.manage.content.navigation"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_ARTICLEE">
					<dd>
						<a href="article!list.action" target="mainFrame"><@s.text name="menu.manage.content.article"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_ARTICLE_CATEGORY">
					<dd>
						<a href="article_category!list.action" target="mainFrame"><@s.text name="menu.manage.content.article_category"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_FRIEND_LINK">
					<dd>
						<a href="friend_link!list.action" target="mainFrame"><@s.text name="menu.manage.content.friend_link"/></a>
					</dd>
				</@sec.authorize>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_PAGE_TEMPLATE,ROLE_MAIL_TEMPLATE,ROLE_PRINT_TEMPLATE">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.content.template"/></span>
				</dt>
				<@sec.authorize ifAnyGranted="ROLE_PAGE_TEMPLATE">
					<dd>
						<a href="page_template!list.action" target="mainFrame"><@s.text name="menu.manage.content.template.page"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_MAIL_TEMPLATE">
					<dd>
						<a href="mail_template!list.action" target="mainFrame"><@s.text name="menu.manage.content.template.mail"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_PRINT_TEMPLATE">
					<dd>
						<a href="print_template!list.action" target="mainFrame"><@s.text name="menu.manage.content.template.print"/></a>
					</dd>
				</@sec.authorize>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_CACHE">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.cache"/></span>
				</dt>
				<dd>
					<a href="cache!flush.action" target="mainFrame"><@s.text name="menu.manage.cache.update"/></a>
				</dd>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_BUILD_HTML">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.buildhtml"/></span>
				</dt>
				<dd>
					<a href="build_html!allInput.action" target="mainFrame"><@s.text name="menu.manage.buildhtml.all"/></a>
				</dd>
				<dd>
					<a href="build_html!articleInput.action" target="mainFrame"><@s.text name="menu.manage.buildhtml.article"/></a>
				</dd>
				<dd>
					<a href="build_html!goodsInput.action" target="mainFrame"><@s.text name="menu.manage.buildhtml.goods"/></a>
				</dd>
			</dl>
		</@sec.authorize>
	</div>
</body>
</html>