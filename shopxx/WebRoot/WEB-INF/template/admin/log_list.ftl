<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="log.list.title"/> - Powered By SHOP++</title>
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
		<@s.text name="log.list.title"/>&nbsp;<@s.text name="goods.specification.list.page.tips1"/>: ${pager.totalCount} (<@s.text name="goods.specification.list.page.tips2"/>${pager.pageCount}<@s.text name="goods.specification.list.page.tips3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="log!list.action" method="post">
			<div class="listBar">
				<label><@s.text name="goods.specification.list.search.label"/>: </label>
				<select name="pager.searchBy">
					<option value="operation"<#if pager.searchBy == "operation"> selected</#if>>
						<@s.text name="log.list.operate.name"/>
					</option>
					<option value="operator"<#if pager.searchBy == "operator"> selected</#if>>
						<@s.text name="refund.operator"/>
					</option>
				</select>
				<input type="text" name="pager.keyword" value="${pager.keyword!}" />
				<input type="button" id="searchButton" class="formButton" value="<@s.text name="goods.specification.list.search.button"/>" hidefocus />
				&nbsp;&nbsp;
				<label><@s.text name="goods.specification.list.search.result"/>: </label>
				<select name="pager.pageSize" id="pageSize">
					<option value="10"<#if pager.pageSize == 10> selected</#if>>
						10
					</option>
					<option value="20"<#if pager.pageSize == 20> selected</#if>>
						20
					</option>
					<option value="50"<#if pager.pageSize == 50> selected</#if>>
						50
					</option>
					<option value="100"<#if pager.pageSize == 100> selected</#if>>
						100
					</option>
				</select>
			</div>
			<table id="listTable" class="listTable">
				<tr>
					<th class="check">
						<input type="checkbox" class="allCheck" />
					</th>
					<th>
						<a href="#" class="sort" name="operation" hidefocus><@s.text name="log.list.operate.name"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="operator" hidefocus><@s.text name="refund.operator"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="ip" hidefocus><@s.text name="common.button.operate"/>IP</a>
					</th>
					<th>
						<a href="#" class="sort" name="info" hidefocus><@s.text name="goods.order.log.info"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="log.list.operate.log.time"/></a>
					</th>
				</tr>
				<#list pager.result as log>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${log.id}" />
						</td>
						<td>
							${log.operation}
						</td>
						<td>
							${log.operator}
						</td>
						<td>
							${log.ip}
						</td>
						<td>
							${log.info}
						</td>
						<td>
							<span title="${log.createDate?string("yyyy-MM-dd HH:mm:ss")}">${log.createDate}</span>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="log!delete.action" value="<@s.text name="goods.specification.list.search.result.header.delete"/>" disabled hidefocus />
					</div>
					<div class="pager">
						<#include "/WEB-INF/template/admin/pager.ftl" />
					</div>
				<div>
			<#else>
				<div class="noRecord"><@s.text name="goods.specification.list.search.result.empty"/></div>
			</#if>
		</form>
	</div>
</body>
</html>