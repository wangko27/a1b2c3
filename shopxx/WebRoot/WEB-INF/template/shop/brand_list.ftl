<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("search.brand.title")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/shop/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/shop.css" rel="stylesheet" type="text/css" />
<!--[if lte IE 6]>
	<script type="text/javascript" src="${base}/template/common/js/belatedPNG.js"></script>
	<script type="text/javascript">
		// 解决IE6透明PNG图片BUG
		DD_belatedPNG.fix(".belatedPNG");
	</script>
<![endif]-->
<style type="text/css">
<!--
.leaveMessageItem {
	line-height: 18px;
	padding: 5px 10px;
	border: 1px solid #c7dbe5;
	background-color: #ecf2f8;
}

.leaveMessageItem .reply {
	line-height: 18px;
	padding: 5px 10px;
	margin: 3px 0px;
	border: 1px solid #c7dbe5;
	background-color: #ffffff;
}

.sendTable {
	width: 100%;
	line-height: 30px;
	border: 1px solid #c7dbe5;
}

.sendTable .title td {
	height: 30px;
	padding-left: 10px;
	text-align: left;
	font-weight: bold;
	background-color: #ecf2f8;
}

.sendTable th {
	text-align: right;
	font-weight: normal;
}

.sendTable td {
	padding: 5px;
}

.sendTable .captcha {
	width: 95px;
	margin-right: 5px;
	text-transform: uppercase;
}

.sendTable .captchaImage {
	vertical-align: middle;
	cursor: pointer;
}
-->
</style>
</head>
<body class="singlePage">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body leaveMessage">
		<div class="goodsPictureList">
			<ul class="goodsListDetail">
				<#list brandList as brand>
				<li>
					<a href="/shopxx/shop/goods!search.action?pager.keyword=${brand.name}" class="goodsImage" target="_blank">
						${brand.name}
					</a>
				</li>
				</#list>
			</ul>
			<div class="blank"></div>
		</div>
		<div class="blank"></div>
		<#include "/WEB-INF/template/shop/friend_link.ftl">
	</div>
	<div class="blank"></div>
	<#include "/WEB-INF/template/shop/footer.ftl">
</body>
</html>