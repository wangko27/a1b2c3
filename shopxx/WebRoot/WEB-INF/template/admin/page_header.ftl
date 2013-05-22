<#assign sec=JspTaglibs["/WEB-INF/tld/security.tld"] />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="page.header.pagetitle"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $menuItem = $("#menu .menuItem");
	var $previousMenuItem;
	
	$menuItem.click( function() {
		var $this = $(this);
		if ($previousMenuItem != null) {
			$previousMenuItem.removeClass("current");
		}
		$previousMenuItem = $this;
		$this.addClass("current");
	})

})
</script>
</head>
<body class="header">
	<div class="body">
		<div class="bodyLeft">
			<div class="logo"></div>
		</div>
		<div class="bodyRight">
			<div class="link">
				<span class="welcome">
					<strong><@sec.authentication property="name" /></strong>&nbsp;<@s.text name="page.header.welcome"/>!&nbsp;
				</span>
				<a href="page!index.action" target="mainFrame"><@s.text name="page.header.home"/></a>|
            	<a href="http://bbs.shopxx.net" target="_blank"><@s.text name="page.header.support"/></a>|
                <a href="http://www.shopxx.net" target="_blank"><@s.text name="page.header.buy"/></a>|
                <a href="http://www.shopxx.net/about.html" target="_blank"><@s.text name="page.header.about"/></a>|
                <a href="http://www.shopxx.net/contact.html" target="_blank"><@s.text name="page.header.contact"/></a>
			</div>
			<div id="menu" class="menu">
				<ul>
					<@sec.authorize ifAnyGranted="ROLE_GOODS,ROLE_GOODS_NOTIFY,ROLE_GOODS_CATEGORY,ROLE_GOODS_TYPE,ROLE_GOODS_ATTRIBUTE,ROLE_SPECIFICATION,ROLE_BRAND">
						<li class="menuItem">
							<a href="menu!goods.action" target="menuFrame" hidefocus><@s.text name="page.header.menu.managegoods"/></a>
						</li>
					</@sec.authorize>
					<@sec.authorize ifAnyGranted="ROLE_ORDER,ROLE_PAYMENT,ROLE_REFUND,ROLE_SHIPPING,ROLE_RESHIP,ROLE_DELIVERY_CENTER,ROLE_DELIVERY_TEMPLATE">
						<li class="menuItem">
							<a href="menu!order.action" target="menuFrame" hidefocus><@s.text name="page.header.menu.handleorder"/></a>
						</li>
					</@sec.authorize>
					<@sec.authorize ifAnyGranted="ROLE_MEMBER,ROLE_MEMBER_RANK,ROLE_MEMBER_ATTRIBUTE,ROLE_COMMENT,ROLE_LEAVE_MESSAGE">
						<li class="menuItem">
							<a href="menu!member.action" target="menuFrame" hidefocus><@s.text name="page.header.menu.managemember"/></a>
						</li>
					</@sec.authorize>
					<@sec.authorize ifAnyGranted="ROLE_NAVIGATION,ROLE_ARTICLEE,ROLE_ARTICLE_CATEGORY,ROLE_FRIEND_LINK,ROLE_AGREEMENT,ROLE_PAGE_TEMPLATE,ROLE_MAIL_TEMPLATE,ROLE_PRINT_TEMPLATE,ROLE_CACHE,ROLE_BUILD_HTML">
						<li class="menuItem">
							<a href="menu!content.action" target="menuFrame" hidefocus><@s.text name="page.header.menu.pagecontent"/></a>
						</li>
					</@sec.authorize>
					<@sec.authorize ifAnyGranted="ROLE_ADMIN,ROLE_ROLE,ROLE_MESSAGE,ROLE_LOG">
						<li class="menuItem">
							<a href="menu!admin.action" target="menuFrame" hidefocus><@s.text name="page.header.menu.admin"/></a>
						</li>
					</@sec.authorize>
					<@sec.authorize ifAnyGranted="ROLE_SETTING,ROLE_INSTANT_MESSAGING,ROLE_PAYMENT_CONFIG,ROLE_DELIVERY_TYPE,ROLE_AREA,ROLE_DELIVERY_CORP">
						<li class="menuItem">
							<a href="menu!setting.action" target="menuFrame" hidefocus><@s.text name="page.header.menu.sitesetting"/></a>
						</li>
					</@sec.authorize>
					<li class="home">
						<a href="${base}/" target="_blank" hidefocus><@s.text name="page.header.menu.sitehome"/></a>
					</li>
	            </ul>
	            <div class="info">
					<a class="profile" href="admin_profile!edit.action" target="mainFrame"><@s.text name="page.header.menu.profile"/></a>
					<a class="logout" href="${base}/admin/logout" target="_top"><@s.text name="page.header.menu.logout"/></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>