<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("goods.notify.memberCenter.profile.receiver")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/shop/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/shop.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.lSelect.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.validate.methods.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/base.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/shop.js"></script>
<!--[if lte IE 6]>
	<script type="text/javascript" src="${base}/template/common/js/belatedPNG.js"></script>
	<script type="text/javascript">
		// 解决IE6透明PNG图片BUG
		DD_belatedPNG.fix(".belatedPNG");
	</script>
<![endif]-->
<script type="text/javascript">
$().ready( function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $receiverForm = $("#receiverForm");

	var $areaSelect = $("#areaSelect");

	// 地区选择菜单
	$areaSelect.lSelect({
		url: "${base}/shop/area!ajaxArea.action"// AJAX数据获取url
	});
	
	// 表单验证
	$receiverForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"receiver.name": "required",
			"areaId": "required",
			"receiver.address": "required",
			"receiver.mobile": {
				"requiredOne": "#receiverPhone"
			},
			"receiver.zipCode": "required"
		},
		messages: {
			"receiver.name": "${bundle("goods.receiver.input.name")}",
			"areaId": "${bundle("goods.receiver.select.area")}",
			"receiver.address": "${bundle("goods.receiver.input.address")}",
			"receiver.mobile": {
				"requiredOne": "${bundle("goods.receiver.input.invalid")}"
			},
			"receiver.zipCode": "${bundle("goods.receiver.input.zipcode")}"
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});

});
</script>
</head>
<body class="memberCenter">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body receiverInput">
		<div class="bodyLeft">
			<div class="memberInfo">
				<div class="top"></div>
				<div class="middle">
					<p>${bundle("goods.notify.memberCenter.welcome")}!&nbsp;&nbsp;<span class="username">${loginMember.username}</span>&nbsp;&nbsp;[<a class="userLogout" href="member!logout.action"">${bundle("goods.common.logout")}</a>]</p>
					<p>${bundle("goods.notify.memberCenter.memberLevel")}: <span class="red"> ${loginMember.memberRank.name}</span></p>
				</div>
				<div class="bottom"></div>
			</div>
			<div class="blank"></div>
			<div class="memberMenu">
				<div class="top">
					<a href="member_center!index.action">${bundle("goods.notify.memberCenter.mainPage")}</a>
				</div>
				<div class="middle">
					<ul>
	                	<li class="order">
	                    	<ul>
	                        	<li><a href="order!list.action">${bundle("goods.notify.memberCenter.myOrder")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="category favorite">
	                    	<ul>
	                        	<li><a href="favorite!list.action">${bundle("goods.notify.memberCenter.favorite")}</a></li>
	                        	<li><a href="goods_notify!list.action">${bundle("goods.notify.memberCenter.notify")}</a></li>
	                        </ul>
	                    </li>
	                  	<li class="message">
	                    	<ul>
	                        	<li><a href="message!send.action">${bundle("goods.notify.memberCenter.message.send")}</a></li>
	                            <li><a href="message!inbox.action">${bundle("goods.notify.memberCenter.message.inbox")}</a></li>
	                            <li><a href="message!draftbox.action">${bundle("goods.notify.memberCenter.message.draftbox")}</a></li>
	                            <li><a href="message!outbox.action">${bundle("goods.notify.memberCenter.message.outbox")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="profile">
	                    	<ul>
	                        	<li><a href="profile!edit.action">${bundle("goods.notify.memberCenter.profile.profile")}</a></li>
	                            <li><a href="password!edit.action">${bundle("goods.notify.memberCenter.profile.password")}</a></li>
	                            <li class="current"><a href="receiver!list.action">${bundle("goods.notify.memberCenter.profile.receiver")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="deposit">
	                    	<ul>
	                    		<li><a href="deposit!list.action">${bundle("goods.notify.memberCenter.deposit.store")}</a></li>
	                        	<li><a href="deposit!recharge.action">${bundle("goods.notify.memberCenter.deposit.charge")}</a></li>
	                        </ul>
	                    </li>
	                </ul>
				</div>
				<div class="bottom"></div>
			</div>
		</div>
		<div class="bodyRight">
			<div class="memberCenterDetail">
				<div class="top">${bundle("goods.order.ship.address")}</div>
				<div class="middle">
					<div id="validateErrorContainer" class="validateErrorContainer">
						<div class="validateErrorTitle">${bundle("goods.message.reply.title.error.validate")}</div>
						<ul></ul>
					</div>
					<div class="blank"></div>
					<form id="receiverForm" action="<#if isAddAction>receiver!save.action<#else>receiver!update.action</#if>" method="post">
						<input type="hidden" name="id" value="${id}" />
						<table class="inputTable">
							<tr>
								<th>
									${bundle("goods.order.ship.username")}: 
								</th>
								<td>
									<input type="text" name="receiver.name" class="formText" value="${(receiver.name)!}" />
									<label class="requireField">*</label>
								</td>
							</tr>
							<tr>
								<th>
									${bundle("goods.common.area")}: 
								</th>
								<td>
									<input type="text" id="areaSelect" name="areaId" class="hidden" value="${(receiver.area.id)!}" defaultSelectedPath="${(receiver.area.path)!}" />
									<label class="requireField">*</label>
								</td>
							</tr>
							<tr>
								<th>
									${bundle("goods.common.address")}: 
								</th>
								<td>
									<input type="text" name="receiver.address" class="formText" value="${(receiver.address)!}" />
									<label class="requireField">*</label>
								</td>
							</tr>
							<tr>
								<th>
									${bundle("goods.order.ship.phone")}: 
								</th>
								<td>
									<input type="text" id="receiverPhone" name="receiver.phone" class="formText" value="${(receiver.phone)!}" />
									<label class="requireField">*</label>
								</td>
							</tr>
							<tr>
								<th>
									${bundle("goods.order.ship.mobile")}: 
								</th>
								<td>
									<input type="text" name="receiver.mobile" class="formText" value="${(receiver.mobile)!}" />
									<label class="requireField">*</label>
								</td>
							</tr>
							<tr>
								<th>
									${bundle("goods.order.ship.zipcode")}: 
								</th>
								<td>
									<input type="text" name="receiver.zipCode" class="formText" value="${(receiver.zipCode)!}" />
									<label class="requireField">*</label>
								</td>
							</tr>
							<tr>
								<th>
									${bundle("goods.common.setting")}: 
								</th>
								<td>
									<label>
										<@checkbox name="receiver.isDefault" value="${(receiver.isDefault)!false}" />${bundle("goods.order.ship.address.default")}
									</label>
								</td>
							</tr>
							<tr>
								<th>
									&nbsp;
								</th>
								<td>
									<input type="submit" class="submitButton" value="${bundle("goods.message.push.submit")}" hidefocus />
									<input type="button" class="backButton" onclick="window.history.back(); return false;" value="${bundle("goods.common.return")}" hidefocus />
								</td>
							</tr>
						</table>
					</form>
					<div class="blank"></div>
				</div>
				<div class="bottom"></div>
			</div>
		</div>
		<div class="blank"></div>
		<#include "/WEB-INF/template/shop/friend_link.ftl">
	</div>
	<div class="blank"></div>
	<#include "/WEB-INF/template/shop/footer.ftl">
</body>
</html>