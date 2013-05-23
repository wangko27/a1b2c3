<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="comment.list.title"/> - Powered By SHOP++</title>
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
		<@s.text name="comment.list.title"/>&nbsp;<@s.text name="goods.specification.list.page.tips1"/>: ${pager.totalCount} (<@s.text name="goods.specification.list.page.tips2"/>${pager.pageCount}<@s.text name="goods.specification.list.page.tips3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="comment!list.action" method="post">
			<div class="listBar">
				<select name="pager.searchBy">
					<option value="username"<#if pager.searchBy == "username"> selected</#if>>
						<@s.text name="comment.list.comment.username"/>
					</option>
					<option value="content"<#if pager.searchBy == "content"> selected</#if>>
						<@s.text name="goods.message.context"/>
					</option>
					<option value="contact"<#if pager.searchBy == "contact"> selected</#if>>
						<@s.text name="comment.new.title.contact"/>
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
						<a href="#" class="sort" name="username" hidefocus><@s.text name="comment.list.comment.username"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="goods" hidefocus><@s.text name="comment.list.comment.goods"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="isShow" hidefocus><@s.text name="comment.list.comment.show"/></a>
					</th>
					<th>
						<span><@s.text name="comment.list.comment.replyed"/></span>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="comment.list.comment.date"/></a>
					</th>
					<th>
						<span><@s.text name="favorite.list.header.operation"/></span>
					</th>
				</tr>
				<#list pager.result as comment>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${comment.id}" />
						</td>
						<td>
							${(comment.username)!"<@s.text name="goods.content.bottom.comment.guest"/>"}
						</td>
						<td>
							<#assign goods = comment.goods />
							<a href="${base}${goods.htmlPath}" title="${goods.name}" target="_blank">
								${substring(goods.name, 60, "...")}
							</a>
						</td>
						<td>
							<span class="${comment.isShow?string('true','false')}Icon">&nbsp;</span>
						</td>
						<td>
							<#if (comment.replyCommentSet?? && comment.replyCommentSet?size > 0)>
								<span class="trueIcon">&nbsp;</span>
							<#else>
								<span class="falseIcon">&nbsp;</span>
							</#if>
						</td>
						<td>
							<span title="${comment.createDate?string("yyyy-MM-dd HH:mm:ss")}">${comment.createDate}</span>
						</td>
						<td>
							<a href="comment!view.action?id=${comment.id}" title="<@s.text name="shipping.list.single.view"/>/<@s.text name="goods.common.reply"/>">[<@s.text name="shipping.list.single.view"/>/<@s.text name="goods.common.reply"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="comment!delete.action" value="<@s.text name="goods.specification.list.search.result.header.delete"/>" disabled hidefocus />
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