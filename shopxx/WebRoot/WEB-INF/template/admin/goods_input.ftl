<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="goods.input.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/common/editor/kindeditor.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
function uploadFileChange(obj, index){
	var path = obj.value;
	if(path && path != null && path != ''){
		var suffix = path.substring(path.lastIndexOf('.') + 1);
		$('#helpFile_' + index).val(suffix);
	}
}
$().ready(function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $tab = $("#tab");
	var $goodsForm = $("#goodsForm");
	var $specificationDisabledInfo = $("#infoTable .specificationDisabledInfo");
	var $goodsIsMarketable = $("#goodsIsMarketable");
	
	var $goodsImageTable = $("#goodsImageTable");
	var $addGoodsImageButton = $("#addGoodsImageButton");
	
	var $goodsHelpTable = $("#goodsHelpTable");
	var $addGoodsHelpButton = $("#addGoodsHelpButton");
	
	var $specificationTab = $("#specificationTab");
	var $specificationTable = $("#specificationTable");
	var $isSpecificationEnabled = $("#isSpecificationEnabled");
	var $specificationValueLoadingIcon  = $("#specificationValueLoadingIcon");
	var $specificationIds = $("#specificationSelect :checkbox");
	var $addProductButton = $("#addProductButton");
	var $productTable = $("#productTable");
	var $productTitle = $("#productTitle");
	var $specificationInsertTh = $("#specificationInsertTh");
	
	var $goodsTypeId = $("#goodsTypeId");
	var $relateGoodsSelect = $('#relateGoodsSelect');
	var $goodsTypeLoadingIcon = $("#goodsTypeLoadingIcon");
	var $goodsAttributeTable = $("#goodsAttributeTable");
	var $goodsParameterTable = $("#goodsParameterTable");

	// Tab效果
	$tab.tabs(".tabContent", {
		tabs: "input"
	});
	
	// 增加商品图片
	var goodsImageIndex = ${(goods.goodsImageList?size)!0};
	$addGoodsImageButton.click( function() {
		
		<@compress single_line = true>
			var goodsImageTrHtml = 
			'<tr class="goodsImageTr">
				<td>
					<input type="file" name="goodsImageFileList[' + goodsImageIndex + ']" class="goodsImageFileList" />
				</td>
				<td>
					<input type="text" name="goodsImageList[' + goodsImageIndex + '].description" class="formText" />
				</td>
				<td>
					<input type="text" name="goodsImageList[' + goodsImageIndex + '].orderList" class="formText goodsImageOrderList" style="width: 50px;" />
				</td>
				<td>
					<span class="deleteIcon deleteGoodsImage" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
				</td>
			</tr>';
		</@compress>
		
		$goodsImageTable.append(goodsImageTrHtml);
		goodsImageIndex ++;
	});
	
	// 删除商品图片
	$("#goodsImageTable .deleteGoodsImage").live("click", function() {
		var $this = $(this);
		$.dialog({type: "warn", content: "<@s.text name="item.delete.tipmessage"/>", ok: "<@s.text name="goods.common.ok"/>", cancel: "<@s.text name="goods.common.cancel"/>", modal: true, okCallback: deleteGoodsImage});
		function deleteGoodsImage() {
			$this.parent().parent().remove();
		}
	});
	
	// 增加帮助文件
	var goodsHelpIndex = ${(goods.goodsHelpList?size)!0};
	$addGoodsHelpButton.click( function() {
		
		<@compress single_line = true>
			var goodsHelpTrHtml = 
			'<tr class="goodsImageTr">
				<td>
					<input type="file" name="goodsHelpFileList[' + goodsHelpIndex + ']" class="goodsHelpFileList" onchange="uploadFileChange(this, ' + goodsHelpIndex + ')"/>
					<input type="hidden" name="goodsHelpList[' + goodsHelpIndex + '].fileSuffix" id="helpFile_' + goodsHelpIndex + '"/>
				</td>
				<td>
					<input type="text" name="goodsHelpList[' + goodsHelpIndex + '].name" class="formText" />
				</td>
				<td>
					<input type="file" name="goodsHelpFileThumbnailList[' + goodsHelpIndex + ']" class="goodsHelpFileList"/>
				</td>
				<td>
					<input type="text" name="goodsHelpList[' + goodsHelpIndex + '].orderList" class="formText goodsImageOrderList" style="width: 50px;" />
				</td>
				<td>
					<span class="deleteIcon deleteGoodsHelp" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
				</td>
			</tr>';
		</@compress>
		
		$goodsHelpTable.append(goodsHelpTrHtml);
		goodsHelpIndex ++;
	});
	
	// 删除帮助文件
	$("#goodsHelpTable .deleteGoodsHelp").live("click", function() {
		var $this = $(this);
		$.dialog({type: "warn", content: "<@s.text name="goods.notify.javascript.deleteNotice"/>?", ok: "<@s.text name="goods.common.ok"/>", cancel: "<@s.text name="goods.common.cancel"/>", modal: true, okCallback: deleteGoodsHelp});
		function deleteGoodsHelp() {
			$this.parent().parent().remove();
		}
	});
	
	var relateGoodsIndex = ${(goods.relateGoodsList?size)!0};
	$relateGoodsSelect.bind('change', function() {
	  	var name = $relateGoodsSelect.find('option:selected').text();
	  	var id = $relateGoodsSelect.val();
	  	var html = '<tr class="goodsParameterTr">' + 
						'<th>' + name + '</th>' + 
						'<td>' + 
							'<input type="hidden" name="relateGoodsList[' + relateGoodsIndex + ']" value="' + id + '" />' + 
							name + 
						'</td>' + 
					'</tr>';
	  	$('#relateGoodsTable').append(html);
	  	
	  	relateGoodsIndex++;
	});
	
	
	// 切换商品规格
	$specificationTab.click( function() {
		if (!$isSpecificationEnabled.attr("checked")) {
			$.dialog({type: "warn", content: "<@s.text name="goods.input.goods.specific"/>?", ok: "<@s.text name="goods.common.ok"/>", cancel: "<@s.text name="<@s.text name="goods.common.cancel"/>"/>", modal: true, okCallback: specificationEnabled});
			function specificationEnabled() {
				$isSpecificationEnabled.attr("checked", true);
				$specificationDisabledInfo.hide().find(":input").attr("disabled", true);
				$specificationTable.find(":checkbox, :button").not($isSpecificationEnabled).attr("disabled", false);
				$productTable.find(":input").attr("disabled", false);
			}
		}
	});
	
	// 开启/关闭商品规格
	$isSpecificationEnabled.click( function() {
		if ($isSpecificationEnabled.attr("checked")) {
			$specificationDisabledInfo.hide().find(":input").attr("disabled", true)
			$specificationTable.find(":checkbox, :button").not($isSpecificationEnabled).attr("disabled", false);
			$productTable.find(":input").attr("disabled", false);
		} else {
			$specificationDisabledInfo.show().find(":input").attr("disabled", false);
			$specificationTable.find(":checkbox, :button").not($isSpecificationEnabled).attr("disabled", true);
			$productTable.find(":input").attr("disabled", true);
		}
	});
	
	// 修改商品规格
	var specificationDatas = {};
	var specificationCheckedDatas = {};
	<#list (goods.specificationSet)! as specification>
		specificationCheckedDatas['${specification.id}'] = ${specification.json};
	</#list>
	$specificationIds.click( function() {
		$this = $(this);
		var id = $this.val();
		var specificationData = specificationDatas[id];
		if(typeof(specificationData) == "undefined") {
			$.ajax({
				url: "goods!ajaxSpecification.action",
				data: {id: id},
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				beforeSend: function() {
					$specificationValueLoadingIcon.show();
				},
				success: function(data) {
					specificationDatas[id] = data;
					specificationData = data;
				},
				complete: function() {
					$specificationValueLoadingIcon.hide();
				}
			});
		}

		if ($this.attr("checked") == true) {
			$specificationInsertTh.before('<th class="' + specificationData.id + '">' + specificationData.name + '</th>');
			
			var specificationValueOptionHtml = "";
			$.each(specificationData.specificationValueList, function(i, specificationValue) {
				specificationValueOptionHtml += ('<option value="' + specificationValue.id + '">' + specificationValue.name + '</option>');
			});
			
			$productTitle.nextAll("tr").each(function() {
				var productIndex = $(this).attr("productIndex");
				var specificationValueTdHtml = '<td class="' + specificationData.id + '"><select name="specificationValueIdsList[' + productIndex + ']">' + specificationValueOptionHtml + '</select></td>';
				$(this).find(".specificationInsertTd").before(specificationValueTdHtml);
			});
			
			specificationCheckedDatas[id] = specificationData;
		} else {
			$("." + id).remove();
			var specificationCheckedTempDatas = {};
			$.each(specificationCheckedDatas, function(i, specificationCheckedData) {
				if (specificationCheckedDatas[id].id != specificationCheckedData.id) {
					specificationCheckedTempDatas[i] = specificationCheckedData;
				}
			});
			specificationCheckedDatas = specificationCheckedTempDatas;
		}
	});
	
	// 增加货品
	var productIndex = ${(goods.productSet?size)!0};
	$addProductButton.click( function() {
		
		<@compress single_line = true>
			var productTrHtml = '<tr class="productTr" productIndex="' + productIndex + '">
				<td>
					<input type="text" id="productListProductSn' + productIndex + '" name="productList[' + productIndex + '].productSn" class="formText productListProductSn" style="width: 50px;" title="<@s.text name="goods.input.goods.blank.default"/>" />
				</td>';
		</@compress>
		
		$.each(specificationCheckedDatas, function(i, specificationCheckedData) {
			if (typeof(specificationCheckedData) != "undefined") {
				var specificationValueTdHtml = '<td class="' + specificationCheckedData.id + '"><select name="specificationValueIdsList[' + productIndex + ']">';
				$.each(specificationCheckedData.specificationValueList, function(j, specificationValue) {
					specificationValueTdHtml += ('<option value="' + specificationValue.id + '">' + specificationValue.name + '</option>');
				});
				specificationValueTdHtml += '</select></td>';
				productTrHtml += specificationValueTdHtml;
			}
		});
		
		<@compress single_line = true>
			productTrHtml += 
			'<td class="specificationInsertTd">
					<input type="text" name="productList[' + productIndex + '].price" class="formText productListPrice" value="0" style="width: 50px;" />
				</td>
				<td>
					<input type="text" name="productList[' + productIndex + '].cost" class="formText productListCost" style="width: 50px;" title="<@s.text name="goods.input.goods.show.message"/>" />
				</td>
				<td>
					<input type="text" name="productList[' + productIndex + '].marketPrice" class="formText productListMarketPrice" style="width: 50px;" />
				</td>
				<td>
					<input type="text" name="productList[' + productIndex + '].weight" class="formText productListWeight" style="width: 50px;" />
				</td>
				<td>
					<input type="text" name="productList[' + productIndex + '].store" class="formText productListStore" style="width: 50px;" />
				</td>
				<td>
					<input type="text" name="productList[' + productIndex + '].storePlace" class="formText" style="width: 50px;" />
				</td>
				<td>
					<@checkbox name="productList[' + productIndex + '].isDefault" cssClass="productListIsDefault" value="false" />
				</td>
				<td>
					<@checkbox name="productList[' + productIndex + '].isMarketable" cssClass="productListIsMarketable" value="true" />
				</td>
				<td>
					<span class="deleteIcon deleteProduct" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
				</td>
			</tr>';
		</@compress>
		
		$productTable.append(productTrHtml);
		
		if ($("#productTable input.productListIsDefault:checked").length == 0) {
			$("#productTable input.productListIsDefault:first").attr("checked", true);
		}
		
		var $productListProductSn = $("#productListProductSn" + productIndex);
		$productListProductSn.rules("add", {
			remote: {
				url: "goods!checkProductSn.action",
				type: "post",
				cache: false,
				dataType: "json",
				data: {
					"defaultProduct.productSn": function () {
						return $productListProductSn.val();
					}
				}
			},
			messages: {
				remote: "<@s.text name="goods.input.goods.product.exist"/>"
			}
		});
		productIndex ++;
	});
	
	// 删除货品
	$("#productTable .deleteProduct").live("click", function() {
		var $this = $(this);
		$.dialog({type: "warn", content: "<@s.text name="goods.notify.javascript.deleteNotice"/>?", ok: "<@s.text name="goods.common.ok"/>", cancel: "<@s.text name="goods.common.cancel"/>", modal: true, okCallback: deleteProduct});
		function deleteProduct() {
			$this.parent().parent().remove();
		}
	});
	
	// 修改货品默认
	$("#productTable input.productListIsDefault").live("click", function() {
		var $this = $(this);
		if (!$this.parent().next().find("input.productListIsMarketable").attr("checked")) {
			$.dialog({type: "warn", content: "<@s.text name="goods.input.goods.product.default"/>!", modal: true, autoCloseTime: 3000});
			return false;
		}
		$("#productTable input.productListIsDefault").not($this).attr("checked", false);
	});
	
	// 商品上架
	$goodsIsMarketable.click( function() {
		if ($isSpecificationEnabled.attr("checked") && $("#goodsForm input.productListIsMarketable:checked").size() == 0) {
			$.dialog({type: "warn", content: "<@s.text name="goods.input.goods.product.cancel"/>!", modal: true, autoCloseTime: 3000});
			return false;
		}
	});
	
	// 货品全部下架
	$("#goodsForm input.productListIsMarketable").live("click", function() {
		var $this = $(this);
		if ($this.parent().prev().find("input.productListIsDefault").attr("checked")) {
			$.dialog({type: "warn", content: "<@s.text name="goods.input.goods.product.default.un"/>!", modal: true, autoCloseTime: 3000});
			return false;
		}
		if ($isSpecificationEnabled.attr("checked") && $("#goodsForm input.productListIsMarketable:checked").size() == 0) {
			$.dialog({type: "warn", content: "<@s.text name="goods.input.goods.product.goods.default"/>!", modal: true, autoCloseTime: 3000});
			$goodsIsMarketable.attr("checked", false);
		}
	});
	
	// 修改商品类型
	var previousGoodsTypeId = "${(goods.goodsType.id)!}";
	$goodsTypeId.change( function() {
		if (previousGoodsTypeId != "") {
			$.dialog({type: "warn", content: "<@s.text name="goods.input.goods.product.typeEdit"/>!", width: 450, ok: "<@s.text name="button.name.confirm"/>", cancel: "<@s.text name="button.name.cancel"/>", modal: true, okCallback: goodsTypeChange, cancelCallback: goodsTypeReset});
		} else {
			goodsTypeChange();
		}
		
		function goodsTypeChange() {
			previousGoodsTypeId = $goodsTypeId.val();
			
			if ($goodsTypeId.val() == "") {
				$goodsAttributeTable.hide();
				$goodsParameterTable.hide();
				return;
			}
			
			$.ajax({
				url: "goods!ajaxGoodsAttribute.action",
				data: {id: $goodsTypeId.val()},
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				beforeSend: function() {
					$goodsTypeLoadingIcon.show();
					$("#goodsAttributeTable .goodsAttributeTr").remove();
				},
				success: function(data) {
					if (data != null) {
						var goodsAttributeTrHtml = "";
						$.each(data, function(i) {
							if (data[i].attributeType == "filter") {
								var optionHtml = '<option value=""><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>';
								$.each(data[i].optionList, function(j) {
									<@compress single_line = true>
										optionHtml += 
										'<option value="' + data[i].optionList[j] + '">'
											 + data[i].optionList[j] + 
										'</option>';
									</@compress>
								});
								<@compress single_line = true>
									goodsAttributeTrHtml += 
									'<tr class="goodsAttributeTr">
										<th>' + data[i].name + ': </th>
										<td>
											<select name="goodsAttributeValueMap[\'' + data[i].id + '\']">
												' + optionHtml + '
											</select>
										</td>
									</tr>';
								</@compress>
							} else {
								<@compress single_line = true>
									goodsAttributeTrHtml += 
									'<tr class="goodsAttributeTr">
										<th>' + data[i].name + ': </th>
										<td>
											<input type="text" name="goodsAttributeValueMap[\'' + data[i].id + '\']" class="formText" />
										</td>
									</tr>';
								</@compress>
							}
						});
						$goodsAttributeTable.append(goodsAttributeTrHtml);
						$goodsAttributeTable.show();
					} else {
						$goodsAttributeTable.hide();
					}
				},
				complete: function() {
					$goodsTypeLoadingIcon.hide();
				}
			});
			
			$.ajax({
				url: "goods!ajaxGoodsParameter.action",
				data: {id: $goodsTypeId.val()},
				type: "POST",
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$goodsTypeLoadingIcon.show();
					$("#goodsParameterTable .goodsParameterTr").remove();
				},
				success: function(data) {
					if (data != null) {
						var goodsParameterTrHtml = "";
						$.each(data, function(i) {
							<@compress single_line = true>
								goodsParameterTrHtml += 
								'<tr class="goodsParameterTr">
									<th>' + data[i].name + ': </th>
									<td>
										<input type="text" name="goodsParameterValueMap[\'' + data[i].id + '\']" class="formText" />
									</td>
								</tr>';
							</@compress>
						});
						$goodsParameterTable.append(goodsParameterTrHtml);
						$goodsParameterTable.show();
					} else {
						$goodsParameterTable.hide();
					}
				},
				complete: function() {
					$goodsTypeLoadingIcon.hide();
				}
			});
		}
		
		function goodsTypeReset() {
			$goodsTypeId.val(previousGoodsTypeId);
		}
	});
	
	// 表单验证
	$goodsForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"goods.goodsCategory.id": "required",
			"goods.name": "required",
			"goods.goodsSn": {
				remote: "goods!checkGoodsSn.action<#if (goods.goodsSn)??>?oldValue=${goods.goodsSn?url}</#if>"
			},
			"defaultProduct.productSn": {
				remote: "goods!checkProductSn.action<#if (defaultProduct.productSn)??>?oldValue=${defaultProduct.productSn?url}</#if>"
			},
			"goods.score": {
				required: true,
				digits: true
			},
			"defaultProduct.price": {
				priceRequired: true,
				priceMin: 0
			},
			"defaultProduct.cost": {
				costMin: 0
			},
			"defaultProduct.marketPrice": {
				marketPriceMin: 0
			},
			"defaultProduct.weight": "weightDigits",
			"defaultProduct.store": "storeDigits"
		},
		messages: {
			"goods.goodsCategory.id": "<@s.text name="goods.input.goods.product.category.choose"/>",
			"goods.name": "<@s.text name="goods.input.goods.product.name"/>",
			"goods.goodsSn": "<@s.text name="goods.input.goods.product.name.exist"/>",
			"defaultProduct.productSn": "<@s.text name="goods.input.goods.product.exist"/>",
			"goods.score": {
				required: "<@s.text name="goods.profile.input.score"/>",
				digits: "<@s.text name="goods.profile.input.score.invalid"/>"
			}
		},
		submitHandler: function(form) {
			if ($isSpecificationEnabled.attr("checked") == true) {
				if ($("#specificationSelect input:checked").size() == 0) {
					$.dialog({type: "warn", content: "<@s.text name="goods.input.goods.product.specific.choose"/>!", modal: true, autoCloseTime: 3000});
					return false;
				}
				if ($("#productTable .productTr").size() == 0) {
					$.dialog({type: "warn", content: "<@s.text name="goods.input.goods.product.add.choose"/>!", modal: true, autoCloseTime: 3000});
					return false;
				}
				if ($("#productTable input.productListIsDefault:checked").length == 0) {
					$.dialog({type: "warn", content: "<@s.text name="goods.input.goods.product.default.choose"/>!", modal: true, autoCloseTime: 3000});
					return false;
				}
				
				var isProductSnRepeat = false;
				var productSnArray = new Array();
				$("#productTable input.productListProductSn").each(function(i) {
					var $this = $(this);
					if ($.inArray($this.val(), productSnArray) >= 0) {
						isProductSnRepeat = true;
						return false;
					}
					if ($this.val() != "") {
						productSnArray.push($this.val());
					}
				});
				if (isProductSnRepeat) {
					$.dialog({type: "warn", content: "<@s.text name="goods.input.goods.product.sn.duplicate"/>!", modal: true, autoCloseTime: 3000});
					return false;
				}
				
				var isSpecificationValueIdsRepeat = false;
				var specificationValueIdsStringArray = new Array();
				$("#productTable tr:gt(0)").each(function(i) {
					var specificationValueIdsString = "";
					$(this).find("select").each(function(i) {
						specificationValueIdsString += $(this).val() + ",";
					});
					if ($.inArray(specificationValueIdsString, specificationValueIdsStringArray) >= 0) {
						isSpecificationValueIdsRepeat = true;
						return false;
					}
					if (specificationValueIdsString != "") {
						specificationValueIdsStringArray.push(specificationValueIdsString);
					}
				});
				if (isSpecificationValueIdsRepeat) {
					$.dialog({type: "warn", content: "<@s.text name="goods.input.goods.product.specific.duplicate"/>!", modal: true, autoCloseTime: 3000});
					return false;
				}
			}
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
	<#if (goods.isSpecificationEnabled)!>
		<#list goods.productSet as product>
			var $productListProductSn${product_index} = $("#productListProductSn${product_index}");
			$productListProductSn${product_index}.rules("add", {
				remote: {
					url: "goods!checkProductSn.action?oldValue=${product.productSn?url}",
					type: "post",
					cache: false,
					dataType: "json",
					data: {
						"defaultProduct.productSn": function () {
							return $productListProductSn${product_index}.val();
						}
					}
				},
				messages: {
					remote: "<@s.text name="goods.input.goods.product.exist"/>"
				}
			});
		</#list>
	</#if>
	
	// 表单验证
	$.validator.addMethod("goodsImageFileListRequired", $.validator.methods.required, "<@s.text name="goods.input.goods.product.image.upload"/>");
	$.validator.addMethod("goodsImageFileListImageFile", $.validator.methods.imageFile, "<@s.text name="goods.input.goods.product.image.upload.formatError"/>");
	$.validator.addMethod("goodsImageOrderListDigits", $.validator.methods.digits, "<@s.text name="goods.input.goods.product.image.sort.require"/>");
	$.validator.addMethod("priceRequired", $.validator.methods.required, "<@s.text name="goods.input.goods.product.image.sell.price"/>");
	$.validator.addMethod("priceMin", $.validator.methods.min, "<@s.text name="goods.input.goods.product.image.sell.require"/>");
	$.validator.addMethod("costMin", $.validator.methods.min, "<@s.text name="goods.input.goods.product.image.cost.require"/>");
	$.validator.addMethod("marketPriceMin", $.validator.methods.min, "<@s.text name="goods.input.goods.product.image.market.require"/>");
	$.validator.addMethod("weightDigits", $.validator.methods.digits, "<@s.text name="goods.input.goods.product.image.weight.require"/>");
	$.validator.addMethod("storeDigits", $.validator.methods.digits, "<@s.text name="goods.input.goods.product.image.storage.require"/>");
	
	$.validator.addClassRules("goodsImageFileList", {
		goodsImageFileListRequired: true,
		goodsImageFileListImageFile: true
	});
	$.validator.addClassRules("goodsImageOrderList", {
		goodsImageOrderListDigits: true
	});
	$.validator.addClassRules("productListPrice", {
		priceRequired: true,
		priceMin: 0
	});
	$.validator.addClassRules("productListCost", {
		costMin: 0
	});
	$.validator.addClassRules("productListMarketPrice", {
		marketPriceMin: 0
	});
	$.validator.addClassRules("productListWeight", {
		weightDigits: true
	});
	$.validator.addClassRules("productListStore", {
		storeDigits: true
	});
	
})
</script>
<#if (goods.isSpecificationEnabled)!>
	<style type="text/css">
		.specificationDisabledInfo {
			display: none;
		}
	</style>
