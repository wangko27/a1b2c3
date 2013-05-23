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
		<dl>
			<dt>
				<span><@s.text name="menu.manage.member"/></span>
			</dt>
			<@sec.authorize ifAnyGranted="ROLE_MEMBER">
				<dd>
					<a href="member!list.action" target="mainFrame"><@s.text name="menu.manage.member"/></a>
				</dd>
			</@sec.authorize>
			<@sec.authorize ifAnyGranted="ROLE_MEMBER_RANK">
				<dd>
					<a href="member_rank!list.action" target="mainFrame"><@s.text name="menu.manage.member.rank"/></a>
				</dd>
			</@sec.authorize>
			<@sec.authorize ifAnyGranted="ROLE_MEMBER_ATTRIBUTE">
				<dd>
					<a href="member_attribute!list.action" target="mainFrame"><@s.text name="menu.manage.member.attribute"/></a>
				</dd>
			</@sec.authorize>
		</dl>
		<@sec.authorize ifAnyGranted="ROLE_COMMENT">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.comment"/></span>
				</dt>
				<dd>
					<a href="comment!list.action" target="mainFrame"><@s.text name="menu.manage.comment.list"/></a>
				</dd>
				<dd>
					<a href="comment!setting.action" target="mainFrame"><@s.text name="menu.manage.comment.setting"/></a>
				</dd>
			</dl>
		</@sec.authorize>
		<@sec.authorize ifAnyGranted="ROLE_LEAVE_MESSAGE">
			<dl>
				<dt>
					<span><@s.text name="menu.manage.leavemessage"/></span>
				</dt>
				<dd>
					<a href="leave_message!list.action" target="mainFrame"><@s.text name="menu.manage.leavemessage.list"/></a>
				</dd>
				<dd>
					<a href="leave_message!setting.action" target="mainFrame"><@s.text name="menu.manage.leavemessage.setting"/></a>
				</dd>
			</dl>
		</@sec.authorize>
	</div>
</body>
</html>