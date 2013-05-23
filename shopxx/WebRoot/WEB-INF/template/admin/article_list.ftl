<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="article.list.title"/> - Powered By SHOP++</title>
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
		<@s.text name="article.list.title"/>&nbsp;<@s.text name="goods.specification.list.page.tips1"/>: ${pager.totalCount} (<@s.text name="goods.specification.list.page.tips2"/>${pager.pageCount}<@s.text name="goods.specification.list.page.tips3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="article!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='article!add.action'" value="<@s.text name="article.input.add"/>" hidefocus />
				&nbsp;&nbsp;
				<label><@s.text name="goods.specification.list.search.label"/>: </label>
				<select name="pager.searchBy">
					<option value="title"<#if pager.searchBy == "title"> selected</#if>>
						<@s.text name="goods.message.push.title"/>
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
						<a href="#" class="sort" name="title" hidefocus><@s.text name="goods.message.push.title"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="articleCategory" hidefocus><@s.text name="admin.category"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="isPublication" hidefocus><@s.text name="comment.view.reply.whether.publish"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="isRecommend" hidefocus><@s.text name="comment.view.reply.whether.recommend"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="comment.view.reply.time.add"/></a>
					</th>
					<th>
						<span><@s.text name="goods.notify.memberCenter.goods.operation"/></span>
					</th>
				</tr>
				<#list pager.result as article>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${article.id}" />
						</td>
						<td>
							<span title="${article.title}">
								${substring(article.title, 30, "...")}
							</span>
						</td>
						<td>
							${article.articleCategory.name}
						</td>
						<td>
							<span class="${article.isPublication?string('true','false')}Icon">&nbsp;</span>
						</td>
						<td>
							<span class="${article.isRecommend?string('true','false')}Icon">&nbsp;</span>
						</td>
						<td>
							<span title="${article.createDate?string("yyyy-MM-dd HH:mm:ss")}">${article.createDate}</span>
						</td>
						<td>
							<a href="article!edit.action?id=${article.id}" title="<@s.text name="goods.specification.list.search.result.header.edit"/>">[<@s.text name="goods.specification.list.search.result.header.edit"/>]</a>
							<#if article.isPublication>
								<a href="${base}${article.htmlPath}" target="_blank" title="<@s.text name="article.category.list.browse"/>">[<@s.text name="article.category.list.browse"/>]</a>
							<#else>
								<span title="<@s.text name="comment.view.reply.unpublished"/>">[<@s.text name="comment.view.reply.unpublished"/>]</span>
							</#if>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="article!delete.action" value="<@s.text name="goods.specification.list.search.result.header.delete"/>" disabled hidefocus />
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