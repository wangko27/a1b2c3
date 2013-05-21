<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="goods.specification.list.pagetitle"/> - Powered By SHOP++</title>
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
		<@s.text name="goods.specification.list.pagetitle"/>&nbsp;<span class="pageInfo"><@s.text name="goods.specification.list.page.tips1"/>: ${pager.totalCount} (<@s.text name="goods.specification.list.page.tips2"/>${pager.pageCount}<@s.text name="goods.specification.list.page.tips3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="specification!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='specification!add.action'" value="添加规格" hidefocus />
				&nbsp;&nbsp;
				<label><@s.text name="goods.specification.list.search.label"/>: </label>
				<select name="pager.searchBy">
					<option value="name"<#if pager.searchBy == "name"> selected</#if>>
						<@s.text name="goods.specification.list.search.option1"/>
					</option>
					<option value="memo"<#if pager.searchBy == "memo"> selected</#if>>
						<@s.text name="goods.specification.list.search.option2"/>
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
						<a href="#" class="sort" name="name" hidefocus><@s.text name="goods.specification.list.search.result.header.name"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="specificationType" hidefocus><@s.text name="goods.specification.list.search.result.header.type"/></a>
					</th>
					<th>
						<span><@s.text name="goods.specification.list.search.result.header.value"/></span>
					</th>
					<th>
						<span><@s.text name="goods.specification.list.search.result.header.order"/></span>
					</th>
					<th>
						<span><@s.text name="goods.specification.list.search.result.header.operation"/></span>
					</th>
				</tr>
				<#list pager.result as specification>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${specification.id}" />
						</td>
						<td>
							${specification.name}
							<#if specification.memo??>
								<span class="gray">[${specification.memo}]</span>
							</#if>
						</td>
						<td>
							${action.getText("SpecificationType." + specification.specificationType)}
						</td>
						<td>
							<#list specification.specificationValueList as specificationValue>
								${specificationValue.name}
								<#if (specificationValue_index > 10)>
									<#break />
								</#if>
							</#list>
						</td>
						<td>
							${specification.orderList}
						</td>
						<td>
							<a href="specification!edit.action?id=${specification.id}" title="<@s.text name="goods.specification.list.search.result.header.edit"/>">[<@s.text name="goods.specification.list.search.result.header.edit"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="specification!delete.action" value="<@s.text name="goods.specification.list.search.result.header.delete"/>" disabled hidefocus />
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