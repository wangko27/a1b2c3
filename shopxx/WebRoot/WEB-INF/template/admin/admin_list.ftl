<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="admin.list"/> - Powered By SHOP++</title>
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
		<@s.text name="admin.list"/>&nbsp;<@s.text name="goods.specification.list.page.tips1"/>: ${pager.totalCount} (<@s.text name="goods.specification.list.page.tips2"/>${pager.pageCount}<@s.text name="goods.specification.list.page.tips3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="admin!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='admin!add.action'" value="<@s.text name="admin.list.add"/>" hidefocus />
				&nbsp;&nbsp;
				<select name="pager.searchBy">
					<option value="username"<#if pager.searchBy == "username"> selected</#if>>
						<@s.text name="member.username"/>
					</option>
					<option value="name"<#if pager.searchBy == "name"> selected</#if>>
						<@s.text name="admin.list.name"/>
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
						<a href="#" class="sort" name="username" hidefocus><@s.text name="member.username"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="email" hidefocus>E-mail</a>
					</th>
					<th>
						<a href="#" class="sort" name="name" hidefocus><@s.text name="admin.list.name"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="department" hidefocus><@s.text name="admin.list.department"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="loginDate" hidefocus><@s.text name="admin.list.lastLoginTime"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="loginIp" hidefocus><@s.text name="member.loginIp"/></a>
					</th>
					<th>
						<span><@s.text name="admin.list.status"/></span>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="role.createDate"/></a>
					</th>
					<th>
						<span><@s.text name="common.button.operate"/></span>
					</th>
				</tr>
				<#list pager.result as admin>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${admin.id}" />
						</td>
						<td>
							${admin.username}
						</td>
						<td>
							${admin.email}
						</td>
						<td>
							${(admin.name)!}
						</td>
						<td>
							${(admin.department)!}
						</td>
						<td>
							<#if admin.loginDate??>
								<span title="${admin.loginDate?string("yyyy-MM-dd HH:mm:ss")}">${admin.loginDate}</span>
							<#else>
								&nbsp;
							</#if>
						</td>
						<td>
							${(admin.loginIp)!}
						</td>
						<td>
							<#if admin.isAccountEnabled && !admin.isAccountLocked && !admin.isAccountExpired && !admin.isCredentialsExpired>
								<span class="green"><@s.text name="admin.list.status.ok"/></span>
							<#elseif !admin.isAccountEnabled>
								<span class="red"> <@s.text name="admin.list.status.enabled"/> </span>
							<#elseif admin.isAccountLocked>
								<span class="red"> <@s.text name="admin.list.status.locked"/> </span>
							<#elseif admin.isAccountExpired>
								<span class="red"> <@s.text name="admin.list.status.expired"/> </span>
							<#elseif admin.isCredentialsExpired>
								<span class="red"> <@s.text name="admin.list.status.credentialsExpired"/> </span>
							</#if>
						</td>
						<td>
							<span title="${admin.createDate?string("yyyy-MM-dd HH:mm:ss")}">${admin.createDate}</span>
						</td>
						<td>
							<a href="admin!edit.action?id=${admin.id}" title="<@s.text name="goods.specification.list.search.result.header.edit"/>">[<@s.text name="goods.specification.list.search.result.header.edit"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="admin!delete.action" value="<@s.text name="goods.specification.list.search.result.header.delete"/>" disabled hidefocus />
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