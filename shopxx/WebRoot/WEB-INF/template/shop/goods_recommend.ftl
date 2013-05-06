<ul class="menu">
	<#list recommendList as recommendGoods>
		<li>
			<a href="${base}${recommendGoods.htmlPath}">
				<span class="icon">&nbsp;</span>${recommendGoods.name}
			</a>
		</li>
	</#list>
</ul>