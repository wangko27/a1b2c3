<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="refund.list.pagetitle"/> - Powered By SHOP++</title>
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
		<@s.text name="refund.list.page.tips1"/>&nbsp;<@s.text name="refund.list.page.tips2"/>: ${pager.totalCount} (<@s.text name="refund.list.page.tips3"/>${pager.pageCount}<@s.text name="refund.list.page.tips4"/>)
	</div>
	<div class="body">
		<form id="listForm" action="refund!list.action" method="post">
			<div class="listBar">
				<label><@s.text name="common.search.title"/>: </label>
				<select name="pager.searchBy">
					<option value="refundSn"<#if pager.searchBy == "refundSn"> selected</#if>>
                        <@s.text name="refund.refundSn"/>
					</option>
					<option value="bankName"<#if pager.searchBy == "bankName"> selected</#if>>
                        <@s.text name="refund.bankName"/>
					</option>
					<option value="bankAccount"<#if pager.searchBy == "bankAccount"> selected</#if>>
                        <@s.text name="refund.bankAccount"/>
					</option>
					<option value="payee"<#if pager.searchBy == "payee"> selected</#if>>
                        <@s.text name="refund.payee"/>
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
						<a href="#" class="sort" name="refundSn" hidefocus><@s.text name="refund.refundSn"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="refundType" hidefocus><@s.text name="refund.refundType"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="paymentConfigName" hidefocus><@s.text name="refund.paymentConfigName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="totalAmount" hidefocus><@s.text name="refund.totalAmount"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="payee" hidefocus><@s.text name="refund.payee"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="refund.createDate"/></a>
					</th>
					<th>
						<span><@s.text name="common.button.operate"/></span>
					</th>
				</tr>
				<#list pager.result as refund>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${refund.id}" />
						</td>
						<td>
							${refund.refundSn}
						</td>
						<td>
							${action.getText("RefundType." + refund.refundType)}
						</td>
						<td>
							${refund.paymentConfigName}
						</td>
						<td>
							${refund.totalAmount?string(currencyFormat)}
						</td>
						<td>
							${refund.payee}
						</td>
						<td>
							<span title="${refund.createDate?string("yyyy-MM-dd HH:mm:ss")}">${refund.createDate}</span>
						</td>
						<td>
							<a href="refund!view.action?id=${refund.id}" title="@s.text name="common.button.view"/>">[@s.text name="common.button.view"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="refund!delete.action" value="<@s.text name="common.button.delete"/>" disabled hidefocus />
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