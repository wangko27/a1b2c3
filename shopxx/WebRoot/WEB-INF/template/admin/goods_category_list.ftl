<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="goods.category.list"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.pager.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $deleteGoodsCategory = $("#listTable .deleteGoodsCategory");
	var $goodsCategoryName = $("#listTable .goodsCategoryName");
	
	// 删除商品分类
	$deleteGoodsCategory.click( function() {
		if (confirm("<@s.text name="goods.category.list.delete"/>?") == false) {
			return false;
		}
	});
	
	// 树折叠
	$goodsCategoryName.click( function() {
		var grade = $(this).parent().attr("grade");
		var isHide;
		$(this).parent().nextAll("tr").each(function() {
			$this = $(this);
			var level = $this.attr("grade");
			if(level <= grade) {
				return false;
			}
			if(isHide == null) {
				if($this.css("display") == "none") {
					isHide = true;
				} else {
					isHide = false;
				}
			}
			if(isHide) {
				$this.show();
			} else {
				$this.hide();
			}
		});
	});

})
</script>
</head>
<body class="list goodsCategory">
	<div class="bar">
		<@s.text name="goods.category.list"/>&nbsp;<span class="pageInfo"><@s.text name="goods.specification.list.page.tips1"/>: ${goodsCategoryTreeList?size}
	</div>
	<div class="body">
		<form id="listForm" action="goods_category!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='goods_category!add.action'" value="<@s.text name="article.category.list.add"/>" hidefocus />
			</div>
			<table id="listTable" class="listTable">
				<tr>
					<th>
						<span><@s.text name="admin.category.name"/></span>
					</th>
					<th>
						<span><@s.text name="goods.specification.list.search.result.header.order"/></span>
					</th>
					<th>
						<span><@s.text name="goods.specification.list.search.result.header.operation"/></span>
					</th>
				</tr>
				<#list goodsCategoryTreeList as goodsCategory>
					<tr grade="${goodsCategory.grade}">
						<td class="goodsCategoryName">
							<#if goodsCategory.grade == 0>
								<span class="pointer firstCategory" style="margin-left: ${goodsCategory.grade * 20}px;">
									${goodsCategory.name}
								</span>
							<#else>
								<span class="pointer category" style="margin-left: ${goodsCategory.grade * 20}px;">
									${goodsCategory.name}
								</span>
							</#if>
						</td>
						<td>
							${goodsCategory.orderList}
						</td>
						<td>
							<a href="${base}${goodsCategory.url}" target="_blank" title="<@s.text name="shipping.list.single.view"/>">[<@s.text name="shipping.list.single.view"/>]</a>
							<#if (goodsCategory.children?size > 0)>
								<span title="<@s.text name="article.category.list.delete.error"/>">[<@s.text name="button.name.delete"/>]</span>
							<#else>
								<a href="goods_category!delete.action?id=${goodsCategory.id}" class="deleteGoodsCategory" title="<@s.text name="button.name.delete"/>">[<@s.text name="button.name.delete"/>]</a>
							</#if>
							<a href="goods_category!edit.action?id=${goodsCategory.id}" title="<@s.text name="goods.common.edit"/>">[<@s.text name="goods.common.edit"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if goodsCategoryTreeList?size == 0>
				<div class="noRecord"><@s.text name="common.empty"/></div>
			</#if>
		</form>
	</div>
</body>
</html>