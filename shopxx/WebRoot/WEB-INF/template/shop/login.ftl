<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("login.title")}</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<#if (article.metaKeywords)! != ""><meta name="keywords" content="${article.metaKeywords}" /></#if>
<#if (article.metaDescription)! != ""><meta name="description" content="${article.metaDescription}" /></#if>
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/shop/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/shop.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/base.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/shop.js"></script>
<!--[if lte IE 6]>
	<script type="text/javascript" src="${base}/template/common/js/belatedPNG.js"></script>
	<script type="text/javascript">
		DD_belatedPNG.fix(".belatedPNG");
	</script>
<![endif]-->
<script type="text/javascript">
	$().ready(function() {
	
		var $loginForm = $("#loginForm");
		var $loginRedirectUrl = $("#loginRedirectUrl");
		var $memberUsername = $("#memberUsername");
		var $memberPassword = $("#memberPassword");
		var $captcha = $("#captcha");
		var $captchaImage = $("#captchaImage");
		var $submitButton = $("#submitButton");
		
		$loginRedirectUrl.val(getParameter("loginRedirectUrl"));
		
		// 刷新验证码图片
		$captchaImage.click( function() {
			$captchaImage.attr("src", shopxx.base + "/captcha.jpeg?timestamp" + (new Date()).valueOf());
		});
	
		// 表单验证
		$loginForm.submit( function() {
			if ($.trim($memberUsername.val()) == "") {
				$.dialog({type: "warn", content: "${bundle("login.error.username")}", modal: true, autoCloseTime: 3000});
				return false;
			}
			if ($.trim($memberPassword.val()) == "") {
				$.dialog({type: "warn", content: "${bundle("login.error.password")}", modal: true, autoCloseTime: 3000});
				return false;
			}
			if ($.trim($captcha.val()) == "") {
				$.dialog({type: "warn", content: "${bundle("login.error.captcha")}", modal: true, autoCloseTime: 3000});
				return false;
			}
		});
		
		// 获取参数
		function getParameter(name) {
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)","i");
			var r = window.location.search.substr(1).match(reg);
			if (r != null) {
				return decodeURIComponent(r[2]);
			} else {
				return null;
			}
		}
	
	})
</script>
</head>
<body class="login">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="blank"></div>
	<div class="body">
		<div class="loginDetail">
			<div class="top">${bundle("login.title")}</div>
			<div class="middle">
				<form id="loginForm" action="${base}/shop/member!login.action" method="post">
					<input type="hidden" id="loginRedirectUrl" name="loginRedirectUrl" />
					<table>
						<tr>
							<th>${bundle("login.field.username")}</th>
							<td>
								<input type="text" id="memberUsername" name="member.username" class="formText" />
							</td>
						</tr>
						<tr>
							<th>${bundle("login.field.password")}</th>
							<td>
								<input type="password" id="memberPassword" name="member.password" class="formText" />
							</td>
						</tr>
						<tr>
							<th>${bundle("login.field.captcha")}</th>
							<td>
								<input type="text" id="captcha" name="j_captcha" class="formText captcha" />
								<img id="captchaImage" class="captchaImage" src="${base}/captcha.jpeg" alt="${bundle("login.field.captcha.tips")}" />
							</td>
						</tr>
						<tr>
							<th>&nbsp;</th>
							<td>
								<span class="warnIcon">&nbsp;</span>
								<a href="${base}/shop/member!passwordRecover.action">${bundle("login.fogotpassword.tips")}</a>
							</td>
						</tr>
						<tr>
							<th>&nbsp;</th>
							<td>
								<input type="submit" id="submitButton" class="formButton" value="${bundle("login.button.name")}" hidefocus />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="bottom"></div>
		</div>
		<div class="blank"></div>
		<div class="blank"></div>
		<#include "/WEB-INF/template/shop/friend_link.ftl">
	</div>
	<div class="blank"></div>
	<#include "/WEB-INF/template/shop/footer.ftl">
</body>
</html>