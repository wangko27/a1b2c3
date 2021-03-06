<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${goods.name}</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<#if (goods.metaKeywords)! != ""><meta name="keywords" content="${goods.metaKeywords}" /></#if>
<#if (goods.metaDescription)! != ""><meta name="description" content="${goods.metaDescription}" /></#if>
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/common/css/jquery.zoomimage.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/shop.css" rel="stylesheet" type="text/css" />
<!--[if lte IE 6]>
	<script type="text/javascript" src="${base}/template/common/js/belatedPNG.js"></script>
	<script type="text/javascript">
		// 解决IE6透明PNG图片BUG
		DD_belatedPNG.fix(".belatedPNG");
	</script>
<![endif]-->
</head>
<body id="goodsContent" class="goodsContent">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body">
		<div class="bodyLeft">
			<div class="goodsCategory">
            	<div class="top">${bundle("goods.content.menu.category.title")}</div>
            	<div class="middle">
            		<ul id="goodsCategoryMenu" class="menu">
            			<@goods_category_tree; goodsCategoryTree>
	            			<#list goodsCategoryTree as firstGoodsCategory>
	            				<li class="mainCategory">
									<a href="${base}${firstGoodsCategory.url}">${firstGoodsCategory.name}</a>
								</li>
								<#if (firstGoodsCategory.children?? && firstGoodsCategory.children?size > 0)>
									<#list firstGoodsCategory.children as secondGoodsCategory>
										<li>
											<a href="${base}${secondGoodsCategory.url}">
												<span class="icon">&nbsp;</span>${secondGoodsCategory.name}
											</a>
										</li>
										<#if secondGoodsCategory_index + 1 == 5>
											<#break />
										</#if>
									</#list>
								</#if>
								<#if firstGoodsCategory_index + 1 == 3>
									<#break />
								</#if>
	            			</#list>
	            		</@goods_category_tree>
					</ul>
            	</div>
                <div class="bottom"></div>
			</div>
			<div class="blank"></div>
			<div class="hotGoods">
				<div class="top">${bundle("goods.content.menu.hotgoods.title")}</div>
				<div class="middle">
					<ul>
						<@goods_list goods_category_id=goods.goodsCategory.id type="hot" count=10; goodsList>
							<#list goodsList as goods>
								<li class="number${goods_index + 1}">
									<span class="icon">&nbsp;</span>
									<a href="${base}${goods.htmlPath}" title="${goods.name}">${substring(goods.name, 24, "...")}</a>
								</li>
							</#list>
						</@goods_list>
					</ul>
				</div>
				<div class="bottom"></div>
			</div>
			<div class="blank"></div>
			<div id="goodsHistory" class="goodsHistory">
				<div class="top">${bundle("goods.content.menu.browse.title")}</div>
				<div class="middle">
					<ul id="goodsHistoryListDetail"></ul>
				</div>
				<div class="bottom"></div>
			</div>
		</div>
		<div class="bodyRight">
			<div class="listBar">
				<div class="left"></div>
				<div class="middle">
					<div class="path">
						<a href="${base}/" class="shop"><span class="icon">&nbsp;</span>${bundle("nav.homepage")}</a> &gt;
						<#list pathList as path>
							<a href="${base}${path.url}">${path.name}</a> &gt;
						</#list>
					</div>
				</div>
				<div class="right"></div>
			</div>
			<div class="blank"></div>
			<div class="goodsTop">
				<div class="goodsTopLeft">
					<div class="goodsImage">
						<#if goods.goodsImageList??>
		                	<#list goods.goodsImageList as goodsImage>
		                		<a href="${base}${goodsImage.bigImagePath}" class="tabContent zoom<#if (goodsImage_index > 0)> nonFirst</#if>">
									<img src="${base}${goodsImage.smallImagePath}" alt="" />
								</a>
							</#list>
						<#else>
	            			<a href="${base}${setting.defaultBigGoodsImagePath}" class="zoom">
								<img src="${base}${setting.defaultSmallGoodsImagePath}" alt="" />
							</a>
	                	</#if>
                	</div>
					<div class="thumbnailGoodsImage">
						<a class="prev browse" href="javascript: void(0);" hidefocus></a>
						<div id="thumbnailGoodsImageScrollable" class="scrollable">
							<ul id="goodsImageTab" class="items goodsImageTab">
								<#if goods.goodsImageList??>
									<#list goods.goodsImageList as goodsImage>
										<li><img src="${base}${goodsImage.thumbnailImagePath}" alt="${goodsImage.description}" /></li>
									</#list>
								<#else>
									<li><img src="${base}${setting.defaultThumbnailGoodsImagePath}" /></li>
	                        	</#if>
							</ul>
						</div>
						<a class="next browse" href="javascript: void(0);" hidefocus></a>
					</div>
				</div>
				<div class="goodsTopRight">
					<h1 class="title">${substring(goods.name, 50, "...")}</h1>
					<ul class="goodsAttribute">
						<li>${bundle("goods.info.goodsSn")}: ${goods.goodsSn}</li>
						<li>${bundle("goods.info.productSn")}: <span id="productSn">${goods.defaultProduct.productSn}</span></li>
						<#list (goods.goodsType.goodsAttributeSet)! as goodsAttribute>
							<#if goods.getGoodsAttributeValue(goodsAttribute)?? && goods.getGoodsAttributeValue(goodsAttribute) != "">
	                    		<li>${goodsAttribute.name}: ${substring(goods.getGoodsAttributeValue(goodsAttribute), 26)}</li>
							</#if>
						</#list>
					</ul>
					<div class="blank"></div>
					<div class="goodsPrice">
						<div class="left"></div>
						<div class="right">
							<div class="top">
								${bundle("goods.info.price")}:
								<span id="price" class="price">${goods.price?string(currencyFormat)}</span>
							</div>
							<div class="bottom">
								${bundle("goods.info.marketPrice")}:
								<#if setting.isShowMarketPrice>
									<span id="marketPrice" class="marketPrice">${goods.marketPrice?string(currencyFormat)}</span>
								<#else>
									-
								</#if>
							</div>
						</div>
					</div>
					<div class="blank"></div>
					<table id="buyInfo" class="buyInfo">
						<#if goods.isSpecificationEnabled>
							<#assign specificationValueSet = goods.specificationValueSet>
							<tr class="specificationTips">
								<th id="tipsTitle">${bundle("goods.content.buyInfo.tipsTitle")}:</th>
								<td>
									<div id="tipsContent" class="tipsContent">
										<#list goods.specificationSet as specification>
											${specification.name} 
										</#list>
									</div>
									<div id="closeHighlight" class="closeHighlight" title="${bundle("goods.content.buyInfo.closeHighlight")}"></div>
								</td>
							</tr>
							<#list goods.specificationSet as specification>
								<#if specification.specificationType == "text">
									<tr class="text">
										<th>${specification.name}:</th>
										<td>
											<ul>
												<#list specification.specificationValueList as specificationValue>
													<#if specificationValueSet.contains(specificationValue)>
														<li class="${specificationValue.id}" title="${specificationValue.name}" specificationValueId="${specificationValue.id}">
															${specificationValue.name}
															<span title="${bundle("goods.content.buyInfo.clickCancel")}"></span>
														</li>
													</#if>
												</#list>
											</ul>
										</td>
									</tr>
								<#else>
									<tr class="image">
										<th>${specification.name}:</th>
										<td>
											<ul>
												<#list specification.specificationValueList as specificationValue>
													<#if specificationValueSet.contains(specificationValue)>
														<li class="${specificationValue.id}" title="${specificationValue.name}" specificationValueId="${specificationValue.id}">
															<#if specificationValue.imagePath??>
																<img src="${base}${specificationValue.imagePath}" alt="${specificationValue.name}" />
															<#else>
																<img src="${base}/template/shop/images/default_specification.gif" />
															</#if>
															<span title="goods.content.buyInfo.clickCancel"></span>
														</li>
													</#if>
												</#list>
											</ul>
										</td>
									</tr>
								</#if>
							</#list>
						</#if>
						<tr>
							<th>${bundle("goods.content.buyInfo.buy.number")}:</th>
							<td>
								<input type="text" id="quantity" value="1" />
								<#if setting.scoreType == "goodsSet" && goods.score != 0>
									&nbsp;&nbsp;( ${bundle("goods.content.buyInfo.goods.score")}: ${goods.score} )
								</#if>
							</td>
						</tr>
						<tr>
							<th>&nbsp;</th>
							<td>
								<#if !goods.isSpecificationEnabled && goods.isOutOfStock>
									<input type="button" id="goodsButton" class="goodsNotifyButton" value="" hidefocus />
								<#else>
									<input type="button" id="goodsButton" class="addCartItemButton" value="" hidefocus />
								</#if>
								<div id="shop_star">
                                	<ul>
                                		<#if goods.averageScore == 0>
                                		<li><img src="${base}/template/shop/images/shop_star2.gif"></li>
                                		<li><img src="${base}/template/shop/images/shop_star2.gif"></li>
                                		<li><img src="${base}/template/shop/images/shop_star2.gif"></li>
                                		<li><img src="${base}/template/shop/images/shop_star2.gif"></li>
                                		<li><img src="${base}/template/shop/images/shop_star2.gif"></li>
                                		</#if>
                                		<#if goods.averageScore != 0>
                                		<#list 1..goods.averageScore as t>
                                    	<li><img src="${base}/template/shop/images/shop_star1.gif"></li>
                                    	</#list>
                                    	<#list (goods.averageScore + 1)..5 as t>
                                        <li><img src="${base}/template/shop/images/shop_star2.gif"></li>
                                        </#list>
                                		</#if>
                                    </ul>
                                </div>
                                <div id="Collect"><input type="button" id="addFavorite" class="addFavoriteButton" goodsid="${goods.id}" hidefocus=""></div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="blank"></div>
			<input type="hidden" id="goodsId" value="${goods.id}"/>
			<input type="hidden" id="goodsCategoryId" value="${goods.goodsCategory.id}"/>
			<div id="recommendGoods"></div>
			<div class="goodsBottom">
				<ul id="goodsParameterTab" class="goodsParameterTab">
					<li>
						<a href="javascript: void(0);" class="current" hidefocus>${bundle("goods.content.bottom.options.introduce")}</a>
					</li>
					<li>
						<a href="javascript: void(0);" name="goodsAttribute" hidefocus>${bundle("goods.content.bottom.options.attribute")}</a>
					</li>
					<li>
						<a href="javascript: void(0);" name="relateGoods" hidefocus>${bundle("goods.content.bottom.options.relate")}</a>
					</li>
					<#if setting.isCommentEnabled>
						<li>
							<a href="javascript: void(0);" hidefocus>${bundle("goods.content.bottom.options.comment")}</a>
						</li>
					</#if>
					<li>
						<a href="javascript: void(0);" name="goodsHelp" hidefocus>${bundle("goods.content.bottom.options.help")}</a>
					</li>
				</ul>
				<div class="tabContent goodsIntroduction">
					${goods.introduction}
				</div>
				<div class="tabContent goodsAttribute">
					<table class="goodsParameterTable">
						<#list (goods.goodsType.goodsParameterList)! as goodsParameter>
							<#if goods.goodsParameterValueMap.get(goodsParameter.id)?? && goods.goodsParameterValueMap.get(goodsParameter.id) != "">
								<tr>
									<th>
										${goodsParameter.name}
									</th>
									<td>
										${(goods.goodsParameterValueMap.get(goodsParameter.id))!}
									</td>
								</tr>
							</#if>
						</#list>
					</table>
				</div>
				<div class="tabContent relateGoods">
					<ul class="goodsListDetail">
						<#list goods.buildRelateGoodsList as relateGoods>
						<li>
							<a href="${base}${relateGoods.htmlPath}" class="goodsImage" target="_blank">
								<img src="${base}${relateGoods.defaultThumbnailGoodsImagePath}" alt="${relateGoods.name}" />
							</a>
						</li>
						</#list>
					</ul>
				</div>
				<#if setting.isCommentEnabled>
					<div id="comment" class="tabContent comment">
						<div id="mt">
                        	<ul class="tab" id="cmtTab">
								<li id="cmtTab0"><a href="javascript:;">${bundle("goods.content.bottom.comment.all")}<em id="totalCount">(${totalCount})</em></a></li>
								<li><a href="javascript:;">${bundle("goods.content.bottom.comment.good")}<em id="goodCount">(${goodCount})</em></a></li>
                                <li><a href="javascript:;">${bundle("goods.content.bottom.comment.soso")}<em id="middleCount">(${middleCount})</em></a></li>
                                <li><a href="javascript:;">${bundle("goods.content.bottom.comment.bad")}<em id="badCount">(${badCount})</em></a></li>
                            </ul>
						</div>
						<div id="commentList">
							<div class="commentTab" id="commentList_0">
							</div>
							<div class="commentTab" id="commentList_1">
							</div>
							<div class="commentTab" id="commentList_2">
							</div>
							<div class="commentTab" id="commentList_3">
							</div>
							<div class="info">
								<a href="${base}/shop/comment_list/${goods.id}.htm">${bundle("goods.content.bottom.comment.list")}&gt;&gt;</a>
							</div>
						</div>
						<form id="commentForm" name="commentForm" method="post">
							<input type="hidden" name="comment.goods.id" value="${goods.id}" />
							<input type="hidden" id="forCommentId" name="forCommentId" />
							<table class="sendTable">
								<tr class="title">
									<td width="100">
										<span id="sendTitle">${bundle("goods.content.bottom.comment.say")}</span>
									</td>
									<td>
										<a href="javascript: void(0);" id="sendComment" class="sendComment">${bundle("goods.content.bottom.comment.switchNew")}&gt;&gt;</a>
									</td>
								</tr>
								<tr>
									<th>
										评分: 
									</th>
									<td>
										<ul class="discuss_star">
											<li><input type="radio" name="comment.score" value="5"/><span class="discuss_s"><img src="${base}/template/shop/images/discuss_s5.gif"></span></li>
											<li><input type="radio" name="comment.score" value="4"/><span class="discuss_s"><img src="${base}/template/shop/images/discuss_s4.gif"></span></li>
											<li><input type="radio" name="comment.score" value="3"/><span class="discuss_s"><img src="${base}/template/shop/images/discuss_s3.gif"></span></li>
											<li><input type="radio" name="comment.score" value="2"/><span class="discuss_s"><img src="${base}/template/shop/images/discuss_s2.gif"></span></li>
											<li><input type="radio" name="comment.score" value="1"/><span class="discuss_s"><img src="${base}/template/shop/images/discuss_s1.gif"></span></li>
										</ul>
									</td>
								</tr>
								<tr>
									<th>
										${bundle("goods.content.bottom.comment.context")}: 
									</th>
									<td>
										<textarea id="commentContent" name="comment.content" class="formTextarea"></textarea>
									</td>
								</tr>
								<tr>
									<th>
										${bundle("goods.content.bottom.comment.contact")}: 
									</th>
									<td>
										<input type="text" name="comment.contact" class="formText" />
									</td>
								</tr>
								<#if setting.isCommentCaptchaEnabled>
									<tr>
					                	<th>
					                		${bundle("goods.content.bottom.comment.sign")}: 
					                	</th>
					                    <td>
					                    	<input type="text" id="commentCaptcha" name="j_captcha" class="formText captcha" />
					                    	<img id="commentCaptchaImage" class="captchaImage" src="${base}/captcha.jpeg" alt="${bundle("goods.content.bottom.comment.replace")}" />
					                    </td>
					                </tr>
				                </#if>
								<tr>
									<th>
										&nbsp;
									</th>
									<td>
										<input type="submit" class="formButton" value="${bundle("goods.content.bottom.comment.submit")}" />
									</td>
								</tr>
							</table>
						</form>
					</div>
				</#if>
				<div class="tabContent goodsHelp">
					<ul id="video">
						<#list goods.goodsHelpList as goodsHelp>
						<#if (goodsHelp.fileThumbnail)??>
                    	<li>
                        	<a href="${base}${goodsHelp.filePath}"><img src="${base}${goodsHelp.fileThumbnail}"></a>
                            <span><a href="${base}${goodsHelp.filePath}">${goodsHelp.name}</a></span>
                        </li>
                        <#else>
                        <li>
                            <span><a href="${base}${goodsHelp.filePath}">■ ${goodsHelp.name}</a></span>
                        </li>
                        </#if>
                        </#list>
					</ul>
				</div>
			</div>
		</div>
		<div class="blank"></div>
		<#include "/WEB-INF/template/shop/friend_link.ftl">
	</div>
	<div class="blank"></div>
	<#include "/WEB-INF/template/shop/footer.ftl">
	<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
	<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
	<script type="text/javascript" src="${base}/template/common/js/jquery.zoomimage.js"></script>
	<script type="text/javascript" src="${base}/template/shop/js/base.js"></script>
	<script type="text/javascript" src="${base}/template/shop/js/shop.js"></script>
	<script type="text/javascript">
	$().ready( function() {
	
		$productSn = $("#productSn");
		$price = $("#price");
		$marketPrice = $("#marketPrice");
		$buyInfo = $("#buyInfo");
		$tipsTitle = $("#tipsTitle");
		$tipsContent = $("#tipsContent");
		$closeHighlight = $("#closeHighlight");
		$specificationValue = $("#buyInfo li");
		$quantity = $("#quantity");
		$goodsButton = $("#goodsButton");
	
		// 添加商品浏览记录
		$.addGoodsHistory("${substring(goods.name, 24, "...")}", "${base}${goods.htmlPath}");
		
		<#if goods.isSpecificationEnabled>
			var productDatas = {};
			<#list goods.productSet as product>
				<#if product.isMarketable>
					productDatas['${product.id}'] = {
						productSn: "${product.productSn}",
						price: "${product.price?string(currencyFormat)}",
						marketPrice: "${product.marketPrice?string(currencyFormat)}",
						isOutOfStock: ${product.isOutOfStock?string("true", "false")}
					};
				</#if>
			</#list>
			
			var specificationValueDatas = {};
			<#list goods.productSet as product>
				<#if product.isMarketable>
					specificationValueDatas['${product.id}'] = new Array(<#list product.specificationValueList as specificationValue>"${specificationValue.id}"<#if specificationValue_has_next>, </#if></#list>);
				</#if>
			</#list>
			
			var specificationValueSelecteds = new Array();
			var selectedProductId = null;
			
			$specificationValue.click(function () {
				var $this = $(this);
				if ($this.hasClass("notAllowed")) {
					return false;
				}
				
				if ($this.hasClass("selected")) {
					$this.removeClass("selected");
				} else {
					$this.addClass("selected");
				}
				$this.siblings("li").removeClass("selected");
				$specificationValue.addClass("notAllowed");
				
				var $specificationValueSelected = $("#buyInfo li.selected");
				if ($specificationValueSelected.length == 1) {
					$specificationValueSelected.siblings("li").removeClass("notAllowed");
				}
				
				var specificationValueSelecteds = new Array();
				selectedProductId = null;
				var tipsContentText = "";
				$specificationValueSelected.each(function(i) {
					var $this = $(this);
					tipsContentText += $this.attr("title") + " ";
					specificationValueSelecteds.push($this.attr("specificationValueId"));
				});
				if (tipsContentText != "") {
					$tipsTitle.text("${bundle("goods.content.javascript.selected")}: ");
					$tipsContent.text(tipsContentText);
				} else {
					$tipsTitle.text("${bundle("goods.content.buyInfo.tipsTitle")}: ");
					$tipsContent.text("<#list goods.specificationSet as specification>${specification.name} </#list>");
				}
				$.each(specificationValueDatas, function(i) {
					if (arrayContains(specificationValueDatas[i], specificationValueSelecteds)) {
						for (var j in specificationValueDatas[i]) {
							$("." + specificationValueDatas[i][j]).removeClass("notAllowed");
						}
					}
					if (arrayEqual(specificationValueDatas[i], specificationValueSelecteds)) {
						$productSn = $productSn.text(productDatas[i].productSn);
						$price = $price.text(productDatas[i].price);
						$marketPrice = $marketPrice.text(productDatas[i].marketPrice);
						selectedProductId = i;
						$buyInfo.removeClass("highlight");
						if (productDatas[i].isOutOfStock) {
							$goodsButton.addClass("goodsNotifyButton");
							$goodsButton.removeClass("addCartItemButton");
						} else {
							$goodsButton.addClass("addCartItemButton");
							$goodsButton.removeClass("goodsNotifyButton");
						}
					}
				});
			});
			
			// 添加商品至购物车/到货通知
			$goodsButton.click(function () {
				var $this = $(this);
				if (selectedProductId != null) {
					if ($this.hasClass("addCartItemButton")) {
						$.addCartItem(selectedProductId, $quantity.val());
					} else {
						location.href = '${base}/shop/goods_notify!add.action?product.id=' + selectedProductId;
					}
				} else {
					$buyInfo.addClass("highlight");
					$tipsTitle.text('${bundle("goods.content.javascript.sysMsg")}:');
					$tipsContent.text('${bundle("goods.content.javascript.choose.goods")}!');
				}
			});
			
			// 关闭购买信息提示
			$closeHighlight.click(function () {
				$buyInfo.removeClass("highlight");
				$tipsTitle.html("${bundle("goods.content.buyInfo.tipsTitle")}: ");
				$tipsContent.html("<#list goods.specificationSet as specification>${specification.name} </#list>");
			});
			
			// 判断数组是否包含另一个数组中所有元素
			function arrayContains(array1, array2) {
				if(!(array1 instanceof Array) || !(array2 instanceof Array)) {
					return false;
				}
				if(array1.length < array2.length) {
					return false;
				}
				for (var i in array2) {
					if ($.inArray(array2[i], array1) == -1) {
						return false;
					}
				}
				return true;
			}
			
			// 判断两个数组中的所有元素是否相同
			function arrayEqual(array1, array2) {
				if(!(array1 instanceof Array) || !(array2 instanceof Array)) {
					return false;
				}
				if(array1.length != array2.length) {
					return false;
				}
				for (var i in array2) {
					if ($.inArray(array2[i], array1) == -1) {
						return false;
					}
				}
				return true;
			}
		<#else>
			var selectedProductId = "${goods.defaultProduct.id}";
			
			// 添加商品至购物车/到货通知
			$goodsButton.click(function () {
				var $this = $(this);
				if ($this.hasClass("addCartItemButton")) {
					$.addCartItem(selectedProductId, $quantity.val());
				} else {
					location.href='${base}/shop/goods_notify!add.action?product.id=' + selectedProductId;
				}
			});
		</#if>
	
	})
	</script>
</body>
</html>