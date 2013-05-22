<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="reship.list.pagetitle"/> - Powered By SHOP++</title>
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
		<@s.text name="reship.list.page.tips1"/>&nbsp;<@s.text name="reship.list.page.tips2"/>: ${pager.totalCount} (<@s.text name="reship.list.page.tips3"/>${pager.pageCount}<@s.text name="reship.list.page.tips4"/>)
	</div>
	<div class="body">
		<form id="listForm" action="reship!list.action" method="post">
			<div class="listBar">
				<label><@s.text name="common.search.title"/>: </label>
				<select name="pager.searchBy">
					<option value="reshipSn"<#if pager.searchBy == "reshipSn"> selected</#if>>
						<@s.text name="reship.reshipSn"/>
					</option>
					<option value="deliverySn"<#if pager.searchBy == "deliverySn"> selected</#if>>
                        <@s.text name="reship.deliverySn"/>
					</option>
					<option value="reshipName"<#if pager.searchBy == "reshipName"> selected</#if>>
                        <@s.text name="reship.reshipName"/>
					</option>
					<option value="reshipAreaStore"<#if pager.searchBy == "reshipAreaStore"> selected</#if>>
                        <@s.text name="reship.reshipArea.displayName"/>
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
						<a href="#" class="sort" name="reshipSn" hidefocus><@s.text name="reship.reshipSn"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="deliveryTypeName" hidefocus><@s.text name="reship.deliveryTypeName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="deliveryCorpName" hidefocus><@s.text name="reship.deliveryCorpName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="deliverySn" hidefocus><@s.text name="reship.deliverySn"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="deliveryFee" hidefocus><@s.text name="reship.deliveryFee"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="reshipName" hidefocus><@s.text name="reship.reshipName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="reshipAreaStore" hidefocus><@s.text name="reship.reshipArea.displayName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="reship.createDate"/></a>
					</th>
					<th>
						<span><@s.text name="common.button.operate"/></span>
					</th>
				</tr>
				<#list pager.result as reship>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${reship.id}" />
						</td>
						<td>
							${reship.reshipSn}
						</td>
						<td>
							${reship.deliveryTypeName}
						</td>
						<td>
							${reship.deliveryCorpName}
						</td>
						<td>
							${reship.deliverySn}
						</td>
						<td>
							${reship.deliveryFee?string(currencyFormat)}
						</td>
						<td>
							${reship.reshipName}
						</td>
						<td>
							${reship.reshipArea.displayName}
						</td>
						<td>
							<span title="${reship.createDate?string("yyyy-MM-dd HH:mm:ss")}">${reship.createDate}</span>
						</td>
						<td>
							<a href="reship!view.action?id=${reship.id}" title="<@s.text name="common.button.view"/>">[<@s.text name="common.button.view"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="reship!delete.action" value="<@s.text name="common.button.delete"/>" disabled hidefocus />
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