<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="shipping.list.pagetitle"/>- Powered By SHOP++</title>
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
		<@s.text name="shipping.list.pagetitle"/>&nbsp;<@s.text name="shipping.list.pager.title1"/>: ${pager.totalCount} (<@s.text name="shipping.list.pager.title2"/>${pager.pageCount}<@s.text name="shipping.list.pager.title3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="shipping!list.action" method="post">
			<div class="listBar">
				<label><@s.text name="goods.specification.list.search.label"/>: </label>
				<select name="pager.searchBy">
					<option value="shippingSn"<#if pager.searchBy == "shippingSn"> selected</#if>>
						<@s.text name="shipping.shippingSn"/>
					</option>
					<option value="deliverySn"<#if pager.searchBy == "deliverySn"> selected</#if>>
						<@s.text name="shipping.deliverySn"/>
					</option>
					<option value="shipName"<#if pager.searchBy == "shipName"> selected</#if>>
						<@s.text name="shipping.shipName"/>
					</option>
					<option value="shipAreaStore"<#if pager.searchBy == "shipAreaStore"> selected</#if>>
						<@s.text name="shipping.shipArea.displayName"/>
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
						<a href="#" class="sort" name="shippingSn" hidefocus><@s.text name="shipping.shippingSn"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="deliveryTypeName" hidefocus><@s.text name="shipping.deliveryTypeName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="deliveryCorpName" hidefocus><@s.text name="shipping.deliveryCorpName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="deliverySn" hidefocus><@s.text name="shipping.deliverySn"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="deliveryFee" hidefocus><@s.text name="shipping.deliveryFee"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="shipName" hidefocus><@s.text name="shipping.shipName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="shipAreaStore" hidefocus><@s.text name="shipping.shipArea.displayName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="shipping.createDate"/></a>
					</th>
					<th>
						<span><@s.text name="goods.specification.list.search.result.header.operation"/></span>
					</th>
				</tr>
				<#list pager.result as shipping>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${shipping.id}" />
						</td>
						<td>
							${shipping.shippingSn}
						</td>
						<td>
							${shipping.deliveryTypeName}
						</td>
						<td>
							${shipping.deliveryCorpName}
						</td>
						<td>
							${shipping.deliverySn}
						</td>
						<td>
							${shipping.deliveryFee?string(currencyFormat)}
						</td>
						<td>
							${shipping.shipName}
						</td>
						<td>
							${shipping.shipArea.displayName}
						</td>
						<td>
							<span title="${shipping.createDate?string("yyyy-MM-dd HH:mm:ss")}">${shipping.createDate}</span>
						</td>
						<td>
							<a href="shipping!view.action?id=${shipping.id}" title="<@s.text name="shipping.list.single.view"/>">[<@s.text name="shipping.list.single.view"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="shipping!delete.action" value="<@s.text name="goods.specification.list.search.result.header.delete"/>" disabled hidefocus />
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