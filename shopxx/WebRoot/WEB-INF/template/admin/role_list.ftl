<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="role.list.pagetitle"/> - Powered By SHOP++</title>
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
		<@s.text name="role.list.page.tips1"/>&nbsp;<@s.text name="role.list.page.tips2"/>: ${pager.totalCount} (<@s.text name="role.list.page.tips3"/>${pager.pageCount}<@s.text name="role.list.page.tips4"/>)
	</div>
	<div class="body">
		<form id="listForm" action="role!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='role!add.action'" value="<@s.text name="role.list.button.add"/>" hidefocus />
				&nbsp;&nbsp;
				<label><@s.text name="role.list.search.label"/>: </label>
				<select name="pager.searchBy">
					<option value="name"<#if pager.searchBy == "name"> selected</#if>>
						<@s.text name="role.list.search.option"/>
					</option>
				</select>
				<input type="text" name="pager.keyword" value="${pager.keyword!}" />
				<input type="button" id="searchButton" class="formButton" value="<@s.text name="role.list.search.button"/>" hidefocus />
				&nbsp;&nbsp;
				<label><@s.text name="role.list.search.page.head"/>: </label>
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
						<a href="#" class="sort" name="name" hidefocus><@s.text name="role.name"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="isSystem" hidefocus><@s.text name="role.system"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="description" hidefocus><@s.text name="role.description"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="role.createDate"/></a>
					</th>
					<th>
						<span><@s.text name="common.button.operate"/></span>
					</th>
				</tr>
				<#list pager.result as role>
					<tr>
						<td>
							<input type="checkbox"<#if role.isSystem> disabled title="<@s.text name="role.delete.title"/>"<#else> name="ids" value="${role.id}"</#if> />
						</td>
						<td>
							${role.name}
						</td>
						<td>
							<span class="${role.isSystem?string('true','false')}Icon">&nbsp;</span>
						</td>
						<td>
							${role.description}
						</td>
						<td>
							<span title="${role.createDate?string("yyyy-MM-dd HH:mm:ss")}">
								${role.createDate}
							</span>
						</td>
						<td>
							<a href="role!edit.action?id=${role.id}" title="<@s.text name="common.button.edit"/>">[<@s.text name="common.button.edit"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="role!delete.action" value="<@s.text name="common.button.delete"/>" disabled hidefocus />
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