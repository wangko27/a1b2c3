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
		<@sec.authorize ifAnyGranted="ROLE_GOODS,ROLE_GOODS_NOTIFY">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.goods"/></span>
				</dt>
				<@sec.authorize ifAnyGranted="ROLE_GOODS">
					<dd>
						<a href="goods!list.action" target="mainFrame"><@s.text name="menu.manage.goods.list"/></a>
					</dd>
					<dd>
						<a href="goods!add.action" target="mainFrame"><@s.text name="menu.manage.goods.add"/></a>
					</dd>
				</@sec.authorize>
				<@sec.authorize ifAnyGranted="ROLE_GOODS_NOTIFY">
					<dd>
						<a href="goods_notify!list.action" target="mainFrame"><@s.text name="menu.manage.goods.notify"/></a>
					</dd>
				</@sec.authorize>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_GOODS_CATEGORY">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.goodscategory"/></span>
				</dt>
				<dd>
					<a href="goods_category!list.action" target="mainFrame"><@s.text name="menu.manage.goodscategory.list"/></a>
				</dd>
				<dd>
					<a href="goods_category!add.action" target="mainFrame"><@s.text name="menu.manage.goodscategory.add"/></a>
				</dd>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_GOODS_TYPE,ROLE_GOODS_ATTRIBUTE">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.goodstype"/></span>
				</dt>
				<@sec.authorize ifAnyGranted="ROLE_GOODS_TYPE">
					<dd>
						<a href="goods_type!list.action" target="mainFrame"><@s.text name="menu.manage.goodstype.lis"/></a>
					</dd>
					<dd>
						<a href="goods_type!add.action" target="mainFrame"><@s.text name="menu.manage.goodstype.add"/></a>
					</dd>
				</@sec.authorize>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_SPECIFICATION">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.specification"/></span>
				</dt>
				<dd>
					<a href="specification!list.action" target="mainFrame"><@s.text name="menu.manage.specification.list"/></a>
				</dd>
				<dd>
					<a href="specification!add.action" target="mainFrame"><@s.text name="menu.manage.specification.add"/></a>
				</dd>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_BRAND">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.brand"/></span>
				</dt>
				<dd>
					<a href="brand!list.action" target="mainFrame"><@s.text name="menu.manage.brand.list"/></a>
				</dd>
				<dd>
					<a href="brand!add.action" target="mainFrame"><@s.text name="menu.manage.brand.add"/></a>
				</dd>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_BRAND">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.car_make"/></span>
				</dt>
				<dd>
					<a href="car_make!list.action" target="mainFrame"><@s.text name="menu.manage.car_make.list"/></a>
				</dd>
				<dd>
					<a href="car_make!search.action" target="mainFrame"><@s.text name="menu.manage.car_make.add"/></a>
				</dd>
			</dl>
		</@sec.authorize>
	</div>
</body>
</html>