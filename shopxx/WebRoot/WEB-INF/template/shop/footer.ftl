<div class="footer">
	<div class="bottomNavigation">
		<@navigation_list position="bottom"; navigationList>
			<#list navigationList as navigation>
				<#if (navigation_index + 1) == 1>
					<dl>
				</#if>
					<dd>
						<a href="<@navigation.url?interpret />"<#if navigation.isBlankTarget> target="_blank"</#if>>${navigation.name}</a>
					</dd>
				<#if (navigation_index + 1) % 3 == 0 && navigation_has_next>
					</dl>
					<dl>
				</#if>
				<#if !navigation_has_next>
					</dl>
				</#if>
			</#list>
		</@navigation_list>
	</div>
	<div class="footerInfo">
		<ul>
			<li><a href="#">${bundle("footer.about")}</a>|</li>
			<li><a href="#">${bundle("footer.help")}</a>|</li>
			<li><a href="#">${bundle("footer.map")}</a>|</li>
			<li><a href="#">${bundle("footer.apply")}</a>|</li>
			<li><a href="#">${bundle("footer.contact")}</a>|</li>
			<li><a href="#">${bundle("footer.copyright")}</a></li>
		</ul>
		<p>Copyright &copy;  All rights reserved. </p>
		<#if setting.isShowPoweredInfo>
			<p>Powered by <a class="systemName" href="http://www.shopxx.net" target="_blank">SHOP<span>++</span> V2.1</a></p>
		</#if>
	</div>
</div>