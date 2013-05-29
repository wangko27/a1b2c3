<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.springframework.security.BadCredentialsException"%>
<%@page import="net.shopxx.util.SpringUtil"%>
<%@page import="net.shopxx.service.AdminService"%>
<%@page import="net.shopxx.entity.Admin"%>
<%@page import="net.shopxx.util.SettingUtil"%>
<%@page import="net.shopxx.bean.Setting"%>
<%@page import="org.springframework.security.DisabledException"%>
<%@page import="org.springframework.security.LockedException"%>
<%@page import="org.springframework.security.AccountExpiredException"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="freemarker.ext.beans.BeansWrapper"%>
<%@page import="freemarker.ext.beans.ResourceBundleModel"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 0);

	final String SPRING_SECURITY_LAST_EXCEPTION = "SPRING_SECURITY_LAST_EXCEPTION";

	ResourceBundle resourceBundle = ResourceBundle.getBundle("i18n");
	
	String base = request.getContextPath();
	ApplicationContext applicationContext = SpringUtil.getApplicationContext();
	if (applicationContext == null) {
%>
	<p><%=resourceBundle.getString("login.system.error1") %></p>
	<p><%=resourceBundle.getString("login.system.error2") %></p>
	<p>
		<a href="<%=base%>/install/index.html"><%=resourceBundle.getString("login.system.link1") %></a>
	</p>
<%
	return;
}

AdminService adminService = (AdminService) SpringUtil.getBean("adminServiceImpl");
Setting setting = SettingUtil.getSetting();
String adminLoginProcessingUrl = setting.getAdminLoginProcessingUrl();
String message = null;
String username = null;

