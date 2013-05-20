<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("error.page.pagetitle")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link href="${base}/template/shop/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/shop.css" rel="stylesheet" type="text/css" />
</head>
<body class="errorPage">
	<div class="body">
		<div class="errorBox">
			<div class="errorMessage">
				${errorContent!"${bundle("error.page.errorcontent")}"}
			</div>
			<div class="errorUrl">${bundle("error.page.back.part1")}<a href="javascript: void(0);" onclick="window.history.back(); return false;">${bundle("error.page.back.part2")}</a>${bundle("error.page.back.part3")}<a href="${base}/">${bundle("error.page.back.part4")}</a></div>
		</div>
	</div>
</body>
</html>