<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="instance.messaging.input.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $validateForm = $("#validateForm");

	var $addQqButton = $("#addQqButton");
	var $addMsnButton = $("#addMsnButton");
	var $addWangwangButton = $("#addWangwangButton");
	var $addSkypeButton = $("#addSkypeButton");
	var $instantMessagingTable = $("#instantMessagingTable");

	var instantMessagingIndex = ${(instantMessagingList?size)!"0"};

	// 增加QQ在线客服
	$addQqButton.click( function() {
		
		<@compress single_line = true>
			var instantMessagingTrHtml = 
			'<tr>
				<th>&nbsp;</th>
				<td>
					<input type="hidden" name="instantMessagingList[' + instantMessagingIndex + '].instantMessagingType" value="qq" />
					<span class="instantMessagingType">QQ: </span>&nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].value" class="formText instantMessagingListValue" />
					&nbsp;&nbsp;<@s.text name="goods.message.push.title"/>: &nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].title" class="formText instantMessagingListTitle" />
					&nbsp;&nbsp;<@s.text name="goods.specification.list.search.result.header.order"/>: &nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].orderList" class="formText instantMessagingListOrderList" style="width: 30px;" />
					&nbsp;&nbsp;
					<span class="deleteIcon deleteInstantMessagingIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
				</td>
			</tr>';
		</@compress>
		
		$instantMessagingTable.append(instantMessagingTrHtml);
		instantMessagingIndex ++;
	});
	
	// 增加MSN在线客服
	$addMsnButton.click( function() {
		
		<@compress single_line = true>
			var instantMessagingTrHtml = 
			'<tr>
				<th>&nbsp;</th>
				<td>
					<input type="hidden" name="instantMessagingList[' + instantMessagingIndex + '].instantMessagingType" value="msn" />
					<span class="instantMessagingType">MSN: </span>&nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].value" class="formText instantMessagingListValue" />
					&nbsp;&nbsp;<@s.text name="goods.message.push.title"/>: &nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].title" class="formText instantMessagingListTitle" />
					&nbsp;&nbsp;<@s.text name="goods.specification.list.search.result.header.order"/>: &nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].orderList" class="formText instantMessagingListOrderList" style="width: 30px;" />
					&nbsp;&nbsp;
					<span class="deleteIcon deleteInstantMessagingIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
				</td>
			</tr>';
		</@compress>
		
		$instantMessagingTable.append(instantMessagingTrHtml);
		instantMessagingIndex ++;
	});
	
	// 增加旺旺在线客服
	$addWangwangButton.click( function() {
	
		<@compress single_line = true>
			var instantMessagingTrHtml = 
			'<tr>
				<th>&nbsp;</th>
				<td>
					<input type="hidden" name="instantMessagingList[' + instantMessagingIndex + '].instantMessagingType" value="wangwang" />
					<span class="instantMessagingType"><@s.text name="goods.common.chart.wangwang"/>: </span>&nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].value" class="formText instantMessagingListValue" />
					&nbsp;&nbsp;<@s.text name="goods.message.push.title"/>: &nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].title" class="formText instantMessagingListTitle" />
					&nbsp;&nbsp;<@s.text name="goods.specification.list.search.result.header.order"/>: &nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].orderList" class="formText instantMessagingListOrderList" style="width: 30px;" />
					&nbsp;&nbsp;
					<span class="deleteIcon deleteInstantMessagingIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
				</td>
			</tr>';
		</@compress>
		
		$instantMessagingTable.append(instantMessagingTrHtml);
		instantMessagingIndex ++;
	});
	
	// 增加Skype在线客服
	$addSkypeButton.click( function() {
		
		<@compress single_line = true>
			var instantMessagingTrHtml = 
			'<tr>
				<th>&nbsp;</th>
				<td>
					<input type="hidden" name="instantMessagingList[' + instantMessagingIndex + '].instantMessagingType" value="skype" />
					<span class="instantMessagingType">Skype: </span>&nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].value" class="formText instantMessagingListValue" />
					&nbsp;&nbsp;<@s.text name="goods.message.push.title"/>: &nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].title" class="formText instantMessagingListTitle" />
					&nbsp;&nbsp;<@s.text name="goods.specification.list.search.result.header.order"/>: &nbsp;
					<input type="text" name="instantMessagingList[' + instantMessagingIndex + '].orderList" class="formText instantMessagingListOrderList" style="width: 30px;" />
					&nbsp;&nbsp;
					<span class="deleteIcon deleteInstantMessagingIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
				</td>
			</tr>';
		</@compress>
		
		$instantMessagingTable.append(instantMessagingTrHtml);
		instantMessagingIndex ++;
	});
	
	// 删除在线客服
	$("#instantMessagingTable .deleteInstantMessagingIcon").live("click", function() {
		var $this = $(this);
		$.dialog({type: "warn", content: "<@s.text name="goods.notify.javascript.deleteNotice"/>?", ok: "<@s.text name="goods.common.ok"/>", cancel: "<@s.text name="goods.common.cancel"/>", modal: true, okCallback: deleteInstantMessaging});
		function deleteInstantMessaging() {
			$this.parent().parent().remove();
		}
	});
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"instantMessagingTitle": {
				required: true
			}
		},
		messages: {
			"instantMessagingTitle": {
				required: "<@s.text name="instance.messaging.input"/>"
			}
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
	$.validator.addMethod("instantMessagingListValueRequired", $.validator.methods.required, "<@s.text name="instance.messaging.input.account"/>");
	$.validator.addMethod("instantMessagingListTitleRequired", $.validator.methods.required, "<@s.text name="instance.messaging.input.accountTitle"/>");
	$.validator.addMethod("instantMessagingListOrderListDigits", $.validator.methods.digits, "<@s.text name="goods.specification.edit.order.tips"/>");
	
	$.validator.addClassRules("instantMessagingListValue", {
		instantMessagingListValueRequired: true
	});
	$.validator.addClassRules("instantMessagingListTitle", {
		instantMessagingListTitleRequired: true
	});
	$.validator.addClassRules("instantMessagingListOrderList", {
		instantMessagingListOrderListDigits: true
	});

});
</script>
</head>
<body class="input instantMessaging">
	<div class="bar">
		<@s.text name="instance.messaging.input.title"/>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="deposit.recharge.input.error"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="instant_messaging!update.action" method="post">
			<table id="instantMessagingTable" class="inputTable">
				<tr>
					<th>
						<@s.text name="instance.messaging.title"/>: 
					</th>
					<td>
						<input type="text" name="instantMessagingTitle" class="formText" value="${(setting.instantMessagingTitle)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="instance.messaging.location"/>: 
					</th>
					<td>
						<#list instantMessagingPositionList as instantMessagingPosition>
							<label>
								<input type="radio" name="instantMessagingPosition" value="${instantMessagingPosition}"<#if (instantMessagingPosition == setting.instantMessagingPosition)!> checked</#if> />
								${action.getText("InstantMessagingPosition." + instantMessagingPosition)}
							</label>
						</#list>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="goods.common.setting"/>: 
					</th>
					<td>
						<label>
							<@checkbox name="isInstantMessagingEnabled" value="${setting.isInstantMessagingEnabled}" /><@s.text name="setting.isGzipEnabled"/>
						</label>
					</td>
				</tr>
				<tr>
					<th>
						&nbsp;
					</th>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="instance.messaging.title.add"/>
					</th>
					<td>
						<input type="button" id="addQqButton" class="formButton" value="<@s.text name="common.button.add"/>QQ" hidefocus />&nbsp;&nbsp;
						<input type="button" id="addMsnButton" class="formButton" value="<@s.text name="common.button.add"/>MSN" hidefocus />&nbsp;&nbsp;
						<input type="button" id="addWangwangButton" class="formButton" value="<@s.text name="common.button.add"/><@s.text name="goods.common.chart.wangwang"/>" hidefocus />&nbsp;&nbsp;
						<input type="button" id="addSkypeButton" class="formButton" value="<@s.text name="common.button.add"/>Skype" hidefocus />
					</td>
				</tr>
				<#list instantMessagingList as instantMessaging>
					<tr>
						<th>
							&nbsp;
						</th>
						<td>
							<input type="hidden" name="instantMessagingList[${instantMessaging_index}].instantMessagingType" value="${instantMessaging.instantMessagingType}" />
							<span class="instantMessagingType">${action.getText("InstantMessagingType." + instantMessaging.instantMessagingType)}: </span>&nbsp;
							<input type="text" name="instantMessagingList[${instantMessaging_index}].value" class="formText instantMessagingListValue" value="${instantMessaging.value}" />
							&nbsp;&nbsp;<@s.text name="goods.message.push.title"/>: &nbsp;
							<input type="text" name="instantMessagingList[${instantMessaging_index}].title" class="formText instantMessagingListTitle" value="${instantMessaging.title}" />
							&nbsp;&nbsp;<@s.text name="goods.specification.list.search.result.header.order"/>: &nbsp;
							<input type="text" name="instantMessagingList[${instantMessaging_index}].orderList" class="formText instantMessagingListOrderList" style="width: 30px;" value="${instantMessaging.orderList}" />
							&nbsp;&nbsp;
							<span class="deleteIcon deleteInstantMessagingIcon" title="<@s.text name="goods.specification.list.search.result.header.delete"/>">&nbsp;</span>
						</td>
					</tr>
				</#list>
			</table>
			<div class="buttonArea">
				<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>