<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="goods.category.input.title"/> - Powered By SHOP++</title>
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
	var $goodsCategoryName = $("#goodsCategoryName");
	var $goodsCategorySign = $("#goodsCategorySign");
	var $goodsCategorySignLoadingIcon = $("#goodsCategorySignLoadingIcon");

	$goodsCategoryName.change( function() {
		var $this = $(this);
		$this.translate("zh", "en", {
			data: true,
			replace: false,
			start: function() {
				$goodsCategorySignLoadingIcon.show();
			},
			complete: function() {
				var goodsCategorySignValue = $.trim($this.data("translation").en.value.toLowerCase()).replace(/\s+/g, "_").replace(/[^\w]+/g, "");
				$goodsCategorySign.val(goodsCategorySignValue);
				$goodsCategorySignLoadingIcon.hide();
			},
			error: function() {
				$goodsCategorySignLoadingIcon.hide();
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
			"goodsCategory.name": "required",
			"goodsCategory.sign": {
				required: true,
				alphanumeric: true,
				<#if isAddAction>
					remote: "goods_category!checkSign.action"
				<#else>
					remote: "goods_category!checkSign.action?oldValue=${goodsCategory.sign?url}"
				</#if>
			},
			"goodsCategory.orderList": "digits"
		},
		messages: {
			"goodsCategory.name": "<@s.text name="admin.category.article.name"/>",
			"goodsCategory.sign": {
				required: "<@s.text name="admin.category.article.require"/>",
				alphanumeric: "<@s.text name="goods.category.input.sign.require"/>",
				remote: "<@s.text name="admin.category.article.require.exist"/>"
			},
			"goodsCategory.orderList": "<@s.text name="area.input.area.order"/>"
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
		<#if isAddAction><@s.text name="goods.category.input.add"/><#else><@s.text name="goods.category.input.edit"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>goods_category!save.action<#else>goods_category!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${id}" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="admin.category.name"/>: 
					</th>
					<td>
						<input type="text" id="goodsCategoryName" name="goodsCategory.name" class="formText" value="${(goodsCategory.name)!}" />
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
								<#list goodsCategoryTreeList as goodsCategoryTree>
									<option value="${goodsCategoryTree.id}">
										<#if goodsCategoryTree.grade != 0>
											<#list 1..goodsCategoryTree.grade as i>
												&nbsp;&nbsp;
											</#list>
										</#if>
										${goodsCategoryTree.name}
									</option>
								</#list>
							</select>
						<#else>
							${(goodsCategory.parent.name)!'<@s.text name="admin.category.top"/>'}
						</#if>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.category.input.type"/>: 
					</th>
					<td>
						<select name="goodsCategory.goodsType.id">
							<option value=""><@s.text name="goods.category.input.type.common"/></option>
							<#list allGoodsTypeList as goodsType>
								<option value="${goodsType.id}"<#if (goodsType == goodsCategory.goodsType)!> selected</#if>>
									${goodsType.name}
								</option>
							</#list>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.category.article.require.sign"/>: 
					</th>
					<td>
						<input type="text" id="goodsCategorySign" name="goodsCategory.sign" class="formText" value="${(goodsCategory.sign)!}" title="<@s.text name="admin.category.article.require.sign.unique"/>" />
						<label class="requireField">*</label>
						<span id="goodsCategorySignLoadingIcon" class="loadingIcon hidden">&nbsp;</span>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.specification.list.search.result.header.order"/>: 
					</th>
					<td>
						<input type="text" name="goodsCategory.orderList" class="formText" value="${(goodsCategory.orderList)!}" title="<@s.text name="admin.category.article.require.positive"/>" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.category.article.pageKey"/>: 
					</th>
					<td>
						<input type="text" name="goodsCategory.metaKeywords" class="formText" value="${(goodsCategory.metaKeywords)!}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.category.article.pageDescription"/>: 
					</th>
					<td>
						<textarea name="goodsCategory.metaDescription" class="formTextarea">${(goodsCategory.metaDescription)!}</textarea>
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