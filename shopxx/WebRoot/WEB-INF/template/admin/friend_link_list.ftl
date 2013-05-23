<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="friend.link.list.title"/> - Powered By SHOP++</title>
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
		<@s.text name="friend.link.list.manage"/>&nbsp;<@s.text name="goods.specification.list.page.tips1"/>: ${pager.totalCount} (<@s.text name="goods.specification.list.page.tips2"/>${pager.pageCount}<@s.text name="goods.specification.list.page.tips3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="friend_link!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='friend_link!add.action'" value="<@s.text name="friend.link.list.add"/>" hidefocus />
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
						<a href="#" class="sort" name="name" hidefocus><@s.text name="friend.link.list.name"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="url" hidefocus><@s.text name="friend.link.list.address"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="logoPath" hidefocus>LOGO</a>
					</th>
					<th>
						<a href="#" class="sort" name="orderList" hidefocus><@s.text name="goods.specification.list.search.result.header.order"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="comment.view.reply.time.add"/></a>
					</th>
					<th>
						<span><@s.text name="favorite.list.header.operation"/></span>
					</th>
				</tr>
				<#list pager.result as friendLink>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${friendLink.id}" />
						</td>
						<td>
							${friendLink.name}
						</td>
						<td>
							<#if (friendLink.url != "")!>
								<a href="${friendLink.url}" target="_blank">${friendLink.url}</a>
							</#if>
						</td>
						<td>
							<#if (friendLink.logoPath??)!>
								<a href="${base}${friendLink.logoPath}" target="_blank"><@s.text name="shipping.list.single.view"/></a>
							<#else>
								-
							</#if>
						</td>
						<td>
							${friendLink.orderList}
						</td>
						<td>
							<span title="${friendLink.createDate?string("yyyy-MM-dd HH:mm:ss")}">${friendLink.createDate}</span>
						</td>
						<td>
							<a href="friend_link!edit.action?id=${friendLink.id}" title="<@s.text name="goods.common.edit"/>">[<@s.text name="goods.common.edit"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="friend_link!delete.action" value="<@s.text name="goods.specification.list.search.result.header.delete"/>" disabled hidefocus />
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