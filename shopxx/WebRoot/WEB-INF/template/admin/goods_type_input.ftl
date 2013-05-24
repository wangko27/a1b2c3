<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="goods.type.input.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $validateForm = $("#validateForm");

	var $tab = $("#tab");
	var $goodsAttributeTable = $("#goodsAttributeTable");
	var $addGoodsAttributeButton = $("#addGoodsAttributeButton");
	var $goodsParameterTable = $("#goodsParameterTable");
	var $addGoodsParameterButton = $("#addGoodsParameterButton");
	
	// Tab效果
	$tab.tabs(".tabContent", {
		tabs: "input"
	});
	
	// 增加商品属性
	var goodsAttributeIndex = ${(goodsType.goodsAttributeSet?size)!0};
	$addGoodsAttributeButton.click( function() {
	
		<@compress single_line = true>
			var goodsAttributeTrHtml = 
			'<tr class="goodsAttributeTr">
				<td>
					<input type="text" name="goodsAttributeList[' + goodsAttributeIndex + '].name" class="formText goodsAttributeListName" />
				</td>
				<td>
					<select name="goodsAttributeList[' + goodsAttributeIndex + '].attributeType" class="attributeType">
						<#list attributeTypeList as attributeType>
							<option value="${attributeType}">
								${action.getText("AttributeType." + attributeType)}
							</option>
						</#list>
					</select>
				</td>
				<td>
					<input type="text" name="goodsAttributeList[' + goodsAttributeIndex + '].optionText" class="formText optionText goodsAttributeListOptionText" title="<@s.text name="goods.type.input.selector.multiple"/>" />
				</td>
				<td>
					<input type="text" name="goodsAttributeList[' + goodsAttributeIndex + '].orderList" class="formText goodsAttributeListOrderList" style="width: 30px;" />
				</td>
				<td>
					<span class="deleteIcon deleteGoodsAttributeIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
				</td>
			</tr>';
		</@compress>
		
		if ($goodsAttributeTable.find(".goodsAttributeTr").length >= 20) {
			$.dialog({type: "warn", content: "<@s.text name="goods.type.input.attribute.overflow"/>!", modal: true, autoCloseTime: 3000});
		} else {
			$goodsAttributeTable.append(goodsAttributeTrHtml);
			goodsAttributeIndex ++;
		}
	});
	
	// 修改商品属性类型
	$("#goodsAttributeTable .attributeType").live("click", function() {
		var $this = $(this);
		var $optionText = $this.parent().parent().find(".optionText")
		if ($this.val() == "filter") {
			$optionText.attr("disabled", false).show();
		} else {
			$optionText.attr("disabled", true).hide();
		}
	});
	
	// 删除商品属性
	$("#goodsAttributeTable .deleteGoodsAttributeIcon").live("click", function() {
		$(this).parent().parent().remove();
	});
	
	// 增加商品参数
	var goodsParameterIndex = ${(goodsType.goodsParameterList?size)!0};
	$addGoodsParameterButton.click( function() {
		
		<@compress single_line = true>
			var goodsParameterTrHtml = 
			'<tr class="goodsParameterTr">
				<td>
					<input type="text" name="goodsParameterList[' + goodsParameterIndex + '].name" class="formText goodsParameterListName" />
				</td>
				<td>
					<input type="text" name="goodsParameterList[' + goodsParameterIndex + '].orderList" class="formText goodsParameterListOrderList" style="width: 30px;" />
				</td>
				<td>
					<span class="deleteIcon deleteGoodsParameterIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
				</td>
			</tr>';
		</@compress>
		
		$goodsParameterTable.append(goodsParameterTrHtml);
		goodsParameterIndex ++;
	});
	
	// 删除商品参数
	$("#goodsParameterTable .deleteGoodsParameterIcon").live("click", function() {
		var $this = $(this);
		$this.parent().parent().remove();
	});
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"goodsType.name": {
				required: true
			}
		},
		messages: {
			"goodsType.name": {
				required: "<@s.text name="goods.type.input.type.name"/>"
			}
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
	$.validator.addMethod("goodsAttributeListNameRequired", $.validator.methods.required, "<@s.text name="goods.type.input.attribute.name"/>");
	$.validator.addMethod("goodsAttributeListOptionTextRequired", $.validator.methods.required, "<@s.text name="goods.type.input.attribute.name.select"/>");
	$.validator.addMethod("goodsAttributeListOrderListDigits", $.validator.methods.digits, "<@s.text name="goods.type.input.attribute.sort.require"/>");
	$.validator.addMethod("goodsParameterListNameRequired", $.validator.methods.required, "<@s.text name="goods.type.input.param.name"/>");
	$.validator.addMethod("goodsParameterListOrderListDigits", $.validator.methods.digits, "<@s.text name="goods.type.input.param.require"/>");
	
	$.validator.addClassRules("goodsAttributeListName", {
		goodsAttributeListNameRequired: true
	});
	$.validator.addClassRules("goodsAttributeListOptionText", {
		goodsAttributeListOptionTextRequired: true
	});
	$.validator.addClassRules("goodsAttributeListOrderList", {
		goodsAttributeListOrderListDigits: true
	});
	$.validator.addClassRules("goodsParameterListName", {
		goodsParameterListNameRequired: true
	});
	$.validator.addClassRules("goodsParameterListOrderList", {
		goodsParameterListOrderListDigits: true
	});

})
</script>
</head>
<body class="input goodsType">
	<div class="bar">
		<#if isAddAction><@s.text name="goods.type.input.add"/><#else><@s.text name="goods.type.input.edit"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>goods_type!save.action<#else>goods_type!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${id}" />
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="<@s.text name="goods.compare.head1"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="goods.picture.list.goods.brand"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="goods.input.goods.properties"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="goods.content.bottom.options.attribute"/>" hidefocus />
				</li>
			</ul>
			<table class="inputTable tabContent">
				<tr>
					<th>
						<@s.text name="goods.type.name"/>: 
					</th>
					<td>
						<input type="text" name="goodsType.name" class="formText" value="${(goodsType.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
			</table>
			<table class="inputTable tabContent">
				<tr class="noneHover">
					<th>
						<@s.text name="goods.picture.list.goods.brand"/>: 
					</th>
					<td>
						<div class="brandSelect">
							<ul>
								<#list allBrandList as brand>
									<li>
										<label>
											<input type="checkbox" name="brandList.id" value="${brand.id}"<#if (goodsType.brandSet.contains(brand))!> checked</#if> />${brand.name}
										</label>
									</li>
								</#list>
							</ul>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						&nbsp;
					</th>
					<td>
						<span class="warnInfo"><span class="icon">&nbsp;</span><@s.text name="goods.type.input.brand.default"/></span>
					</td>
				</tr>
			</table>
			<table id="goodsAttributeTable" class="inputTable tabContent">
				<tr class="noneHover">
					<td colspan="5">
						<input type="button" id="addGoodsAttributeButton" class="formButton" value="<@s.text name="goods.type.input.attribute.add"/>" hidefocus />
					</td>
				</tr>
				<tr class="title">
					<th>
						<@s.text name="goods.type.input.attribute.name"/>
					</th>
					<th>
						<@s.text name="goods.type.input.attribute.type"/>
					</th>
					<th>
						<@s.text name="goods.type.input.attribute.select"/>
					</th>
					<th>
						<@s.text name="goods.specification.list.search.result.header.order"/>
					</th>
					<th>
						<@s.text name="common.button.delete"/>
					</th>
				</tr>
				<#list (goodsType.goodsAttributeSet)! as goodsAttribute>
					<tr class="goodsAttributeTr">
						<td>
							<input type="hidden" name="goodsAttributeList[${goodsAttribute_index}].id" value="${goodsAttribute.id}" />
							<input type="hidden" name="goodsAttributeList[${goodsAttribute_index}].propertyIndex" value="${goodsAttribute.propertyIndex}" />
							<input type="text" name="goodsAttributeList[${goodsAttribute_index}].name" class="formText goodsAttributeListName" value="${goodsAttribute.name}" />
						</td>
						<td>
							<select name="goodsAttributeList[${goodsAttribute_index}].attributeType" class="attributeType">
								<#list attributeTypeList as attributeType>
									<option value="${attributeType}"<#if (attributeType == goodsAttribute.attributeType)!> selected</#if>>
										${action.getText("AttributeType." + attributeType)}
									</option>
								</#list>
							</select>
						</td>
						<td>
							<#if goodsAttribute.attributeType == "filter">
								<input type="text" name="goodsAttributeList[${goodsAttribute_index}].optionText" class="formText optionText goodsAttributeListOptionText" value="${goodsAttribute.optionText}" title="<@s.text name="goods.type.input.selector.multiple"/>" />
							<#else>
								<input type="text" name="goodsAttributeList[${goodsAttribute_index}].optionText" class="formText hidden optionText goodsAttributeListOptionText" title="<@s.text name="goods.type.input.selector.multiple"/>" disabled />
							</#if>
						</td>
						<td>
							<input type="text" name="goodsAttributeList[${goodsAttribute_index}].orderList" class="formText goodsAttributeListOrderList" value="${goodsAttribute.orderList}" style="width: 30px;" />
						</td>
						<td>
							<span class="deleteIcon deleteGoodsAttributeIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
						</td>
					</tr>
				</#list>
			</table>
			<table id="goodsParameterTable" class="inputTable tabContent">
				<tr class="noneHover">
					<td colspan="3">
						<input type="button" id="addGoodsParameterButton" class="formButton" value="<@s.text name="goods.type.input.param.add"/>" hidefocus />
					</td>
				</tr>
				<tr class="title">
					<th>
						<@s.text name="goods.type.input.param"/>
					</th>
					<th>
						<@s.text name="goods.specification.list.search.result.header.order"/>
					</th>
					<th>
						<@s.text name="common.button.delete"/>
					</th>
				</tr>
				<#list (goodsType.goodsParameterList)! as goodsParameter>
					<tr class="goodsParameterTr">
						<td>
							<input type="hidden" name="goodsParameterList[${goodsParameter_index}].id" value="${goodsParameter.id}" />
							<input type="text" name="goodsParameterList[${goodsParameter_index}].name" class="formText goodsParameterListName" value="${goodsParameter.name}" />
						</td>
						<td>
							<input type="text" name="goodsParameterList[${goodsParameter_index}].orderList" class="formText goodsParameterListOrderList" value="${goodsParameter.orderList}" style="width: 30px;" />
						</td>
						<td>
							<span class="deleteIcon deleteGoodsParameterIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
						</td>
					</tr>
				</#list>
			</table>
			<div class="buttonArea">
				<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />
				&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>