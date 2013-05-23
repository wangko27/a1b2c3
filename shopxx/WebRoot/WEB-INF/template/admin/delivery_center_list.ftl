<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="delivery.center.list.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.pager.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
</head>
<body class="list">
	<div class="bar">
		<@s.text name="delivery.center.list.manage"/>&nbsp;<@s.text name="goods.specification.list.page.tips1"/>: ${pager.totalCount} (<@s.text name="goods.specification.list.page.tips2"/>${pager.pageCount}<@s.text name="goods.specification.list.page.tips3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="delivery_center!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='delivery_center!add.action'" value="<@s.text name="delivery.center.list.add"/>" hidefocus />
			</div>
			<table id="listTable" class="listTable">
				<tr>
					<th class="check">
						<input type="checkbox" class="allCheck" />
					</th>
					<th>
						<a href="#" class="sort" name="name" hidefocus><@s.text name="delivery.center.list.name"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="consignor" hidefocus><@s.text name="delivery.center.list.consignor"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="areaStore" hidefocus><@s.text name="goods.common.area"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="address" hidefocus><@s.text name="goods.common.address"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="isDefault" hidefocus><@s.text name="delivery.template.isDefault"/></a>
					</th>
					<th>
						<span><@s.text name="favorite.list.header.operation"/></span>
					</th>
				</tr>
				<#list pager.result as deliveryCenter>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${deliveryCenter.id}" />
						</td>
						<td>
							${deliveryCenter.name}
						</td>
						<td>
							${deliveryCenter.consignor}
						</td>
						<td>
							${deliveryCenter.area.name}
						</td>
						<td>
							${deliveryCenter.address}
						</td>
						<td>
							<span class="${deliveryCenter.isDefault?string('true','false')}Icon">&nbsp;</span>
						</td>
						<td>
							<a href="delivery_center!edit.action?id=${deliveryCenter.id}" title="<@s.text name="goods.common.edit"/>">[<@s.text name="goods.common.edit"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="delivery_center!delete.action" value="<@s.text name="goods.specification.list.search.result.header.delete"/>" disabled hidefocus />
					</div>
					<div class="pager">
						<#include "/WEB-INF/template/admin/pager.ftl" />
					</div>
				<div>
			<#else>
				<div class="noRecord"><@s.text name="common.empty"/></div>
			</#if>
		</form>
	</div>
</body>
</html>