<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="delivery.corp.list.title"/> - Powered By SHOP++</title>
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
		<@s.text name="role.sitemanage.ROLE_DELIVERY_CORP"/>&nbsp;<@s.text name="role.list.page.tips2"/>: ${pager.totalCount} (<@s.text name="role.list.page.tips3"/>${pager.pageCount}<@s.text name="role.list.page.tips4"/>)
	</div>
	<div class="body">
		<form id="listForm" action="delivery_corp!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='delivery_corp!add.action'" value="<@s.text name="delivery.corp.list.add"/>" hidefocus />
			</div>
			<table id="listTable" class="listTable">
				<tr>
					<th class="check">
						<input type="checkbox" class="allCheck" />
					</th>
					<th>
						<a href="#" class="sort" name="name" hidefocus><@s.text name="shipping.deliveryCorpName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="url" hidefocus><@s.text name="delivery.corp.website"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="orderList" hidefocus><@s.text name="goods.specification.list.search.result.header.order"/></a>
					</th>
					<th>
						<span><@s.text name="goods.specification.list.search.result.header.operation"/></span>
					</th>
				</tr>
				<#list pager.result as deliveryCorp>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${deliveryCorp.id}" />
						</td>
						<td>
							${deliveryCorp.name}
						</td>
						<td>
							${deliveryCorp.url}
						</td>
						<td>
							${deliveryCorp.orderList}
						</td>
						<td>
							<a href="delivery_corp!edit.action?id=${deliveryCorp.id}" title="<@s.text name="goods.common.edit"/>">[<@s.text name="goods.common.edit"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="delivery_corp!delete.action" value="<@s.text name="goods.specification.list.search.result.header.delete"/>" disabled hidefocus />
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