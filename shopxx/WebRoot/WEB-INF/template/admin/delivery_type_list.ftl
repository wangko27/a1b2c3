<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="delivery.type.list.title"/> - Powered By SHOP++</title>
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
		<@s.text name="delivery.type.list.manage"/>&nbsp;<@s.text name="goods.specification.list.page.tips1"/>: ${pager.totalCount} (<@s.text name="goods.specification.list.page.tips2"/>${pager.pageCount}<@s.text name="goods.specification.list.page.tips3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="delivery_type!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='delivery_type!add.action'" value="<@s.text name="payment.config.list.btnadd"/>" hidefocus />
			</div>
			<table id="listTable" class="listTable">
				<tr>
					<th class="check">
						<input type="checkbox" class="allCheck" />
					</th>
					<th>
						<a href="#" class="sort" name="name" hidefocus><@s.text name="delivery.type.list.name"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="deliveryMethod" hidefocus><@s.text name="delivery.type.list.type"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="firstWeightPrice" hidefocus><@s.text name="delivery.type.list.weightPrice"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="continueWeightPrice" hidefocus><@s.text name="delivery.type.list.continueweight"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="orderList" hidefocus><@s.text name="payment.config.order"/></a>
					</th>
					<th>
						<span><@s.text name="common.button.operate"/></span>
					</th>
				</tr>
				<#list pager.result as deliveryType>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${deliveryType.id}" />
						</td>
						<td>
							${deliveryType.name}
						</td>
						<td>
							${action.getText("DeliveryMethod." + deliveryType.deliveryMethod)}
						</td>
						<td>
							${deliveryType.firstWeightPrice}
						</td>
						<td>
							${deliveryType.continueWeightPrice}
						</td>
						<td>
							${deliveryType.orderList}
						</td>
						<td>
							<a href="delivery_type!edit.action?id=${deliveryType.id}" title="<@s.text name="common.button.edit"/>">[<@s.text name="common.button.edit"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="delivery_type!delete.action" value="<@s.text name="goods.specification.list.search.result.header.delete"/>" disabled hidefocus />
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