<div class="title"><strong>${bundle("goods.recommend")}</strong></div>
<ul class="menu">
	<#list recommendList as recommendGoods>
		<li>
			<a href="${base}${recommendGoods.htmlPath}">
				<img src="${base}${recommendGoods.defaultThumbnailGoodsImagePath}">
				<span class="text"><a href="${base}${recommendGoods.htmlPath}">${recommendGoods.name}</a></span>
			</a>
		</li>
	</#list>
</ul>