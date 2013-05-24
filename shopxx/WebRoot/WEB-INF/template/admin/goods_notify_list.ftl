<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="goods.notify.list.msg.title"/> - Powered By SHOP++</title>
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

	var $sendButton = $("#sendButton");
	var $allCheck = $("#listTable input.allCheck");// 全选复选框
	var $idsCheck = $("#listTable input[name='ids']");// ID复选框
	
	// 无复选框被选中时,发送按钮不可用
	$idsCheck.click( function() {
		var $idsChecked = $("#listTable input[name='ids']:checked");
		if ($idsChecked.size() > 0) {
			$sendButton.attr("disabled", false);
		} else {
			$sendButton.attr("disabled", true)
		}
	});
	
	// 全选
	$allCheck.click( function() {
		if ($(this).attr("checked") == true) {
			$idsCheck.attr("checked", true);
			$sendButton.attr("disabled", false);
		} else {
			$idsCheck.attr("checked", false);
			$sendButton.attr("disabled", true);
		}
	});
	
	// 发送通知
	$sendButton.click( function() {
		var url = "goods_notify!send.action";
		var $idsCheckedCheck = $("#listTable input[name='ids']:checked");
		if (confirm("<@s.text name="goods.notify.list.msg.notice"/>?") == true) {
			$.ajax({
				url: url,
				data: $idsCheckedCheck.serialize(),
				type: "POST",
				dataType: "json",
				cache: false,
				success: function(data) {
					if (data.status == "success") {
						$idsCheckedCheck.parent().parent().find(".isSent").attr("src", "${base}/template/admin/images/list_true_icon.gif");
					}
					$sendButton.attr("disabled", true);
					$allCheck.attr("checked", false);
					$idsCheckedCheck.attr("checked", false);
					$.message({type: data.status, content: data.message});
				}
			});
		}
	});

})
</script>
</head>
<body class="list">
	<div class="bar">
		<@s.text name="goods.notify.list.msg.title"/>&nbsp;<@s.text name="goods.specification.list.page.tips1"/>: ${pager.totalCount} (<@s.text name="goods.specification.list.page.tips2"/>${pager.pageCount}<@s.text name="goods.specification.list.page.tips3"/>)
	</div>
	<div class="body">
		<form id="listForm" action="goods_notify!list.action" method="post">
			<div class="listBar">
				<input type="button" id="sendButton" class="formButton" value="<@s.text name="goods.notify.list.msg.notice.send"/>" disabled />
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
						<a href="#" class="sort" name="product" hidefocus><@s.text name="goods.notify.list.msg.product.out"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="member" hidefocus><@s.text name="goods.notify.list.msg.member"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="email" hidefocus>E-mail</a>
					</th>
					<th>
						<a href="#" class="sort" name="sendDate" hidefocus><@s.text name="goods.notify.list.msg.notice.time"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="createDate" hidefocus><@s.text name="goods.notify.list.msg.send.time"/></a>
					</th>
					<th>
						<a href="#" class="sort" name="isSent" hidefocus><@s.text name="goods.notify.list.msg.sent"/></a>
					</th>
					<th>
						<span><@s.text name="goods.notify.list.msg.status.out"/></span>
					</th>
				</tr>
				<#list pager.result as goodsNotify>
					<#assign product = goodsNotify.product />
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${goodsNotify.id}" />
						</td>
						<td>
							<a href="${base}${product.goods.htmlPath}" target="_blank">
								${product.name}
							</a>
						</td>
						<td>
							${(goodsNotify.member.username)!"-"}
						</td>
						<td>
							${goodsNotify.email}
						</td>
						<td>
							<#if goodsNotify.sendDate??>
								<span title="${goodsNotify.sendDate?string("yyyy-MM-dd HH:mm:ss")}">${goodsNotify.sendDate}</span>
							<#else>
								-
							</#if>
						</td>
						<td>
							<span title="${goodsNotify.createDate?string("yyyy-MM-dd HH:mm:ss")}">
								${goodsNotify.createDate}
							</span>
						</td>
						<td>
							<span class="${goodsNotify.isSent?string('true','false')}Icon">&nbsp;</span>
						</td>
						<td>
							<#if product.isOutOfStock>
								<@s.text name="goods.notify.list.msg.product.notExist"/>
							<#else>
								<@s.text name="goods.notify.list.msg.product.exist"/>
							</#if>
						</td>
					</tr>
				</#list>
			</table>
			<#if (pager.result?size > 0)>
				<div class="pagerBar">
					<div class="delete">
						<input type="button" id="deleteButton" class="formButton" url="goods_notify!delete.action" value="<@s.text name="goods.specification.list.search.result.header.delete"/>" disabled hidefocus />
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