</#if>
</head>
<body class="input goods">
	<div class="bar">
		<#if isAddAction><@s.text name="goods.input.goods.add"/><#else><@s.text name="goods.input.goods.edit"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="goodsForm" action="<#if isAddAction>goods!save.action<#else>goods!update.action</#if>" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${id}" />
			<#if (!goods.isSpecificationEnabled)!>
				<input type="hidden" name="defaultProduct.id" value="${(defaultProduct.id)!}" />
			</#if>
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="<@s.text name="goods.compare.head1"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="goods.input.goods.description"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="goods.compare.result.pic"/>" hidefocus />
				</li>
				<li>
					<input type="button" id="specificationTab" value="<@s.text name="goods.input.goods.specific"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="goods.input.goods.attribute"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="goods.content.bottom.options.relate"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="goods.content.bottom.options.help"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="goods.input.goods.cartype"/>" hidefocus />
				</li>
			</ul>
			<table id="infoTable" class="inputTable tabContent">
				<tr>
					<th>
						<@s.text name="goods.picture.list.category"/>: 
					</th>
					<td>
						<select name="goods.goodsCategory.id">
							<option value=""><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
							<#list goodsCategoryTreeList as goodsCategoryTree>
								<option value="${goodsCategoryTree.id}"<#if (goodsCategoryTree == goods.goodsCategory)!> selected</#if>>
									<#if goodsCategoryTree.grade != 0>
										<#list 1..goodsCategoryTree.grade as i>
											&nbsp;&nbsp;
										</#list>
									</#if>
									${goodsCategoryTree.name}
								</option>
							</#list>
						</select>
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.notify.memberCenter.goods.name"/>: 
					</th>
					<td>
						<input type="text" name="goods.name" class="formText" value="${(goods.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.compare.result.sn"/>: 
					</th>
					<td>
						<input type="text" name="goods.goodsSn" class="formText" value="${(goods.goodsSn)!}" title="<@s.text name="goods.input.goods.sn.default"/>" />
					</td>
				</tr>
				<tr class="specificationDisabledInfo">
					<th>
						<@s.text name="deliveryItem.productSn"/>: 
					</th>
					<td>
						<#if (!goods.isSpecificationEnabled)!>
							<input type="text" name="defaultProduct.productSn" class="formText" value="${(defaultProduct.productSn)!}" title="<@s.text name="goods.input.goods.sn.default"/>" />
						<#else>
							<input type="text" name="defaultProduct.productSn" class="formText" title="<@s.text name="goods.input.goods.sn.default"/>" />
						</#if>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.input.goods.brand"/>: 
					</th>
					<td>
						<select name="brandId">
							<option value=""><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
							<#list allBrandList as brand>
								<option value="${brand.id}"<#if (brand == goods.brand)!> selected</#if>>
									${brand.name}
								</option>
							</#list>
						</select>
					</td>
				</tr>
				<#if setting.scoreType == "goodsSet">
					<tr>
						<th>
							<@s.text name="goods.common.score"/>: 
						</th>
						<td>
							<input type="text" name="goods.score" class="formText" value="${(goods.score)!"0"}" />
						</td>
					</tr>
				</#if>
				<tr class="specificationDisabledInfo">
					<th>
						<@s.text name="goods.compare.result.price"/>: 
					</th>
					<td>
						<input type="text" name="defaultProduct.price" class="formText" value="${(defaultProduct.price)!"0"}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr class="specificationDisabledInfo">
					<th>
						<@s.text name="goods.input.goods.cost"/>: 
					</th>
					<td>
						<input type="text" name="defaultProduct.cost" class="formText" value="${(defaultProduct.cost)!}" title="<@s.text name="goods.input.goods.show.message"/>" />
					</td>
				</tr>
				<tr class="specificationDisabledInfo">
					<th>
						<@s.text name="goods.compare.result.marketPrice"/>: 
					</th>
					<td>
						<input type="text" name="defaultProduct.marketPrice" class="formText" value="${(defaultProduct.marketPrice)!}" title="<@s.text name="goods.input.goods.market.default"/>" />
					</td>
				</tr>
				<tr class="specificationDisabledInfo">
					<th>
						<@s.text name="goods.input.goods.weight"/>: 
					</th>
					<td>
						<input type="text" name="defaultProduct.weight" class="formText" value="${(defaultProduct.weight)!}" title="<@s.text name="delivery.type.input.unit"/>: <@s.text name="goods.common.unit.gram"/>" />
					</td>
				</tr>
				<tr class="specificationDisabledInfo">
					<th>
						<@s.text name="goods.input.goods.storage"/>: 
					</th>
					<td>
						<input type="text" name="defaultProduct.store" class="formText" value="${(goods.store)!}" title="<@s.text name="goods.input.goods.storage.default"/>" />
					</td>
				</tr>
				<tr class="specificationDisabledInfo">
					<th>
						<@s.text name="goods.input.goods.unit"/>: 
					</th>
					<td>
						<input type="text" name="goods.storePlace" class="formText" value="${(goods.storePlace)!}" title="<@s.text name="goods.input.goods.unit.default"/>" />				 						
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.common.setting"/>: 
					</th>
					<td>
						<label>
							<@checkbox id="goodsIsMarketable" name="goods.isMarketable" value="${(goods.isMarketable)!true}" /><@s.text name="goods.input.goods.marketable"/>
						</label>
						<label>
							<@checkbox name="goods.isBest" value="${(goods.isBest)!false}" /><@s.text name="goods.input.goods.best"/>
						</label>
						<label>
							<@checkbox name="goods.isNew" value="${(goods.isNew)!false}" /><@s.text name="goods.input.goods.new"/>
						</label>
						<label>
							<@checkbox name="goods.isHot" value="${(goods.isHot)!false}" /><@s.text name="goods.input.goods.hot"/>
						</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.category.article.pageKey"/>: 
					</th>
					<td>
						<input type="text" name="goods.metaKeywords" class="formText" value="${(goods.metaKeywords)!}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="admin.category.article.pageDescription"/>: 
					</th>
					<td>
						<textarea name="goods.metaDescription" class="formTextarea">${(goods.metaDescription)!}</textarea>
					</td>
				</tr>
			</table>
			<table class="inputTable tabContent">
				<tr>
					<td>
						<textarea id="editor" name="goods.introduction" class="editor" style="width: 100%;">${(goods.introduction)!}</textarea>
					</td>
				</tr>
			</table>
			<table id="goodsImageTable" class="inputTable tabContent">
				<tr class="noneHover">
					<td colspan="5">
						<input type="button" id="addGoodsImageButton" class="formButton" value="<@s.text name="goods.input.goods.image.add"/>" hidefocus />
					</td>
				</tr>
				<tr class="title">
					<th>
						<@s.text name="goods.input.goods.image.upload"/>
					</th>
					<th>
						<@s.text name="goods.input.goods.image.description"/>
					</th>
					<th>
						<@s.text name="goods.specification.list.search.result.header.order"/>
					</th>
					<th>
						<@s.text name="common.button.delete"/>
					</th>
				</tr>
				<#list (goods.goodsImageList)! as goodsImage>
					<tr class="goodsImageTr">
						<td>
							<input type="hidden" name="goodsImageList[${goodsImage_index}].id" value="${goodsImage.id}" />
							<input type="hidden" name="goodsImageList[${goodsImage_index}].path" value="${goodsImage.path}" />
							<input type="hidden" name="goodsImageList[${goodsImage_index}].sourceImageFormatName" value="${goodsImage.sourceImageFormatName}" />
							<a href="${base}${goodsImage.thumbnailImagePath}" title="<@s.text name="goods.common.clickshow"/>" target="_blank">
								<img src="${base}${goodsImage.thumbnailImagePath}" style="width: 50px; height: 50px;" />
							</a>
						</td>
						<td>
							<input type="text" name="goodsImageList[${goodsImage_index}].description" class="formText" value="${goodsImage.description}" />
						</td>
						<td>
							<input type="text" name="goodsImageList[${goodsImage_index}].orderList" class="formText goodsImageOrderList" value="${goodsImage.orderList}" style="width: 50px;" />
						</td>
						<td>
							<span class="deleteIcon deleteGoodsImage" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
						</td>
					</tr>
				</#list>
			</table>
			<div class="tabContent">
				<table id="specificationTable" class="inputTable">
					<tr class="noneHover">
						<td colspan="9">
							<label class="red">
								<@checkbox id="isSpecificationEnabled" name="goods.isSpecificationEnabled" value="${(goods.isSpecificationEnabled)!false}" /><@s.text name="goods.input.goods.specific.start"/>
							</label>
						</td>
					</tr>
					<tr class="title">
						<th colspan="9">
							<@s.text name="goods.input.goods.specific.choose"/><span id="specificationValueLoadingIcon" class="loadingIcon hidden">&nbsp;</span>
						</th>
					</tr>
					<tr class="noneHover">
						<td colspan="9">
							<div id="specificationSelect" class="specificationSelect">
								<ul>
									<#assign specificationSet = (goods.specificationSet)! />
									<#list allSpecificationList as specification>
										<li>
											<label title="<@s.text name="goods.input.goods.specific.value"/>: <#list specification.specificationValueList as specificationValue>${specificationValue.name}&nbsp;</#list>">
												<input type="checkbox" name="specificationIds" value="${specification.id}"<#if (specificationSet.contains(specification))!> checked</#if><#if (!goods.isSpecificationEnabled)!true> disabled</#if> />${specification.name}
												<#if specification.memo??>
													<span class="gray">[${specification.memo}]</span>
												</#if>
											</label>
										</li>
									</#list>
								</ul>
							</div>
						</td>
					</tr>
					<tr class="noneHover">
						<td colspan="9">
							<input type="button" id="addProductButton" class="formButton" value="<@s.text name="goods.input.goods.product.add"/>"<#if (!goods.isSpecificationEnabled)!true> disabled</#if> hidefocus />
						</td>
					</tr>
				</table>
				<table id="productTable" class="inputTable">
					<tr id="productTitle" class="title">
						<th>
							<@s.text name="deliveryItem.productSn"/>
						</th>
						<#list (goods.specificationSet)! as specification>
							<th class="${specification.id}">
								${specification.name}
							</th>
						</#list>
						<th id="specificationInsertTh">
							<@s.text name="goods.compare.result.price"/>
						</th>
						<th>
							<@s.text name="goods.input.goods.cost"/>
						</th>
						<th>
							<@s.text name="goods.compare.result.marketPrice"/>
						</th>
						<th>
							<@s.text name="goods.input.goods.weight"/>
						</th>
						<th>
							<@s.text name="goods.input.goods.storage"/>
						</th>
						<th>
							<@s.text name="goods.input.goods.unit"/>
						</th>
						<th>
							<@s.text name="goods.common.default"/>
						</th>
						<th>
							<@s.text name="goods.input.goods.marketable"/>
						</th>
						<th>
							<@s.text name="common.button.delete"/>
						</th>
					</tr>
					<#if (goods.isSpecificationEnabled)!>
						<#list (goods.productSet)! as product>
							<tr class="productTr" productIndex="${product_index}">
								<td>
									<input type="hidden" name="productList[${product_index}].id" class="formText" value="${product.id}" />
									<input type="text" id="productListProductSn${product_index}" name="productList[${product_index}].productSn" class="formText productListProductSn" value="${product.productSn}" style="width: 50px;" title="<@s.text name="goods.input.goods.blank.default"/>" />
								</td>
								<#list (goods.specificationSet)! as specification>
									<td class="${specification.id}">
										<select name="specificationValueIdsList[${product_index}]">
											<#list specification.specificationValueList as specificationValue>
												<option value="${specificationValue.id}"<#if product.specificationValueList.contains(specificationValue)> selected</#if>>
													${specificationValue.name}
												</option>
											</#list>
										</select>
									</td>
								</#list>
								<td class="specificationInsertTd">
									<input type="text" name="productList[${product_index}].price" class="formText productListPrice" value="${product.price}" style="width: 50px;" />
								</td>
								<td>
									<input type="text" name="productList[${product_index}].cost" class="formText productListCost" value="${product.cost}" style="width: 50px;" title="<@s.text name="goods.input.goods.show.message"/>" />
								</td>
								<td>
									<input type="text" name="productList[${product_index}].marketPrice" class="formText productListMarketPrice" value="${product.marketPrice}" style="width: 50px;" title="<@s.text name="goods.input.goods.market.default"/>" />
								</td>
								<td>
									<input type="text" name="productList[${product_index}].weight" class="formText productListWeight" value="${product.weight}" style="width: 50px;" title="<@s.text name="delivery.type.input.unit"/>: <@s.text name="goods.common.unit.gram"/>" />
								</td>
								<td>
									<input type="text" name="productList[${product_index}].store" class="formText productListStore" value="${product.store}" style="width: 50px;" />
								</td>
								<td>
									<input type="text" name="productList[${product_index}].storePlace" class="formText" value="${product.storePlace}" style="width: 50px;" />
								</td>
								<td>
									<@checkbox name="productList[${product_index}].isDefault" cssClass="productListIsDefault" value="${(product.isDefault)!false}" />
								</td>
								<td>
									<@checkbox name="productList[${product_index}].isMarketable" cssClass="productListIsMarketable" value="${(product.isMarketable)!true}" />
								</td>
								<td>
									<#assign hasUnfinishedOrder = false />
									<#assign orderItemSet = product.orderItemSet />
									<#if (orderItemSet?? && orderItemSet?size > 0)>
										<#list orderItemSet as orderItem>
											<#if orderItem.orderStatus != "completed" && orderItem.orderStatus != "invalid">
												<#assign hasUnfinishedOrder = true />
												<#break />
											</#if>
										</#list>
									</#if>
									<#if hasUnfinishedOrder>
										<span class="deleteIcon" title="<@s.text name="goods.input.goods.delete.existError"/>" disabled>&nbsp;</span>
									<#else>
										<span class="deleteIcon deleteProduct" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
									</#if>
								</td>
							</tr>
						</#list>
					</#if>
				</table>
			</div>
			<div class="tabContent">
				<div class="tableItem">
					<table class="inputTable">
						<tr class="title">
							<th>
								<@s.text name="goods.input.goods.type.choose"/>: 
							</th>
							<td>
								<select id="goodsTypeId" name="goodsTypeId">
									<option value=""><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
									<#list allGoodsTypeList as goodsType>
										<option value="${goodsType.id}"<#if (goodsType == goods.goodsType)!> selected</#if>>${goodsType.name}</option>
									</#list>
								</select>
								<span id="goodsTypeLoadingIcon" class="loadingIcon hidden">&nbsp;</span>
							</td>
						</tr>
					</table>
					<div class="blank"></div>
					<table id="goodsAttributeTable" class="inputTable<#if (isAddAction || goods.goodsType == null)!> hidden</#if>">
						<tr class="title">
							<th>
								<@s.text name="goods.input.goods.properties"/>
							</th>
							<td>
								&nbsp;
							</td>
						</tr>
						<#list (goods.goodsType.goodsAttributeSet)! as goodsAttribute>
							<tr class="goodsAttributeTr">
								<th>${goodsAttribute.name}: </th>
								<td>
									<#if goodsAttribute.attributeType == "filter">
										<select name="goodsAttributeValueMap['${goodsAttribute.id}']">
											<option value=""><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
											<#list goodsAttribute.optionList as option>
												<option value="${option}"<#if option == goods.getGoodsAttributeValue(goodsAttribute)> selected</#if>>
													${option}
												</option>
											</#list>
										</select>
									<#else>
										<input type="text" name="goodsAttributeValueMap['${goodsAttribute.id}']" class="formText" value="${(goods.getGoodsAttributeValue(goodsAttribute))!}" />
									</#if>
								</td>
							</tr>
						</#list>
					</table>
					<div class="blank"></div>
					<table id="goodsParameterTable" class="inputTable<#if (isAddAction || goods.goodsType == null)!true> hidden</#if>">
						<tr class="title">
							<th>
								<@s.text name="goods.content.bottom.options.attribute"/>
							</th>
							<td>
								&nbsp;
							</td>
						</tr>
						<#assign goodsParameterValueMap = (goods.goodsParameterValueMap)! />
						<#list (goods.goodsType.goodsParameterList)! as goodsParameter>
							<tr class="goodsParameterTr">
								<th>${goodsParameter.name}: </th>
								<td>
									<input type="text" name="goodsParameterValueMap['${goodsParameter.id}']" class="formText" value="${(goodsParameterValueMap.get(goodsParameter.id))!}" />
								</td>
							</tr>
						</#list>
					</table>
				</div>
			</div>
			<div class="tabContent">
				<div class="tableItem">
					<table class="inputTable">
						<tr class="title">
							<th>
								<@s.text name="goods.input.goods.product.choose"/>: 
							</th>
							<td>
								<select id="relateGoodsSelect">
									<option value=""><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
									<#list allGoods as goods>
										<option value="${goods.id}">${goods.name}</option>
									</#list>
								</select>
								<!--
								<span id="goodsTypeLoadingIcon" class="loadingIcon hidden">&nbsp;</span>
								-->
							</td>
						</tr>
					</table>
					<div class="blank"></div>
					<table id="relateGoodsTable" class="inputTable<#if (isAddAction || goods.goodsType == null)!true> hidden</#if>">
						<tr class="title">
							<th>
								<@s.text name="goods.content.bottom.options.relate"/>
							</th>
							<td>
								&nbsp;
							</td>
						</tr>
						<#list disPlayRelateGoodsList as relateGoods>
							<tr class="goodsParameterTr">
								<th>${relateGoods.name}: </th>
								<td>
								
									<input type="hidden" name="relateGoodsList[${relateGoods_index}]" value="${relateGoods.id}" />
									${relateGoods.name}
								</td>
							</tr>
						</#list>
					</table>
				</div>
			</div>
			<table id="goodsHelpTable" class="inputTable tabContent">
				<tr class="noneHover">
					<td colspan="5">
						<input type="button" id="addGoodsHelpButton" class="formButton" value="<@s.text name="goods.input.goods.file.add"/>" hidefocus />
					</td>
				</tr>
				<tr class="title">
					<th>
						<@s.text name="goods.input.goods.file.path"/>
					</th>
					<th>
						<@s.text name="goods.input.goods.file.name"/>
					</th>
					<th>
						<@s.text name="goods.input.goods.file.image"/>
					</th>
					<th>
						<@s.text name="goods.specification.list.search.result.header.order"/>
					</th>
					<th>
						<@s.text name="common.button.delete"/>
					</th>
				</tr>
				<#list (goods.goodsHelpList)! as goodsHelp>
					<tr class="goodsImageTr">
						<td>
							<a href="${goodsHelp.filePath}">${goodsHelp.filePath}</a>
						</td>
						<td>
							<input type="hidden" name="goodsHelpList[${goodsHelp_index}].id" value="${goodsHelp.id}" />
							<input type="hidden" name="goodsHelpList[${goodsHelp_index}].path" value="${goodsHelp.path}" />
							<input type="text" name="goodsHelpList[${goodsHelp_index}].name" class="formText" value="${goodsHelp.name}" />
						</td>
						<td>
							<img src="${base}${goodsHelp.fileThumbnail}" style="width: 50px; height: 50px;" />
							<input type="hidden" name="goodsHelpList[' + goodsHelpIndex + '].fileThumbnail" value="${goodsHelp.fileThumbnail}"/>
						</td>
						<td>
							<input type="text" name="goodsHelpList[${goodsHelp_index}].orderList" class="formText goodsImageOrderList" value="${goodsHelp.orderList}" style="width: 50px;" />
						</td>
						<td>
							<span class="deleteIcon deleteGoodsHelp" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
						</td>
					</tr>
				</#list>
			</table>
			
			<div id="fitCarDiv" class="tabContent">
				<table class="inputTable">
					<tr>
						<th>
							<@s.text name="car.make.producer.choose"/>: 
						</th>
						<td>
							<select name="goodsFitCar.carMakeId" id="goodsFitCar_carMakeId">
								<option value="0"><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
								<#list carMakeList as carMake>
									<option value="${carMake.id}">${carMake.name}</option>
								</#list>
							</select>
							<label class="requireField">*</label>
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="goods.input.car.type"/>: 
						</th>
						<td>
							<select name="goodsFitCar.carModeId" id="goodsFitCar_carModeId">
								<option value="0"><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
							</select>
							<label class="requireField">*</label>
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="goods.input.car.specific"/>: 
						</th>
						<td>
							<select name="goodsFitCar.carStyleId" id="goodsFitCar_carStyleId">
								<option value="0"><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
							</select>
							<label class="requireField">*</label>
						</td>
					</tr>
					<tr>
						<th>
							<@s.text name="goods.input.car.generateYear"/>: 
						</th>
						<td>
							<select name="goodsFitCar.yearMade" id="goodsFitCar_yearMade">
								<option value="0"><@s.text name="goods.content.buyInfo.tipsTitle"/>...</option>
							</select>
							<label class="requireField">*</label>
						</td>
					</tr>
					<tr class="noneHover">
						<td colspan="2">
							<input type="button" id="addFitCarButton" class="formButton" value="<@s.text name="goods.input.car.add"/>" hidefocus />
						</td>
					</tr>
				</table>
				<table class="inputTable">
					<tr class="title">
						<th>
							<@s.text name="car.make.maker"/>
						</th>
						<th>
							<@s.text name="goods.input.car.theType"/>
						</th>
						<th>
							<@s.text name="goods.input.car.theSpecific"/>
						</th>
						<th>
							<@s.text name="goods.input.car.theYear"/>
						</th>
						<th>
							<@s.text name="button.name.delete"/>
						</th>
					</tr>
					<#list (goods.fitCarList)! as fitCar>
						<tr class="goodsImageTr">
							<td>
								${fitCar.carMake.name}
							</td>
							<td>
								${fitCar.carMode.name}
							</td>
							<td>
								${fitCar.carStyle.style}
							</td>
							<td>
								${fitCar.carStyle.yearMade}
							</td>
							<td>
								<span class="deleteIcon deleteGoodsHelp" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
							</td>
						</tr>
					</#list>
				</table>
			</div>
			
			<div class="buttonArea">
				<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="common.button.back" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>