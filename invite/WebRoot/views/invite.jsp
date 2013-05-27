<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>爱语吧-主页</title>
<script type="text/javascript" src="/static/js/main.js"></script>
<script type="text/javascript" src="/static/js/jquery.js"></script>
<script type="text/javascript" src="/static/js/invite.js"></script>
<link type="text/css" rel="stylesheet" href="/static/css/main.css" />
<link type="text/css" rel="stylesheet" href="/static/css/invite.css" />
</head>
<body>
<%@ include file="/common/navigation.jsp"%>
	<div align="center" id="container"><!--最外层容器-->
		<div align="left" id="body"><!--body部分-->
			<div id="inviteTitle">邀请好友加入爱语吧</div>
			<div id="inviteSubTitle">和更多的好友分享学习生活的点滴</div>
			<div class="inviteMethod" id="method1">
				<div class="methodTitle">方法一: 链接邀请</div>
				<div class="methodDescription">通过QQ、MSN发送邀请链接给你的朋友</div>
				<div class="methodText">
					<input class="inputTxt" type="text" value="http://www.iyuba.com/?token=${linkConfig.token }"/>
					<input class="inputBtn" type="button" value="复制链接"/>
				</div>
			</div>
			<div class="inviteMethod" id="method2">
				<div class="methodTitle">方法二: 发邮箱邀请</div>
				<div class="methodDescription">请输入要发送的邮箱</div>
				<div class="methodText">
					<input class="inputTxt" type="text"/>
					<input class="inputBtn" type="button" value="发送邀请"/>
				</div>
			</div>
		</div><!--body结束-->
	</div>
<%@ include file="/common/bottom.jsp" %>
</body>

</html>
