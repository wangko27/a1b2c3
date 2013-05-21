<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${goodsCategory.name} ${bundle("goods.picture.list.title")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<#if (goodsCategory.metaKeywords)! != ""><meta name="keywords" content="${goodsCategory.metaKeywords}" /></#if>
<#if (goodsCategory.metaDescription)! != ""><meta name="description" content="${goodsCategory.metaDescription}" /></#if>
<link rel="icon" href="favicon.ico" type="image/x-icon" />
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
<body class="goodsList">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body">
		<div class="bodyLeft">
			<div class="goodsCategory">
            	<div class="top">${bundle("goods.picture.list.category")}</div>
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
				<div class="top">${bundle("goods.picture.list.rank")}</div>
				<div class="middle">
					<ul>
						<@goods_list goods_category_id=goodsCategory.id type="hot" count=10; goodsList>
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
				<div class="top">${bundle("goods.picture.list.history")}</div>
				<div class="middle">
					<ul id="goodsHistoryListDetail"></ul>
				</div>
				<div class="bottom"></div>
			</div>
		</div>
		<div class="bodyRight">
			<form id="goodsListForm" action="${base}${goodsCategory.url}" method="post">
				<input type="hidden" name="id" value="${goodsCategory.id}" />
				<input type="hidden" id="viewType" name="viewType" value="pictureType" />
				<input type="hidden" id="pageNumber" name="pager.pageNumber" value="${pager.pageNumber}" />
				<input type="hidden" id="brandId" name="brand.id" value="${(brand.id)!}" />
				<div class="listBar">
					<div class="left"></div>
					<div class="middle">
						<div class="path">
							<a href="${base}/" class="shop"><span class="icon">&nbsp;</span>${bundle("goods.common.main")}</a> &gt;
							<#list pathList as path>
								<a href="${base}${path.url}">${path.name}</a> &gt;
							</#list>
						</div>
						<div class="total">${bundle("goods.picture.list.calculate")}: ${pager.totalCount} ${bundle("goods.picture.list.calculate.object")}</div>
					</div>
					<div class="right"></div>
				</div>
				<#if (goodsCategory.children?? && goodsCategory.children?size > 0) || goodsCategory.goodsType??>
					<#assign goodsType = goodsCategory.goodsType />
					<div class="blank"></div>
					<div id="filter" class="filter">
						<#if (goodsCategory.children?? && goodsCategory.children?size > 0)>
							<dl>
								<dt>${bundle("goods.picture.list.category")}: </dt>
								<dd>
									<div>
										<a href="${base}${goodsCategory.url}" class="current">${bundle("goods.common.all")}</a>
									</div>
									<#list goodsCategory.children as childrenGoodsCategory>
										<div>
											<a href="${base}${childrenGoodsCategory.url}">${childrenGoodsCategory.name}</a>
										</div>
									</#list>
								</dd>
							</dl>
						</#if>
						<#if goodsType != null>
							<#if (goodsType.brandSet?? && goodsType.brandSet?size > 0)>
								<dl>
									<dt>${bundle("goods.picture.list.goods.brand")}: </dt>
									<dd>
										<div>
											<a href="#" class="brand all<#if !brand??> current</#if>">${bundle("goods.common.all")}</a>
										</div>
										<#list goodsType.brandSet as b>
											<div>
												<a href="#" class="brand<#if b == brand> current</#if>" brandId="${b.id}">${b.name}</a>
											</div>
										</#list>
									</dd>
								</dl>
							</#if>
							<#if (goodsType.goodsAttributeSet?? && goodsType.goodsAttributeSet?size > 0)>
								<#assign hasInputGoodsAttribute = false />
								<#list goodsType.goodsAttributeSet as goodsAttribute>
									<#if goodsAttribute.attributeType == "filter">
										<#assign goodsAttributeOption = (goodsAttributeIdMap[goodsAttribute.id])!"" />
										<dl>
											<dt>${goodsAttribute.name}: </dt>
											<dd>
												<div>
													<a href="#" class="goodsAttributeOption all<#if goodsAttributeOption == ""> current</#if>">${bundle("goods.common.all")}</a>
												</div>
												<#list goodsAttribute.optionList as option>
													<div>
														<input type="hidden" name="goodsAttributeIdMap['${goodsAttribute.id}']" value="${option}"<#if option != goodsAttributeOption> disabled</#if> />
														<a href="#" class="goodsAttributeOption<#if option == goodsAttributeOption> current</#if>">${option}</a>
													</div>
												</#list>
											</dd>
										</dl>
									<#else>
										<#assign hasInputGoodsAttribute = true />
										<dl>
											<dt>${goodsAttribute.name}: </dt>
											<dd>
												<div>
													<input type="text" name="goodsAttributeIdMap['${goodsAttribute.id}']" value="${(goodsAttributeIdMap[goodsAttribute.id])!}" />
												</div>
											</dd>
										</dl>
									</#if>
								</#list>
								<#if hasInputGoodsAttribute>
									<div class="buttonArea">
										<input type="submit" value="${bundle("goods.picture.list.goods.filter")}" />
									</div>
								</#if>
							</#if>
						</#if>
						<div class="clear"></div>
					</div>
				</#if>
				<div class="blank"></div>
				<div class="operateBar">
					<div class="left"></div>
					<div class="middle">
						<span class="tableIcon">&nbsp;</span><a id="tableType" class="tableType" href="#">${bundle("goods.picture.list")}</a>
						<span class="pictureDisabledIcon">&nbsp;</span>${bundle("goods.picture.list.picture")}
						<span class="separator">&nbsp;</span>
						<select id="orderType" name="orderType">
							<option value="default"<#if orderType == "default"> selected="selected"</#if>>${bundle("goods.picture.list.sort.default")}</option>
							<option value="priceAsc"<#if orderType == "priceAsc"> selected="selected"</#if>>${bundle("goods.picture.list.sort.priceASC")}</option>
							<option value="priceDesc"<#if orderType == "priceDesc"> selected="selected"</#if>>${bundle("goods.picture.list.sort.priceDESC")}</option>
							<option value="dateDesc"<#if orderType == "dateDesc"> selected="selected"</#if>>${bundle("goods.picture.list.sort.time")}</option>
							<option value="salesDesc"<#if orderType == "salesDesc"> selected="selected"</#if>>${bundle("goods.picture.list.sort.hot")}</option>
							<option value="discountAsc"<#if orderType == "discountAsc"> selected="selected"</#if>>${bundle("goods.picture.list.sort.discount")}</option>
	                    </select>
	                    <span class="separator">&nbsp;</span> ${bundle("goods.picture.list.sort.numberShow")}: 
						<select name="pager.pageSize" id="pageSize">
							<option value="12" <#if pager.pageSize == 12>selected="selected" </#if>>
								12
							</option>
							<option value="20" <#if pager.pageSize == 20>selected="selected" </#if>>
								20
							</option>
							<option value="60" <#if pager.pageSize == 60>selected="selected" </#if>>
								60
							</option>
							<option value="120" <#if pager.pageSize == 120>selected="selected" </#if>>
								120
							</option>
						</select>
					</div>
					<div class="right"></div>
				</div>
				<div class="blank"></div>
				<div class="goodsPictureList">
					<ul class="goodsListDetail">
						<#list pager.result as goods>
							<li<#if (goods_index + 1) % 4 == 0> class="end"</#if>>
								<a href="${base}${goods.htmlPath}" class="goodsImage" target="_blank" id="goodsImage_${goods.id}">
									<img src="${base}${goods.defaultThumbnailGoodsImagePath}" alt="${goods.name}" />
								</a>
								<div class="goodsTitle">
									<a href="${base}${goods.htmlPath}" alt="${goods.name}" target="_blank" id="goodsName_${goods.id}">
										${substring(goods.name, 24)}
									</a>
								</div>
								<div class="goodsBottom">
									<div class="goodsPrice">
										<span class="price" id="goodsPrice_${goods.id}">${goods.price?string(currencyFormat)}</span>
										<#if setting.isShowMarketPrice>
											<span class="marketPrice">${goods.marketPrice?string(currencyFormat)}</span>
										</#if>
									</div>
									<div class="buttonArea">
										<a href="${base}${goods.htmlPath}" class="addCartItemButton">${bundle("goods.picture.list.goods.buy")}</a>
										<input type="button" class="addFavoriteButton addFavorite" value="${bundle("goods.picture.list.goods.store")}" goodsId="${goods.id}" hidefocus />
										<#if goodsCategory.grade == 2>
										<input type="hidden" id="goodsCategory" value="${goodsCategory.sign}"/>
										<input type="button" class="addFavoriteButton addCompare" value="${bundle("goods.picture.list.goods.compare")}" goodsId="${goods.id}" hidefocus />
										</#if>
									</div>
								</div>
							</li>
						</#list>
						<#if (pager.result?size == 0)!>
                			<li class="noRecord">${bundle("goods.picture.list.goods.sorry")}!</li>
                		</#if>
					</ul>
					<div class="blank"></div>
         			<@pagination pager=pager baseUrl=goodsCategory.url parameterMap = parameterMap>
         				<#include "/WEB-INF/template/shop/pager.ftl">
         			</@pagination>
				</div>
			</form>
		</div>
		<div class="blank"></div>
		<#include "/WEB-INF/template/shop/friend_link.ftl">
	</div>
	<div class="blank"></div>
	<#include "/WEB-INF/template/shop/footer.ftl">
	
	
	<div id="pop-compare" data-load="true" class="pop-compare" style="display: none; bottom: 0px;">
	    <div class="pop-wrap">
	        <p class="pop-compare-tips"></p>
	        <div class="pop-inner" data-widget="tabs">
	            <div class="diff-hd">
	                <ul class="tab-btns clearfix">
	                    <li class="current" data-widget="tab-item"><a href="javascript:;">${bundle("goods.picture.list.goods.compare.menu")}</a></li>
	                </ul>
	                <div class="operate">
	                    <a href="javascript:;" class="hide-me" id="hideCompare">${bundle("goods.common.hide")}</a>
	                </div>
	            </div>
	            <div class="diff-bd tab-cons">
	                <div class="tab-con" data-widget="tab-content">
	                    <div id="diff-items" class="diff-items clearfix">
	                        
	                    </div>
	                    <div class="diff-operate"><a target="_blank" id="goto-contrast" href="javascript:;" class="btn-compare-b">${bundle("goods.picture.list.goods.compare")}</a><a class="del-items" href="javascript:;" id="clearCompare">${bundle("goods.picture.list.goods.compare.clear")}</a></div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
	<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
	<script type="text/javascript" src="${base}/template/common/js/jquery.cookie.js"></script>
	<script type="text/javascript" src="${base}/template/shop/js/base.js"></script>
	<script type="text/javascript" src="${base}/template/shop/js/shop.js"></script>
	<script type="text/javascript">
		$().ready( function() {
			// $.addCompare();
			$('#clearCompare').bind('click', function(){
				$.clearCompare();
			});
			$('#hideCompare').bind('click', function(){
				$('#pop-compare').hide();
			});
		});
	</script>
</body>
</html>