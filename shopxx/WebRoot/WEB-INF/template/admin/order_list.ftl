<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="order.list.pagetitle"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.pager.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $print = $("#listForm .print");
	
	// 打印选择
	$print.change( function() {
		var $this = $(this);
		
		if ($this.val() != "") {
			window.open($this.val());
		}
	});

})
</script>
</head>
<body class="list">
	<div class="bar">
		<@s.text name="order.list.pagetitle"/>&nbsp;<@s.text name="common.list.page.title1"/>: ${pager.totalCount} (<@s.text name="common.list.page.title2"/>${pager.pageCount}<@s.text name="common.list.page.title3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="order!list.action" method="post">
			<div class="listBar">
				<label><@s.text name="common.search.title"/>: </label>
				<select name="pager.searchBy">
					<option value="orderSn"<#if pager.searchBy == "orderSn"> selected</#if>>
						<@s.text name="order.orderSn"/>
					</option>
					<option value="member.username"<#if pager.searchBy == "member.username"> selected</#if>>
						<@s.text name="member.username"/>
					</option>
					<option value="shipName"<#if pager.searchBy == "shipName"> selected</#if>>
						<@s.text name="order.shipName"/>
					</option>
					<option value="shipAddress"<#if pager.searchBy == "shipAddress"> selected</#if>>
						<@s.text name="order.shipAddress"/>
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
						<a href="#" class="sort" name="orderSn" hidefocus><@s.text name="order.orderSn"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="member" hidefocus><@s.text name="member.username"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="totalAmount" hidefocus><@s.text name="order.totalAmount"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="paymentStatus" hidefocus><@s.text name="order.paymentStatus"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="shippingStatus" hidefocus><@s.text name="order.shippingStatus"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="paymentConfigName" hidefocus><@s.text name="order.paymentConfigName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="deliveryTypeName" hidefocus><@s.text name="order.deliveryTypeName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="order.createDate"/></a>
					</th>
					<th>
						<span><@s.text name="common.button.print"/></span>
					</th>
					<th>
						<span><@s.text name="common.button.operate"/></span>
					</th>
				</tr>
				<#list pager.result as order>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${order.id}" />
						</td>
						<td>
							${order.orderSn}
						</td>
						<td>
							${(order.member.username)!"-"}
						</td>
						<td>
							${order.totalAmount?string(currencyFormat)}
						</td>
						<td>
							${action.getText("PaymentStatus." + order.paymentStatus)}
						</td>
						<td>
							${action.getText("ShippingStatus." + order.shippingStatus)}
						</td>
						<td>
							${order.paymentConfigName}
						</td>
						<td>
							${order.deliveryTypeName}
						</td>
						<td>
							<span title="${order.createDate?string("yyyy-MM-dd HH:mm:ss")}">${order.createDate}</span>
						</td>
						<td>
							<select class="print">
								<option value="">
                                    <@s.text name="goods.content.buyInfo.tipsTitle"/>
								</option>
								<option value="order!orderPrint.action?id=${order.id}">
									<@s.text name="order.orderPrint"/>
								</option>
								<option value="order!goodsPrint.action?id=${order.id}">
									<@s.text name="order.goodsPrint"/>
								</option>
								<option value="order!shippingPrint.action?id=${order.id}">
									<@s.text name="order.shippingPrint"/>
								</option>
								<option value="order!deliveryPrint.action?id=${order.id}">
									<@s.text name="order.deliveryPrint"/>
								</option>
							</select>
						</td>
						<td>
							<a href="order!view.action?id=${order.id}" title="<@s.text name="common.button.view"/>">[<@s.text name="common.button.view"/>]</a>
							<#if order.orderStatus != "completed" && order.orderStatus != "invalid" && order.paymentStatus == "unpaid" && order.shippingStatus == "unshipped">
								<a href="order!edit.action?id=${order.id}" title="<@s.text name="common.button.edit"/>">[<@s.text name="common.button.edit"/>]</a>
							<#else>
								<span title="<@s.text name="common.button.edit.error"/>">[<@s.text name="common.button.edit"/>]</span>
							</#if>
							<a href="order!process.action?id=${order.id}" title="<@s.text name="common.button.handle"/>">[<@s.text name="common.button.handle"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="order!delete.action" value="<@s.text name="common.button.delete"/>" disabled hidefocus />
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