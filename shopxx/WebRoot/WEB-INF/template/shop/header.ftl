<div id="header" class="header belatedPNG">
	<div class="headerTop belatedPNG">
		<div class="headerTopContent">
			<div class="headerLoginInfo">
				${bundle("goods.head.login.hello")}<span id="headerLoginMemberUsername"></span>, ${bundle("goods.head.login.welcome")}${(setting.shopName)!}!
				<a href="javascript: void(0);" id="headerShowLoginWindow">${bundle("goods.common.login")}</a>
				<a href="${base}/shop/member_center!index.action" id="headerMemberCenter">${bundle("goods.notify.memberCenter")}</a>
				<a href="javascript: void(0);" id="headerShowRegisterWindow">${bundle("goods.common.register")}</a>
				<a href="${base}/shop/member!logout.action" id="headerLogout">[${bundle("goods.common.logout")}]</a>
			</div>
			<div class="headerTopNav">
				<@navigation_list position="top"; navigationList>
					<#list navigationList as navigation>
						<a href="<@navigation.url?interpret />"
							<#if navigation.isBlankTarget> target="_blank"</#if>>${navigation.name}
						</a>
						<#if navigation_has_next>|</#if>
					</#list>
				</@navigation_list>
			</div>
		</div>
	</div>
	<div class="headerMiddle">
		<div class="headerInfo">
			<#if (setting.phone?? && setting.phone != "")!>
				7×24${bundle("goods.notify.memberCenter.phone")}: <strong>${setting.phone}</strong>
			</#if>
		</div>
		<div class="headerLogo">
			<a href="${base}/"><img class="belatedPNG" src="${base}${(setting.shopLogoPath)!}" alt="${(setting.shopName)!}" /></a>
		</div>
		<div class="headerSearch belatedPNG">
			<form id="goodsSearchForm" action="${base}/shop/goods!search.action" method="post">
				<div class="headerSearchText">
					<input type="text" id="goodsSearchKeyword" name="pager.keyword" value="<#if (pager.keyword)?? && searchType == "product">${pager.keyword}<#else>${bundle("goods.picture.search.key.input")}...</#if>" />
				</div>
				<input type="submit" class="headerSearchButton" value="" />
				<div class="hotKeyword">
					${bundle("goods.picture.search.key.hot")}: 
					<#list setting.hotSearchList as hotSearch>
						<a href="${base}/shop/goods!search.action?pager.keyword=${hotSearch?url}">${hotSearch}</a>
					</#list>
				</div>
			</form>
		</div>
	</div>
	<div class="headerBottom">
		<input type="button" class="cartItemListButton" value="" onclick="window.open('${base}/shop/cart_item!list.action')" />
		<input type="button" class="orderButton" value="" onclick="window.open('${base}/shop/cart_item!list.action')" />
		<div class="headerMiddleNav">
			<div class="headerMiddleNavLeft belatedPNG"></div>
			<ul class="headerMiddleNavContent belatedPNG">
				<@navigation_list position="middle"; navigationList>
					<#list navigationList as navigation>
						<li>
							<a href="<@navigation.url?interpret />"
								<#if navigation.isBlankTarget> target="_blank"</#if>>${navigation.name}
							</a>
						</li>
					</#list>
				</@navigation_list>
			</ul>
			<div class="headerMiddleNavRight belatedPNG"></div>
		</div>
	</div>
</div>