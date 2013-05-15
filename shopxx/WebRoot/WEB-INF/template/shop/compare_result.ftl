<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>商品比较<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<#if (goodsCategory.metaKeywords)! != ""><meta name="keywords" content="${goodsCategory.metaKeywords}" /></#if>
<#if (goodsCategory.metaDescription)! != ""><meta name="description" content="${goodsCategory.metaDescription}" /></#if>
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/shop/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/shop.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
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
		<div id="shop_contrast">
    		<div class="title"><strong>基本信息</strong></div>
        	<table width="1000" border="1" class="tb">
			<tr>
			    <th>商品图片</th>
			    <#list compareResultList as goods>
			    <td><div class="pro"><img src="${base}${goods.defaultSmallGoodsImagePath}" align="middle" /></div></td>
			    </#list>
			</tr>
			<tr>
			    <th>商品名称</th>
			    <#list compareResultList as goods>
				<td>${goods.name}</td>
				</#list>
			</tr>
			<tr>
			    <th>商品编号</th> 
			    <#list compareResultList as goods>
				<td>${goods.goodsSn}</td>
				</#list>
			</tr>
		  	<tr>
			    <th>销售价</th> 
			    <#list compareResultList as goods>
				<td>${goods.price}</td>
				</#list>
		  	</tr>
		  	<tr>
		     	<th>市场价</th> 
		     	<#list compareResultList as goods>
				<td>${goods.marketPrice}</td>
				</#list>
		  	</tr>
  			<tr>
		     	<th>品牌名称</th>
		     	<#list compareResultList as goods>
				<td>${goods.brand.name}</td>
				</#list>
  			</tr>
  			<tr>
     			<th>用户评分</th>
     			<#list compareResultList as goods>
				<td>
					<#if goods.averageScore == 0>
            		<img src="${base}/template/shop/images/shop_star2.gif"><img src="${base}/template/shop/images/shop_star2.gif"><img src="${base}/template/shop/images/shop_star2.gif"><img src="${base}/template/shop/images/shop_star2.gif"><img src="${base}/template/shop/images/shop_star2.gif">
            		</#if>
            		<#if goods.averageScore != 0>
            		<#list 1..goods.averageScore as t>
                	<img src="${base}/template/shop/images/shop_star1.gif">
                	</#list>
                	<#list (goods.averageScore + 1)..5 as t>
                    <img src="${base}/template/shop/images/shop_star2.gif">
                    </#list>
            		</#if>
				</td>
				</#list>
  			</tr>
			</table>
			<div class="blank"></div>
			
			<div class="title"><strong>产品参数</strong></div>
			<table width="1000" border="1" class="tb">
			<tr>
			    <th>商品属性值0</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue0}</td>
				</#list>
		  	</tr>
  			<tr>
			    <th>商品属性值1</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue1}</td>
				</#list>
		  	</tr>
		  	<tr>
			    <th>商品属性值2</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue2}</td>
				</#list>
		  	</tr>
			<tr>
			    <th>商品属性值3</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue3}</td>
				</#list>
		  	</tr>
		  	<tr>
			    <th>商品属性值4</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue4}</td>
				</#list>
		  	</tr>
			<tr>
			    <th>商品属性值5</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue5}</td>
				</#list>
		  	</tr>
		  	<tr>
			    <th>商品属性值6</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue6}</td>
				</#list>
		  	</tr>
			<tr>
			    <th>商品属性值7</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue7}</td>
				</#list>
		  	</tr>
		  	<tr>
			    <th>商品属性值8</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue8}</td>
				</#list>
		  	</tr>
			<tr>
			    <th>商品属性值9</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue9}</td>
				</#list>
		  	</tr>
		  	<tr>
			    <th>商品属性值10</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue10}</td>
				</#list>
		  	</tr>
			<tr>
			    <th>商品属性值11</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue11}</td>
				</#list>
		  	</tr>
		  	<tr>
			    <th>商品属性值12</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue12}</td>
				</#list>
		  	</tr>
			<tr>
			    <th>商品属性值13</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue13}</td>
				</#list>
		  	</tr>
		  	<tr>
			    <th>商品属性值14</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue14}</td>
				</#list>
		  	</tr>
			<tr>
			    <th>商品属性值15</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue15}</td>
				</#list>
		  	</tr>
		  	<tr>
			    <th>商品属性值16</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue16}</td>
				</#list>
		  	</tr>
			<tr>
			    <th>商品属性值17</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue17}</td>
				</#list>
		  	</tr>
		  	<tr>
			    <th>商品属性值18</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue18}</td>
				</#list>
		  	</tr>
			<tr>
			    <th>商品属性值19</th>
			    <#list compareResultList as goods>
				<td>${goods.goodsAttributeValue19}</td>
				</#list>
		  	</tr>
			</table>
		</div>
		<div class="blank"></div>
		<#include "/WEB-INF/template/shop/friend_link.ftl">
	</div>
	<div class="blank"></div>
	<#include "/WEB-INF/template/shop/footer.ftl">
	
	<div id="tool">
		<div id="locate"></div>
		<div id="static"></div>
		<div class="con">
			<a href="#" class="setup" style="width:99px;"><b></b>高亮显示不同项</a>
			<a href="#" class="setup" style="width:75px;"><b></b>隐藏相同项</a>
			<a href="" class="setup" style="width:63px;"><b></b>新增商品</a>
		</div>
	</div>
	<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
	<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
	<script type="text/javascript" src="${base}/template/shop/js/base.js"></script>
	<script type="text/javascript" src="${base}/template/shop/js/shop.js"></script>
</body>
</html>