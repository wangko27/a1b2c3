<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>添加/编辑文章分类 - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.translate.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready( function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $validateForm = $("#validateForm");

	var $articleCategoryName = $("#articleCategoryName");
	var $articleCategorySign = $("#articleCategorySign");
	var $articleCategorySignLoadingIcon = $("#articleCategorySignLoadingIcon");

	$articleCategoryName.change( function() {
		var $this = $(this);
		$this.translate("zh", "en", {
			data: true,
			replace: false,
			start: function() {
				$articleCategorySignLoadingIcon.show();
			},
			complete: function() {
				var articleCategorySignValue = $.trim($this.data("translation").en.value.toLowerCase()).replace(/\s+/g, "_").replace(/[^\w]+/g, "");
				$articleCategorySign.val(articleCategorySignValue);
				$articleCategorySignLoadingIcon.hide();
			},
			error: function() {
				$articleCategorySignLoadingIcon.hide();
			}
		});

	});

	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"articleCategory.name": "required",
			"articleCategory.sign": {
				required: true,
				alphanumeric: true,
				<#if isAddAction>
					remote: "article_category!checkSign.action"
				<#else>
					remote: "article_category!checkSign.action?oldValue=${articleCategory.sign?url}"
				</#if>
			},
			"articleCategory.orderList": "digits"
		},
		messages: {
			"articleCategory.name": "<@s.text name="admin.category.article.name"/>",
			"articleCategory.sign": {
				required: "<@s.text name="admin.category.article.require"/>",
				alphanumeric: "<@s.text name="admin.category.article.require.number"/>",
				remote: "<@s.text name="admin.category.article.require.exist"/>"
			},
			"articleCategory.orderList": "<@s.text name="area.input.area.order"/>"
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
});
</script>
</head>
<body class="input">
	<div class="bar">
		<#if isAddAction><@s.text name="admin.category.article.add"/><#else><@s.text name="admin.category.article.edit"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>article_category!save.action<#else>article_category!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${id}" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="admin.category.name"/>: 
					</th>
					<td>
						<input type="text" id="articleCategoryName" name="articleCategory.name" class="formText" value="${(articleCategory.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.category.super"/>: 
					</th>
					<td>
						<#if isAddAction>
							<select name="parentId">
								<option value=""><@s.text name="admin.category.top"/></option>
								<#list articleCategoryTreeList as articleCategoryTree>
									<option value="${articleCategoryTree.id}">
										<#if articleCategoryTree.grade != 0>
											<#list 1..articleCategoryTree.grade as i>
												&nbsp;&nbsp;
											</#list>
										</#if>
										${articleCategoryTree.name}
									</option>
								</#list>
							</select>
						<#else>
							${(articleCategory.parent.name)!'<@s.text name="admin.category.top"/>'}
						</#if>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.category.article.require.sign"/>: 
					</th>
					<td>
						<input type="text" id="articleCategorySign" name="articleCategory.sign" class="formText" value="${(articleCategory.sign)!}" title="<@s.text name="admin.category.article.require.sign.unique"/>" />
						<label class="requireField">*</label>
						<span id="articleCategorySignLoadingIcon" class="loadingIcon hidden">&nbsp;</span>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.specification.list.search.result.header.order"/>: 
					</th>
					<td>
						<input type="text" name="articleCategory.orderList" class="formText" value="${(articleCategory.orderList)!}" title="<@s.text name="admin.category.article.require.positive"/>" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.category.article.pageKey"/>: 
					</th>
					<td>
						<input type="text" class="formText" name="articleCategory.metaKeywords" value="${(articleCategory.metaKeywords)!}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.category.article.pageDescription"/>: 
					</th>
					<td>
						<textarea name="articleCategory.metaDescription" class="formTextarea">${(articleCategory.metaDescription)!}</textarea>
					</td>
				</tr>
				<tr>
					<th>
						&nbsp;
					</th>
					<td>
						<span class="warnInfo"><span class="icon">&nbsp;</span><@s.text name="admin.category.article.pageSearch"/></span>
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