String error = StringUtils.trim(request.getParameter("error"));
if (StringUtils.equalsIgnoreCase(error, "captcha")) {
	message = resourceBundle.getString("login.captcha.error");
} else {
	Exception springSecurityLastException = (Exception) session.getAttribute(SPRING_SECURITY_LAST_EXCEPTION);
	if (springSecurityLastException != null) {
		if (springSecurityLastException instanceof BadCredentialsException) {
			username = ((String) session.getAttribute("SPRING_SECURITY_LAST_USERNAME")).toLowerCase();
			Admin admin = adminService.getAdminByUsername(username);
			if (admin != null) {
				int loginFailureLockCount = setting.getLoginFailureLockCount();
				int loginFailureCount = admin.getLoginFailureCount();
				if (setting.getIsLoginFailureLock() && loginFailureLockCount - loginFailureCount <= 3) {
					message = resourceBundle.getString("login.account.error1.1") + loginFailureLockCount + resourceBundle.getString("login.account.error1.2");
				} else {
					message = resourceBundle.getString("login.account.error2");
				}
			} else {
				message = resourceBundle.getString("login.account.error2");
			}
		} else if (springSecurityLastException instanceof DisabledException) {
			message = resourceBundle.getString("login.account.error3");
		} else if (springSecurityLastException instanceof LockedException) {
			message = resourceBundle.getString("login.account.error4");
		} else if (springSecurityLastException instanceof AccountExpiredException) {
			message = resourceBundle.getString("login.account.error5");
		} else {
			message = resourceBundle.getString("login.account.error6");
		}
		session.removeAttribute(SPRING_SECURITY_LAST_EXCEPTION);
	}
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><%=resourceBundle.getString("page.main.pagetitle") %></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="<%=base%>/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="<%=base%>/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=base%>/template/common/js/jquery.js"></script>
<script type="text/javascript" src="<%=base%>/template/admin/js/base.js"></script>
<script type="text/javascript" src="<%=base%>/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready( function() {

	var $loginForm = $("#loginForm");
	var $username = $("#username");
	var $password = $("#password");
	var $captcha = $("#captcha");
	var $captchaImage = $("#captchaImage");
	var $isRememberUsername = $("#isRememberUsername");

	// 判断"记住用户名"功能是否默认选中,并自动填充登录用户名
	if(getCookie("adminUsername") != null) {
		$isRememberUsername.attr("checked", true);
		$username.val(getCookie("adminUsername"));
		$password.focus();
	} else {
		$isRememberUsername.attr("checked", false);
		$username.focus();
	}

	// 提交表单验证,记住登录用户名
	$loginForm.submit( function() {
		if ($username.val() == "") {
			$.dialog({type: "warn", content: "<%=resourceBundle.getString("login.username.warn") %>", modal: true, autoCloseTime: 3000});
			return false;
		}
		if ($password.val() == "") {
			$.dialog({type: "warn", content: "<%=resourceBundle.getString("login.password.warn") %>", modal: true, autoCloseTime: 3000});
			return false;
		}
		if ($captcha.val() == "") {
			$.dialog({type: "warn", content: "<%=resourceBundle.getString("login.captcha.warn") %>", modal: true, autoCloseTime: 3000});
			return false;
		}
		
		if ($isRememberUsername.attr("checked") == true) {
			var expires = new Date();
			expires.setTime(expires.getTime() + 1000 * 60 * 60 * 24 * 7);
			setCookie("adminUsername", $username.val(), expires);
		} else {
			removeCookie("adminUsername");
		}
		
	});

	// 刷新验证码
	$captchaImage.click( function() {
		var timestamp = (new Date()).valueOf();
		var imageSrc = $captchaImage.attr("src");
		if(imageSrc.indexOf("?") >= 0) {
			imageSrc = imageSrc.substring(0, imageSrc.indexOf("?"));
		}
		imageSrc = imageSrc + "?timestamp=" + timestamp;
		$captchaImage.attr("src", imageSrc);
	});

	<%if (message != null) {%>
		$.dialog({type: "error", content: "<%=message%>", modal: true, autoCloseTime: 3000});
	<%}%>

});
</script>
</head>
<body class="login">
	<script type="text/javascript">

		// 登录页面若在框架内，则跳出框架
		if (self != top) {
			top.location = self.location;
		};

	</script>
	<div class="blank"></div>
	<div class="blank"></div>
	<div class="blank"></div>
	<div class="body">
		<form id="loginForm" action="<%=base%><%=adminLoginProcessingUrl%>" method="post">
            <table class="loginTable">
            	<tr>
            		<td rowspan="3">
            			<img src="<%=base%>/template/admin/images/login_logo.gif" alt="<%=resourceBundle.getString("page.main.pagetitle") %>" />
            		</td>
                    <th>
                    	<%=resourceBundle.getString("login.field.username") %>:
                    </th>
					<td>
                    	<input type="text" id="username" name="j_username" class="formText" />
                    </td>
                </tr>
                <tr>
					<th>
						<%=resourceBundle.getString("login.field.password") %>:
					</th>
                    <td>
                    	<input type="password" id="password" name="j_password" class="formText" />
                    </td>
                </tr>
                <tr>
                	<th>
                		<%=resourceBundle.getString("login.field.captcha") %>:
                	</th>
                    <td>
                    	<input type="text" id="captcha" name="j_captcha" class="formText captcha" />
                   		<img id="captchaImage" class="captchaImage" src="<%=base%>/captcha.jpeg" alt="<%=resourceBundle.getString("login.field.captcha.tips") %>" />
                    </td>
                </tr>
                <tr>
                	<td>
                		&nbsp;
                	</td>
                	<th>
                		&nbsp;
                	</th>
                    <td>
                    	<label>
                    		<input type="checkbox" id="isRememberUsername" />&nbsp;<%=resourceBundle.getString("login.username.remember") %>
                    	</label>
                    </td>
                </tr>
                <tr>
                	<td>
                		&nbsp;
                	</td>
                	<th>
                		&nbsp;
                	</th>
                    <td>
                        <input type="button" class="homeButton" value="" onclick="window.open('<%=base%>/')" hidefocus /><input type="submit" class="submitButton" value="<%=resourceBundle.getString("login.button.name") %>" hidefocus />
                    </td>
                </tr>
            </table>
            <div class="powered">
            	COPYRIGHT © 2005-2011 SHOPXX.NET ALL RIGHTS RESERVED.
            </div>
            <div class="link">
            	<a href="<%=base%>/"><%=resourceBundle.getString("login.nav.home") %></a> |
				<a href="http://www.shopxx.net"><%=resourceBundle.getString("login.nav.site") %></a> |
				<a href="http://bbs.shopxx.net"><%=resourceBundle.getString("login.nav.form") %></a> |
				<a href="http://www.shopxx.net/about.html"><%=resourceBundle.getString("login.nav.about") %></a> |
				<a href="http://www.shopxx.net/contact.html"><%=resourceBundle.getString("login.nav.contact") %></a> |
				<a href="http://www.shopxx.net/license.html"><%=resourceBundle.getString("login.nav.license") %></a>
            </div>
        </form>
	</div>
</body>
</html>