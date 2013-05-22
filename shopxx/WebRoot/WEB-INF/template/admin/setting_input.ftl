<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="setting.pagetitle"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $validateForm = $("#validateForm");
	
	var $tab = $("#tab");
	var $isLoginFailureLockInput = $(".isLoginFailureLock");
	var $loginFailureLockCountTr = $("#loginFailureLockCountTr");
	var $loginFailureLockTimeTr = $("#loginFailureLockTimeTr");
	var $smtpFromMail = $("#smtpFromMail");
	var $smtpHost = $("#smtpHost");
	var $smtpPort = $("#smtpPort");
	var $smtpUsername = $("#smtpUsername");
	var $smtpPassword = $("#smtpPassword");
	var $smtpToMailWrap = $("#smtpToMailWrap");
	var $smtpToMail = $("#smtpToMail");
	var $smtpTest = $("#smtpTest");
	var $smtpTestStatus = $("#smtpTestStatus");
	var $scoreType = $(".scoreType");
	var $scoreScaleTr = $("#scoreScaleTr");
	var $scoreScale = $("#scoreScale");
	
	// Tab效果
	$tab.tabs(".tabContent", {
		tabs: "input"
	});
	
	$isLoginFailureLockInput.click( function() {
		var $this = $(this);
		if($this.val() == "true") {
			$loginFailureLockCountTr.show();
			$loginFailureLockTimeTr.show();
		} else {
			$loginFailureLockCountTr.hide();
			$loginFailureLockTimeTr.hide();
		}
	});
	
	// 邮箱测试
	$smtpTest.click( function() {
		var $this = $(this);
		if ($this.val() == "<@s.text name="setting.emailtest.title"/>") {
			$this.val("<@s.text name="setting.emailtest.content"/>");
			$smtpToMailWrap.show();
		} else {
			if ($.trim($smtpFromMail.val()) == "") {
				$.dialog({type: "warn", content: "<@s.text name="setting.emailtest.sender"/>", modal: true, autoCloseTime: 3000});
				return false;
			}
			if (!/^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/.test($.trim($smtpFromMail.val()))) {
				$.dialog({type: "warn", content: "<@s.text name="setting.emailtest.sender.format"/>", modal: true, autoCloseTime: 3000});
				return false;
			}
			if ($.trim($smtpHost.val()) == "") {
				$.dialog({type: "warn", content: "<@s.text name="setting.emailtest.smtpaddress"/>", modal: true, autoCloseTime: 3000});
				return false;
			}
			if ($.trim($smtpPort.val()) == "") {
				$.dialog({type: "warn", content: "<@s.text name="setting.emailtest.smtpport"/>", modal: true, autoCloseTime: 3000});
				return false;
			}
			if (!/^[0-9]+$/.test($.trim($smtpPort.val()))) {
				$.dialog({type: "warn", content: "<@s.text name="setting.emailtest.smtpport.format"/>", modal: true, autoCloseTime: 3000});
				return false;
			}
			if ($.trim($smtpUsername.val()) == "") {
				$.dialog({type: "warn", content: "<@s.text name="setting.emailtest.smptusername"/>", modal: true, autoCloseTime: 3000});
				return false;
			}
			if ($.trim($smtpPassword.val()) == "") {
				$.dialog({type: "warn", content: "<@s.text name="setting.emailtest.smptpassword"/>", modal: true, autoCloseTime: 3000});
				return false;
			}
			if ($.trim($smtpToMail.val()) == "") {
				$.dialog({type: "warn", content: "<@s.text name="setting.emailtest.receiver"/>", modal: true, autoCloseTime: 3000});
				return false;
			}
			if (!/^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/.test($.trim($smtpToMail.val()))) {
				$.dialog({type: "warn", content: "<@s.text name="setting.emailtest.receiver.format"/>", modal: true, autoCloseTime: 3000});
				return false;
			}
			
			$.ajax({
				url: "setting!ajaxSendSmtpTest.action",
				data: {"setting.smtpFromMail": $smtpFromMail.val(), "setting.smtpHost": $smtpHost.val(), "setting.smtpPort": $smtpPort.val(), "setting.smtpUsername": $smtpUsername.val(), "setting.smtpPassword": $smtpPassword.val(), "smtpToMail": $smtpToMail.val()},
				type: "POST",
				dataType: "json",
				cache: false,
				beforeSend: function(data) {
					$smtpTestStatus.html('<span class="loadingIcon">&nbsp;</span><@s.text name="setting.emailtest.loadingmessage"/>');
					$this.attr("disabled", true);
				},
				success: function(data) {
					$smtpTestStatus.empty();
					$this.attr("disabled", false);
					$.dialog({type: data.status, content: data.message, width: 400, ok: "<@s.text name="button.name.confirm"/>", modal: true});
				}
			});
		}
	});
	
	// 根据积分获取方式显示/隐藏“积分换算比率”
	$scoreType.click( function() {
		$this = $(this);
		if($this.val() == "orderAmount") {
			$scoreScale.removeClass("ignoreValidate");
			$scoreScaleTr.show();
		} else {
			$scoreScale.val("0");
			$scoreScale.addClass("ignoreValidate");
			$scoreScaleTr.hide();
		}
	});
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		ignore: ".ignoreValidate",
		rules: {
			"setting.shopName": "required",
			"setting.shopUrl": "required",
			"shopLogo": "imageFile",
			"setting.email": "email",
			"setting.bigGoodsImageWidth": {
				required: true,
				positiveInteger: true
			},
			"setting.bigGoodsImageHeight": {
				required: true,
				positiveInteger: true
			},
			"setting.smallGoodsImageWidth": {
				required: true,
				positiveInteger: true
			},
			"setting.smallGoodsImageHeight": {
				required: true,
				positiveInteger: true
			},
			"setting.thumbnailGoodsImageWidth": {
				required: true,
				positiveInteger: true
			},
			"setting.thumbnailGoodsImageHeight": {
				required: true,
				positiveInteger: true
			},
			"defaultBigGoodsImage": "imageFile",
			"defaultSmallGoodsImage": "imageFile",
			"defaultThumbnailGoodsImage": "imageFile",
			"watermarkImage": "imageFile",
			"setting.watermarkAlpha": {
				required: true,
				digits: true
			},
			"setting.defaultMarketPriceNumber": {
				required: true,
				number: true
			},
			"setting.loginFailureLockCount": {
				required: true,
				positiveInteger: true
			},
			"setting.loginFailureLockTime": {
				required: true,
				digits: true
			},
			"setting.smtpFromMail": {
				required: true,
				email: true
			},
			"setting.smtpHost": "required",
			"setting.smtpPort": {
				required: true,
				digits: true
			},
			"setting.smtpUsername": "required",
			"setting.currencyType": "required",
			"setting.currencySign": "required",
			"setting.currencyUnit": "required",
			"setting.storeAlertCount": {
				required: true,
				digits: true
			},
			"setting.scoreScale": {
				required: true,
				min: 0
			},
			"setting.buildHtmlDelayTime": {
				required: true,
				positiveInteger: true
			}
		},
		messages: {
			"setting.shopName": "<@s.text name="setting.messages.shopName"/>",
			"setting.shopUrl": "<@s.text name="setting.messages.shopUrl"/>",
			"shopLogo": "<@s.text name="setting.messages.shopLogo"/>",
			"setting.email": "<@s.text name="setting.messages.email"/>",
			"setting.bigGoodsImageWidth": {
				required: "<@s.text name="setting.messages.bigGoodsImageWidth.required"/>",
				positiveInteger: "<@s.text name="setting.messages.bigGoodsImageWidth.positiveInteger"/>"
			},
			"setting.bigGoodsImageHeight": {
				required: "<@s.text name="setting.messages.bigGoodsImageHeight.required"/>",
				positiveInteger: "<@s.text name="setting.messages.bigGoodsImageHeight.positiveInteger"/>"
			},
			"setting.smallGoodsImageWidth": {
				required: "<@s.text name="setting.messages.smallGoodsImageWidth.required"/>",
				positiveInteger: "<@s.text name="setting.messages.smallGoodsImageWidth.positiveInteger"/>"
			},
			"setting.smallGoodsImageHeight": {
				required: "<@s.text name="setting.messages.smallGoodsImageHeight.required"/>",
				positiveInteger: "<@s.text name="setting.messages.smallGoodsImageHeight.positiveInteger"/>"
			},
			"setting.thumbnailGoodsImageWidth": {
				required: "<@s.text name="setting.messages.thumbnailGoodsImageWidth.required"/>",
				positiveInteger: "<@s.text name="setting.messages.thumbnailGoodsImageWidth.positiveInteger"/>"
			},
			"setting.thumbnailGoodsImageHeight": {
				required: "<@s.text name="setting.messages.thumbnailGoodsImageHeight.required"/>",
				positiveInteger: "<@s.text name="setting.messages.thumbnailGoodsImageHeight.positiveInteger"/>"
			},
			"defaultBigGoodsImage": "<@s.text name="setting.messages.defaultBigGoodsImage"/>",
			"defaultSmallGoodsImage": "<@s.text name="setting.messages.defaultSmallGoodsImage"/>",
			"defaultThumbnailGoodsImage": "<@s.text name="setting.messages.defaultThumbnailGoodsImage"/>",
			"watermarkImage": "<@s.text name="setting.messages.watermarkImage"/>",
			"setting.watermarkAlpha": {
				required: "<@s.text name="setting.messages.watermarkAlpha.required"/>",
				digits: "<@s.text name="setting.messages.watermarkAlpha.digits"/>"
			},
			"setting.defaultMarketPriceNumber": {
				required: "<@s.text name="setting.messages.defaultMarketPriceNumber.required"/>",
				number: "<@s.text name="setting.messages.defaultMarketPriceNumber.number"/>"
			},
			"setting.loginFailureLockCount": {
				required: "<@s.text name="setting.messages.loginFailureLockCount.required"/>",
				positiveInteger: "<@s.text name="setting.messages.loginFailureLockCount.positiveInteger"/>"
			},
			"setting.loginFailureLockTime": {
				required: "<@s.text name="setting.messages.loginFailureLockTime.required"/>",
				digits: "<@s.text name="setting.messages.loginFailureLockTime.digits"/>"
			},
			"setting.smtpFromMail": {
				required: "<@s.text name="setting.messages.smtpFromMail.required"/>",
				email: "<@s.text name="setting.messages.smtpFromMail.email"/>"
			},
			"setting.smtpHost": "<@s.text name="setting.messages.smtpHost"/>",
			"setting.smtpPort": {
				required: "<@s.text name="setting.messages.smtpPort.required"/>",
				digits: "<@s.text name="setting.messages.smtpPort.digits"/>"
			},
			"setting.smtpUsername": "<@s.text name="setting.messages.smtpUsername"/>",
			"setting.currencyType": "<@s.text name="setting.messages.currencyType"/>",
			"setting.currencySign": "<@s.text name="setting.messages.currencySign"/>",
			"setting.currencyUnit": "<@s.text name="setting.messages.currencyUnit"/>",
			"setting.storeAlertCount": {
				required: "<@s.text name="setting.messages.storeAlertCount.required"/>",
				digits: "<@s.text name="setting.messages.storeAlertCount.digits"/>"
			},
			"setting.scoreScale": {
				required: "<@s.text name="setting.messages.scoreScale.required"/>",
				min: "<@s.text name="setting.messages.scoreScale.min"/>"
			},
			"setting.buildHtmlDelayTime": {
				required: "<@s.text name="setting.messages.buildHtmlDelayTime.required"/>",
				digits: "<@s.text name="setting.messages.buildHtmlDelayTime.digits"/>"
			}
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
})
</script>
</head>
<body class="input">
	<div class="bar">
		<@s.text name="setting.pagetitle"/>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="setting.validateErrorTitle"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" class="form" action="setting!update.action" enctype="multipart/form-data" method="post">
			<ul id="tab" class="tab">
				<li>
					<input type="button" value="<@s.text name="setting.tab.base"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="setting.tab.display"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="setting.tab.security"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="setting.tab.mail"/>" hidefocus />
				</li>
				<li>
					<input type="button" value="<@s.text name="setting.tab.other"/>" hidefocus />
				</li>
			</ul>
			<table class="inputTable tabContent">
				<tr>
					<th>
						<@s.text name="setting.shopName"/>: 
					</th>
					<td>
						<input type="text" name="setting.shopName" class="formText" value="${setting.shopName}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.shopUrl"/>: 
					</th>
					<td>
						<input type="text" name="setting.shopUrl" class="formText" value="${setting.shopUrl}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.shopLogoPath"/>: 
					</th>
					<td>
						<input type="file" name="shopLogo" />
						<a href="${base}${setting.shopLogoPath}" target="_blank"><@s.text name="common.button.view"/></a>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.hotSearch"/>: 
					</th>
					<td>
						<input type="text" name="setting.hotSearch" class="formText" value="${setting.hotSearch}"/>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.address"/>: 
					</th>
					<td>
						<input type="text" name="setting.address" class="formText" value="${setting.address}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.phone"/>: 
					</th>
					<td>
						<input type="text" name="setting.phone" class="formText" value="${setting.phone}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.zipCode"/>: 
					</th>
					<td>
						<input type="text" name="setting.zipCode" class="formText" value="${setting.zipCode}" />
					</td>
				</tr>
				<tr>
					<th>
						E-mail: 
					</th>
					<td>
						<input type="text" name="setting.email" class="formText" value="${setting.email}" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.certtext"/>: 
					</th>
					<td>
						<input type="text" name="setting.certtext" class="formText" value="${setting.certtext}"/>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.metaKeywords"/>: 
					</th>
					<td>
						<input type="text" name="setting.metaKeywords" class="formText" value="${setting.metaKeywords}"/>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.metaDescription"/>: 
					</th>
					<td>
						<textarea name="setting.metaDescription" class="formTextarea">${setting.metaDescription}</textarea>
					</td>
				</tr>
			</table>
			<table class="inputTable tabContent">
				<tr>
					<th>
						<@s.text name="setting.bigGoodsImage"/>: 
					</th>
					<td>
						<span class="fieldTitle"><@s.text name="setting.GoodsImageWidth"/>: </span>
						<input type="text" name="setting.bigGoodsImageWidth" class="formText" value="${setting.bigGoodsImageWidth}" style="width: 50px;"/>
						<label class="requireField">*</label>
						<span class="fieldTitle"><@s.text name="setting.GoodsImageHeight"/>: </span>
						<input type="text" name="setting.bigGoodsImageHeight" class="formText" value="${setting.bigGoodsImageHeight}" style="width: 50px;"/>
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.smallGoodsImage"/>: 
					</th>
					<td>
						<span class="fieldTitle"><@s.text name="setting.GoodsImageWidth"/>: </span>
						<input type="text" name="setting.smallGoodsImageWidth" class="formText" value="${setting.smallGoodsImageWidth}" style="width: 50px;"/>
						<label class="requireField">*</label>
						<span class="fieldTitle"><@s.text name="setting.GoodsImageHeight"/>: </span>
						<input type="text" name="setting.smallGoodsImageHeight" class="formText" value="${setting.smallGoodsImageHeight}" style="width: 50px;"/>
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.thumbnailGoodsImage"/>: 
					</th>
					<td>
						<span class="fieldTitle"><@s.text name="setting.GoodsImageWidth"/>: </span>
						<input type="text" name="setting.thumbnailGoodsImageWidth" class="formText" value="${setting.thumbnailGoodsImageWidth}" style="width: 50px;"/>
						<label class="requireField">*</label>
						<span class="fieldTitle"><@s.text name="setting.GoodsImageHeight"/>: </span>
						<input type="text" name="setting.thumbnailGoodsImageHeight" class="formText" value="${setting.thumbnailGoodsImageHeight}" style="width: 50px;"/>
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.thumbnailGoodsImage"/>: 
					</th>
					<td>
						<input type="file" name="defaultBigGoodsImage" />
						<a href="${base}${setting.defaultBigGoodsImagePath}" target="_blank"><@s.text name="common.button.view"/></a>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.defaultSmallGoodsImage"/>: 
					</th>
					<td>
						<input type="file" name="defaultSmallGoodsImage" />
						<a href="${base}${setting.defaultSmallGoodsImagePath}" target="_blank"><@s.text name="common.button.view"/></a>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.defaultThumbnailGoodsImage"/>: 
					</th>
					<td>
						<input type="file" name="defaultThumbnailGoodsImage" />
						<a href="${base}${setting.defaultThumbnailGoodsImagePath}" target="_blank"><@s.text name="common.button.view"/></a>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.defaultSameGoodsOrder"/>: 
					</th>
					<td>
						<select name="setting.defaultSameGoodsOrder">
							<#list sameGoodsOrderList as order>
								<option value="${order}"<#if order == setting.defaultSameGoodsOrder> selected</#if>>
								${action.getText("SameGoodsOrder." + order)}
								</option>
							</#list>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.watermarkImagePath"/>: 
					</th>
					<td>
						<input type="file" name="watermarkImage" />
						<a href="${base}${setting.watermarkImagePath}" target="_blank"><@s.text name="common.button.view"/></a>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.watermarkPosition"/>: 
					</th>
					<td>
						<#list watermarkPositionList as watermarkPosition>
							<label>
								<input type="radio" name="setting.watermarkPosition" value="${watermarkPosition}"<#if watermarkPosition == setting.watermarkPosition> checked</#if> />
								${action.getText("WatermarkPosition." + watermarkPosition)}&nbsp;
							</label>
						</#list>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.watermarkAlpha"/>: 
					</th>
					<td>
						<input type="text" name="setting.watermarkAlpha" class="formText" value="${setting.watermarkAlpha}" title="<@s.text name="setting.watermarkAlpha.tips"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.isShowMarketPrice"/>: 
					</th>
					<td>
						<label>
							<@checkbox name="setting.isShowMarketPrice" value="${setting.isShowMarketPrice}" /><@s.text name="setting.isShowMarketPrice.tips"/>
						</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.defaultMarketPriceOperator"/>: 
					</th>
					<td>
						<@s.text name="setting.defaultMarketPriceOperator.tips1"/> = <@s.text name="setting.defaultMarketPriceOperator.tips2"/>
						<select name="setting.defaultMarketPriceOperator">
							<#list operatorList as operator>
								<option value="${operator}"<#if operator == setting.defaultMarketPriceOperator> selected</#if>>
								${action.getText("Operator." + operator)}
								</option>
							</#list>
						</select>
						<input type="text" name="setting.defaultMarketPriceNumber" class="formText" value="${setting.defaultMarketPriceNumber}" style="width: 50px;" />
					</td>
				</tr>
			</table>
			<table class="inputTable tabContent">
				<tr>
					<th>
						<@s.text name="setting.register.position"/>: 
					</th>
					<td>
						<label>
							<@checkbox name="setting.isRegisterEnabled" value="${setting.isRegisterEnabled}" /><@s.text name="etting.isRegisterEnabled"/>
						</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.register.FailureLock"/>: 
					</th>
					<td>
						<label><input type="radio" name="setting.isLoginFailureLock" class="isLoginFailureLock" value="true"<#if setting.isLoginFailureLock> checked</#if> /><@s.text name="setting.register.FailureLock.yes"/></label>
						<label><input type="radio" name="setting.isLoginFailureLock" class="isLoginFailureLock" value="false"<#if !setting.isLoginFailureLock> checked</#if> /><@s.text name="setting.register.FailureLock.no"/></label>
					</td>
				</tr>
				<tr id="loginFailureLockCountTr"<#if !setting.isLoginFailureLock> class="hidden"</#if>>
					<th>
						<@s.text name="setting.loginFailureLockCount"/>: 
					</th>
					<td>
						<input type="text" name="setting.loginFailureLockCount" class="formText" value="${setting.loginFailureLockCount}" title="<@s.text name="setting.loginFailureLockCount.tips"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr id="loginFailureLockTimeTr"<#if !setting.isLoginFailureLock> class="hidden"</#if>>
					<th>
						<@s.text name="setting.loginFailureLockTime"/>: 
					</th>
					<td>
						<input type="text" name="setting.loginFailureLockTime" class="formText" value="${setting.loginFailureLockTime}" title="<@s.text name="setting.loginFailureLockTime.tips"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
			</table>
			<table class="inputTable tabContent">
				<tr>
					<th>
						<@s.text name="setting.smtpFromMail"/>: 
					</th>
					<td>
						<input type="text" id="smtpFromMail" name="setting.smtpFromMail" class="formText" value="${setting.smtpFromMail}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.smtpHost"/>: 
					</th>
					<td>
						<input type="text" id="smtpHost" name="setting.smtpHost" class="formText" value="${setting.smtpHost}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.smtpPort"/>: 
					</th>
					<td>
						<input type="text" id="smtpPort" name="setting.smtpPort" class="formText" value="${setting.smtpPort}" title="<@s.text name="setting.smtpPort.tips"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.smtpUsername"/>: 
					</th>
					<td>
						<input type="text" id="smtpUsername" name="setting.smtpUsername" class="formText" value="${setting.smtpUsername}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.smtpPassword"/>: 
					</th>
					<td>
						<input type="password" id="smtpPassword" name="setting.smtpPassword" class="formText" title="<@s.text name="setting.smtpPassword.tips"/>" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.smtptest.title"/>: 
					</th>
					<td>
						<span id="smtpToMailWrap" class="hidden">
							<div><@s.text name="setting.smtptest.receiver"/>: </div>
							<input type="text" id="smtpToMail" name="smtpToMail" class="formText" />
						</span>
						<input type="button" id="smtpTest" class="formButton" value="<@s.text name="setting.smtptest.button"/>" hidefocus />
						<span id="smtpTestStatus"></span>
					</td>
				</tr>
			</table>
			<table class="inputTable tabContent">
				<tr>
					<th>
						<@s.text name="setting.currencyType"/>: 
					</th>
					<td>
						<select id="currencyType" name="setting.currencyType">
							<option value=""><@s.text name="common.tips.select"/></option>
							<#list currencyTypeList as currencyType>
								<option value="${currencyType}"<#if currencyType == setting.currencyType> selected</#if>>
									${action.getText("CurrencyType." + currencyType)}
								</option>
							</#list>
						</select>
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.currencySign"/>: 
					</th>
					<td>
						<input type="text" name="setting.currencySign" class="formText" value="${setting.currencySign}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.currencyUnit"/>: 
					</th>
					<td>
						<input type="text" name="setting.currencyUnit" class="formText" value="${setting.currencyUnit}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.priceScale"/>: 
					</th>
					<td>
						<select name="setting.priceScale">
							<option value="0" <#if setting.priceScale == 0> selected</#if>>
								<@s.text name="setting.priceScale.option1"/>
							</option>
							<option value="1" <#if setting.priceScale == 1> selected</#if>>
								1<@s.text name="setting.priceScale.option2"/>
							</option>
							<option value="2" <#if setting.priceScale == 2> selected</#if>>
								2<@s.text name="setting.priceScale.option2"/>
							</option>
							<option value="3" <#if setting.priceScale == 3> selected</#if>>
								3<@s.text name="setting.priceScale.option2"/>
							</option>
							<option value="4" <#if setting.priceScale == 4> selected</#if>>
								4<@s.text name="setting.priceScale.option2"/>
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.priceRoundType"/>: 
					</th>
					<td>
						<select name="setting.priceRoundType">
							<#list roundTypeList as roundType>
								<option value="${roundType}"<#if roundType == setting.priceRoundType> selected</#if>>
									${action.getText("RoundType." + roundType)}
								</option>
							</#list>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.storeAlertCount"/>: 
					</th>
					<td>
						<input type="text" name="setting.storeAlertCount" class="formText" value="${setting.storeAlertCount}" title="" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.storeFreezeTime"/>: 
					</th>
					<td>
						<label title="<@s.text name="setting.storeFreezeTime.tips"/>">
							<select name="setting.storeFreezeTime" class="requireField">
								<#list storeFreezeTimeList as storeFreezeTime>
									<option value="${storeFreezeTime}"<#if storeFreezeTime == setting.storeFreezeTime> selected</#if>>
										${action.getText("StoreFreezeTime." + storeFreezeTime)}
									</option>
								</#list>
							</select>
						</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.scoreType"/>: 
					</th>
					<td>
						<#list scoreTypeList as scoreType>
							<label>
								<input type="radio" name="setting.scoreType" class="scoreType" value="${scoreType}"<#if scoreType == setting.scoreType> checked</#if> />
								${action.getText("ScoreType." + scoreType)}&nbsp;
							</label>
						</#list>
					</td>
				</tr>
				<tr id="scoreScaleTr"<#if setting.scoreType != "orderAmount"> class="hidden"</#if>>
					<th>
						<@s.text name="setting.scoreScale"/>: 
					</th>
					<td>
						<input type="text" id="scoreScale" name="setting.scoreScale" class="formText" value="${setting.scoreScale}" title="<@s.text name="setting.scoreScale.tips"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.buildHtmlDelayTime"/>: 
					</th>
					<td>
						<input type="text" name="setting.buildHtmlDelayTime" class="formText" value="${setting.buildHtmlDelayTime}" title="<@s.text name="setting.buildHtmlDelayTime.tips"/>" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="setting.gzipset"/>: 
					</th>
					<td>
						<label>
							<@checkbox name="setting.isGzipEnabled" value="${setting.isGzipEnabled}" /><@s.text name="setting.isGzipEnabled"/>
						</label>
					</td>
				</tr>
				<tr>
					<th>
						
					</th>
					<td>
						<span class="warnInfo"><@s.text name="setting.gzipwarn"/></span>
					</td>
				</tr>
			</table>
			<div class="buttonArea">
				<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>