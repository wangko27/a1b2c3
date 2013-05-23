<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="comment.setting.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
</head>
<body class="input">
	<div class="bar">
		<@s.text name="comment.setting.title"/>
	</div>
	<div class="body">
		<form id="validateForm" action="comment!settingUpdate.action" method="post">
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="comment.setting.publish.authorized"/>: 
					</th>
					<td>
						<select name="commentAuthority">
							<#list commentAuthorityList as list>
								<option value="${list}"<#if setting.commentAuthority == list> selected</#if>>
									${action.getText("CommentAuthority." + list)}
								</label>
							</#list>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="comment.setting.publish.show"/>: 
					</th>
					<td>
						<select name="commentDisplayType">
							<#list commentDisplayTypeList as list>
								<option value="${list}"<#if setting.commentDisplayType == list> selected</#if>>
									${action.getText("CommentDisplayType." + list)}
								</label>
							</#list>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.common.setting"/>
					</th>
					<td>
						<label>
							<@checkbox name="isCommentEnabled" value="${setting.isCommentEnabled}" /><@s.text name="comment.setting.publish.start"/>
						</label>
						<label>
							<@checkbox name="isCommentCaptchaEnabled" value="${setting.isCommentCaptchaEnabled}" /><@s.text name="comment.setting.captcha.start"/>
						</label>
					</td>
				</tr>
			</table>
			<div class="buttonArea">
				<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>