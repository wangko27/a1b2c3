<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="member.attribute.input.list.pagetitle"/> - Powered By SHOP++</title>
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
		<@s.text name="member.attribute.input.list.pagetitle"/>&nbsp;<@s.text name="common.list.page.title1"/>: ${pager.totalCount} (<@s.text name="common.list.page.title2"/>${pager.pageCount}<@s.text name="common.list.page.title3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="member_attribute!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='member_attribute!add.action'" value="<@s.text name="memberAttribute.list.button.add"/>" hidefocus />
			</div>
			<table id="listTable" class="listTable">
				<tr>
					<th class="check">
						<input type="checkbox" class="allCheck" />
					</th>
					<th>
						<a href="#" class="sort" name="name" hidefocus><@s.text name="memberAttribute.name"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="attributeType" hidefocus><@s.text name="memberAttribute.type"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="isRequired" hidefocus><@s.text name="memberAttribute.isRequired"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="isEnabled" hidefocus><@s.text name="memberAttribute.isEnabled"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="orderList" hidefocus><@s.text name="memberAttribute.orderList"/></a>
					</th>
					<th>
						<span><@s.text name="common.button.operate"/></span>
					</th>
				</tr>
				<#list pager.result as memberAttribute>
					<tr>
						<td>
							<input type="checkbox"<#if memberAttribute.systemAttributeType??> disabled title="<@s.text name="memberAttribute.systemAttributeType.title"/>"<#else> name="ids" value="${memberAttribute.id}"</#if> />
						</td>
						<td>
							${memberAttribute.name}
						</td>
						<td>
							<#if memberAttribute.systemAttributeType??>
								${action.getText("SystemAttributeType." + memberAttribute.systemAttributeType)}
								[<@s.text name="memberAttribute.systemAttributeType.default"/>]
							<#else>
								${action.getText("AttributeType." + memberAttribute.attributeType)}
							</#if>
						</td>
						<td>
							<span class="${memberAttribute.isRequired?string('true','false')}Icon">&nbsp;</span>
						</td>
						<td>
							<span class="${memberAttribute.isEnabled?string('true','false')}Icon">&nbsp;</span>
						</td>
						<td>
							${memberAttribute.orderList}
						</td>
						<td>
							<a href="member_attribute!edit.action?id=${memberAttribute.id}" title="<@s.text name="common.button.edit"/>">[<@s.text name="common.button.edit"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="member_attribute!delete.action" value="<@s.text name="common.button.delete"/>" disabled hidefocus />
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