<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="article.input.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/common/editor/kindeditor.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $validateForm = $("#validateForm");
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"article.title": "required",
			"article.content": "required",
			"article.articleCategory.id": "required"
		},
		messages: {
			"article.title": "<@s.text name="article.input.head"/>",
			"article.content": "<@s.text name="article.input.content"/>",
			"article.articleCategory.id": "<@s.text name="article.input.category"/>"
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
})
</script>
</head>
<body class="input">
	<div class="bar">
		<#if isAddAction><@s.text name="article.input.add"/><#else><@s.text name="article.input.edit"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>article!save.action<#else>article!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${id}" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="article.input.article"/>: 
					</th>
					<td>
						<input type="text" name="article.title" class="formText" value="${(article.title)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="article.input.article.category"/>: 
					</th>
					<td>
						<select name="article.articleCategory.id" >
							<option value=""><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
							<#list articleCategoryTreeList as articleCategoryTree>
								<option value="${articleCategoryTree.id}"<#if (articleCategoryTree == article.articleCategory)!> selected</#if>>
									<#if articleCategoryTree.grade != 0>
										<#list 1..articleCategoryTree.grade as i>
											&nbsp;&nbsp;
										</#list>
									</#if>
									${articleCategoryTree.name}
								</option>
							</#list>
						</select>
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="article.author.title"/>: 
					</th>
					<td>
						<input type="text" class="formText" name="article.author" value="${(article.author)!}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.common.setting"/>: 
					</th>
					<td>
						<label>
							<@checkbox name="article.isPublication" value="${(article.isPublication)!true}" /><@s.text name="article.input.operation.publish"/>
						</label>
						<label>
							<@checkbox name="article.isRecommend" value="${(article.isRecommend)!false}" /><@s.text name="article.input.operation.recommend"/>
						</label>
						<label>
							<@checkbox name="article.isTop" value="${(article.isTop)!false}" /><@s.text name="article.input.operation.setTop"/>
						</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.message.context"/>: 
					</th>
					<td>
						<textarea id="editor" name="article.content" class="editor">${(article.content)!}</textarea>
						<div class="blank"></div>
					</td>
				</tr>
				<tr>
					<th>
						&nbsp;
					</th>
					<td>
						<span class="warnInfo"><span class="icon">&nbsp;</span><@s.text name="article.input.operation.page.notice"/> {nextPage} <@s.text name="article.input.operation.page.sign"/></span>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.category.article.pageKey"/>: 
					</th>
					<td>
						<input type="text" class="formText" name="article.metaKeywords" value="${(article.metaKeywords)!}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.category.article.pageDescription"/>: 
					</th>
					<td>
						<textarea name="article.metaDescription" class="formTextarea">${(article.metaDescription)!}</textarea>
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