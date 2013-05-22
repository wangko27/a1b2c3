<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="payment.list.pagetitle"/> - Powered By SHOP++</title>
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
		<@s.text name="payment.list.pagetitle"/>&nbsp;<@s.text name="payment.list.page.tips2"/>: ${pager.totalCount} (<@s.text name="payment.list.page.tips3"/>${pager.pageCount}<@s.text name="payment.list.page.tips4"/>)
	</div>
	<div class="body">
		<form id="listForm" action="payment!list.action" method="post">
			<div class="listBar">
				<label><@s.text name="common.search.title"/>: </label>
				<select name="pager.searchBy">
					<option value="paymentSn"<#if pager.searchBy == "paymentSn"> selected</#if>>
                        <@s.text name="payment.paymentSn"/>
					</option>
					<option value="bankName"<#if pager.searchBy == "bankName"> selected</#if>>
                        <@s.text name="payment.bankName"/>
					</option>
					<option value="bankAccount"<#if pager.searchBy == "bankAccount"> selected</#if>>
                        <@s.text name="payment.bankAccount"/>
					</option>
					<option value="payer"<#if pager.searchBy == "payer"> selected</#if>>
                        <@s.text name="payment.payer"/>
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
						<a href="#" class="sort" name="paymentSn" hidefocus><@s.text name="payment.paymentSn"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="paymentType" hidefocus><@s.text name="payment.paymentType"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="paymentConfigName" hidefocus><@s.text name="payment.paymentConfigName"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="totalAmount" hidefocus><@s.text name="payment.totalAmount"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="paymentFee" hidefocus><@s.text name="payment.paymentFee"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="payer" hidefocus><@s.text name="payment.payer"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="paymentStatus" hidefocus><@s.text name="payment.paymentStatus"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="payment.createDate"/></a>
					</th>
					<th>
						<span><@s.text name="common.button.operate"/></span>
					</th>
				</tr>
				<#list pager.result as payment>
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${payment.id}" />
						</td>
						<td>
							${payment.paymentSn}
						</td>
						<td>
							${action.getText("PaymentType." + payment.paymentType)}
						</td>
						<td>
							${payment.paymentConfigName}
						</td>
						<td>
							${payment.totalAmount?string(currencyFormat)}
						</td>
						<td>
							${payment.paymentFee?string(currencyFormat)}
						</td>
						<td>
							${payment.payer}
						</td>
						<td>
							${action.getText("PaymentStatus." + payment.paymentStatus)}
						</td>
						<td>
							<span title="${payment.createDate?string("yyyy-MM-dd HH:mm:ss")}">${payment.createDate}</span>
						</td>
						<td>
							<a href="payment!view.action?id=${payment.id}" title="<@s.text name="common.button.view"/>">[<@s.text name="common.button.view"/>]</a>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="payment!delete.action" value="<@s.text name="common.button.delete"/>" disabled hidefocus />
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