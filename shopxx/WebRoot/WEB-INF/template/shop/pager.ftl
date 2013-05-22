<#if (pageCount > 1)>
	<ul class="pager">
		<li class="pageInfo">
			${bundle("goods.common.total")} ${pageCount} ${bundle("goods.common.page")}
		</li>
		
		<#if (pageNumber > 1)>
			<li class="firstPage">
				<a href="${base}${firstPageUrl}">${bundle("goods.common.main")}</a>
			</li>
		<#else>
			<li class="firstPage">
				<span>${bundle("goods.common.main")}</span>
			</li>
		</#if>
		
		<#if (pageNumber > 1)>
			<li class="prePage">
				<a href="${base}${prePageUrl}">${bundle("goods.common.page.prev")}</a>
			</li>
		<#else>
			<li class="prePage">
				<span>${bundle("goods.common.page.prev")}</span>
			</li>
		</#if>
		
		<#list (pageItem?keys)! as key>
			<#if (key_index == 0 && key?number > 1)>
				<li>...</li>
			</#if>
			<#if pageNumber != key?number>
				<li>
					<a href="${base}${pageItem[key]}">${key}</a>
				</li>
			<#else>
				<li class="currentPage">
					<span>${key}</span>
				</li>
			</#if>
			<#if (!key_has_next && key?number < pageCount)>
				<li>...</li>
			</#if>
		</#list>
	    
		<#if (pageNumber < pageCount)>
			<li class="nextPage">
				<a href="${base}${nextPageUrl}">${bundle("goods.common.page.next")}</a>
			</li>
		<#else>
			<li class="nextPage">
				<span>${bundle("goods.common.page.next")}</span>
			</li>
		</#if>
		
		<#if (pageNumber < pageCount)>
			<li class="lastPage">
				<a href="${base}${lastPageUrl}">${bundle("goods.common.page.last")}</a>
			</li>
		<#else>
			<li class="lastPage">
				<span>${bundle("goods.common.page.last")}</span>
			</li>
		</#if>
	</ul>
</#if>