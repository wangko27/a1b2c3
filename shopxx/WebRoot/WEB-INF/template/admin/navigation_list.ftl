<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="navigation.list.pagetitle"/>- Powered By SHOP++</title>
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
		<@s.text name="navigation.list.pagetitle"/>&nbsp;<@s.text name="common.list.page.title1"/>: ${pager.totalCount} (<@s.text name="common.list.page.title2"/>${pager.pageCount}<@s.text name="common.list.page.title3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="navigation!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='navigation!add.action'" value="<@s.text name="navigation.button.add"/>" hidefocus />
				&nbsp;&nbsp;
				<label><@s.text name="common.search.title"/>: </label>
				<select name="pager.searchBy">
					<option value="name"<#if pager.searchBy == "name"> selected</#if>>
						<@s.text name="navigation.name"/>
					</option>
				</select>
				<input type="text" name="pager.keyword" value="${pager.keyword!}" />
				<input type="button" id="searchButton" class="formButton" value="<@s.text name="common.search.button"/>" hidefocus />
				&nbsp;&nbsp;
				<label><@s.text name="common.search.tips"/>: </label>
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
						<span><@s.text name="navigation.name"/></span>
					</th>
					<th>
						<span><@s.text name="navigation.navigationPosition"/></span>
					</th>
					<th>
						<span><@s.text name="navigation.isVisible"/></span>
					</th>
					<th>
						<span><@s.text name="navigation.isBlankTarget"/></span>
					</th>
					<th>
						<span><@s.text name="navigation.orderList"/></span>
					</th>
					<th>
						<span><@s.text name="common.button.operate"/></span>
					</th>
				</tr>
				<#list pager.result as navigation>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${navigation.id}" />
						</td>
						<td>
							${navigation.name}
						</td>
						<td>
							${action.getText("NavigationPosition." + navigation.navigationPosition)}
						</td>
						<td>
							<span class="${navigation.isVisible?string('true','false')}Icon">&nbsp;</span>
						</td>
						<td>
							<span class="${navigation.isBlankTarget?string('true','false')}Icon">&nbsp;</span>
						</td>
						<td>
							${navigation.orderList}
						</td>
						<td>
							<a href="navigation!edit.action?id=${navigation.id}" title="<@s.text name="common.button.edit"/>">[<@s.text name="common.button.edit"/>]</a>
						</td>
					</tr>
					<#if navigation_has_next>
						<#if pager.result[navigation_index + 1].navigationPosition != navigation.navigationPosition>
							<tr>
								<td colspan="7">&nbsp;</td>
							</tr>
						</#if>
					</#if>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="navigation!delete.action" value="<@s.text name="common.button.delete"/>" disabled hidefocus />
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