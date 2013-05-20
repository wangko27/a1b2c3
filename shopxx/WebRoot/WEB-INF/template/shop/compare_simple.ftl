<#list compareResultList as goods>
<dl class="hasItem" id="cmp_item_${goods.id}" fore="0">
    <dt><a target="_blank" href="${base}${goods.htmlPath}"><img src="${base}${goods.defaultThumbnailGoodsImagePath}" alt="${goods.name}" width="50" height="50"></a></dt>
    <dd><a target="_blank" class="diff-item-name" href="${base}${goods.htmlPath}">${goods.name}</a>
    <span class="p-price">${goods.price?string(currencyFormat)}<a class="del-comp-item" skuid="832704" style="visibility: hidden;">${bundle("button.name.delete")}</a></span>    </dd>
</dl>
</#list>
<#if resultSize lt 4>
<#assign startSeq=(resultSize + 1)>
<#list startSeq..4 as i>
<dl class="item-empty"><dt>${i}</dt><dd>${bundle("goods.compare.single.empty")}</dd></dl>
</#list>
</#if>