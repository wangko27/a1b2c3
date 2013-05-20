<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("deposit.recharge.pagetitle")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/shop/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/shop.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
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
	var $depositRechargeForm = $("#depositRechargeForm");
	
	// 表单验证
	$depositRechargeForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"rechargeAmount": {
				required: true,
				positive: true
			},
			"paymentConfig.id": "required"
		},
		messages: {
			"rechargeAmount": {
				required: "${bundle("deposit.recharge.amount.message.required")}",
				positive: "${bundle("deposit.recharge.amount.message.positive")}"
			},
			"paymentConfig.id": "${bundle("deposit.recharge.amount.message.paymethod")}"
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
	<div class="body depositRecharge">
		<div class="bodyLeft">
			<div class="memberInfo">
				<div class="top"></div>
				<div class="middle">
					<p>${bundle("deposit.welcome.message")}&nbsp;&nbsp;<span class="username">${loginMember.username}</span>&nbsp;&nbsp;[<a class="userLogout" href="member!logout.action"">${bundle("button.name.logout")}</a>]</p>
					<p>${bundle("member.rank")} <span class="red"> ${loginMember.memberRank.name}</span></p>
				</div>
				<div class="bottom"></div>
			</div>
			<div class="blank"></div>
			<div class="memberMenu">
				<div class="top">
					<a href="member_center!index.action">${bundle("member.homepage")}</a>
				</div>
				<div class="middle">
					<ul>
	                	<li class="order">
	                    	<ul>
	                        	<li><a href="order!list.action">${bundle("member.menu.order")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="category favorite">
	                    	<ul>
	                        	<li><a href="favorite!list.action">${bundle("member.menu.favorite")}</a></li>
	                        	<li><a href="goods_notify!list.action">${bundle("member.menu.goods.notify")}</a></li>
	                        </ul>
	                    </li>
	                  	<li class="message">
	                    	<ul>
	                        	<li><a href="message!send.action">${bundle("member.menu.message.send")}</a></li>
	                            <li><a href="message!inbox.action">${bundle("member.menu.message.inbox")}</a></li>
	                            <li><a href="message!draftbox.action">${bundle("member.menu.message.draftbox")}</a></li>
	                            <li><a href="message!outbox.action">${bundle("member.menu.message.outbox")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="profile">
	                    	<ul>
	                        	<li><a href="profile!edit.action">${bundle("member.menu.profile.profile")}</a></li>
	                            <li><a href="password!edit.action">${bundle("member.menu.profile.password")}</a></li>
	                            <li><a href="receiver!list.action">${bundle("member.menu.profile.receiver")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="deposit">
	                    	<ul>
	                    		<li class="current"><a href="deposit!list.action">${bundle("member.menu.deposit.my")}</a></li>
	                        	<li><a href="deposit!recharge.action">${bundle("member.menu.deposit.recharge")}</a></li>
	                        </ul>
	                    </li>
	                </ul>
				</div>
				<div class="bottom"></div>
			</div>
		</div>
		<div class="bodyRight">
			<div class="memberCenterDetail">
				<div class="top">${bundle("deposit.recharge.title")}</div>
				<div class="middle">
					<div id="validateErrorContainer" class="validateErrorContainer">
						<div class="validateErrorTitle">${bundle("deposit.recharge.input.error")}</div>
						<ul></ul>
					</div>
					<div class="blank"></div>
					<form id="depositRechargeForm" action="payment!submit.action" method="post">
						<input type="hidden" name="paymentType" value="recharge" />
						<table class="inputTable">
							<tr>
								<th>
									${bundle("deposit.recharge.input.rechargeAmount")}
								</th>
								<td>
									<input type="text" name="rechargeAmount" class="formText" />
									<label class="requireField">*</label>
								</td>
							</tr>
							<tr>
								<th>
									${bundle("deposit.recharge.input.payMethod")}
								</th>
								<td>
									<table class="paymentConfigTable">
										<#list nonDepositOfflinePaymentConfigList as paymentConfig>
											<tr>
												<td class="nameTd">
													<label>
														<input type="radio" name="paymentConfig.id" value="${paymentConfig.id}" /> ${paymentConfig.name}
													</label>
												</td>
												<td>
													<#if paymentConfig.paymentFeeType == "scale" && paymentConfig.paymentFee != 0>
														[${bundle("deposit.recharge.input.pay.feerate")} ${paymentConfig.paymentFee}%]
													<#elseif paymentConfig.paymentFeeType == "fixed" && paymentConfig.paymentFee != 0>
														[${bundle("deposit.recharge.input.pay.fee")} ${paymentConfig.paymentFee?string(currencyFormat)}]
													</#if>
													<#if paymentConfig.description??>
														<p>${paymentConfig.description}</p>
													</#if>
												</td>
											</tr>
										</#list>
									</table>
								</td>
							</tr>
							<tr>
								<th>
									&nbsp;
								</th>
								<td>
									<input type="submit" class="submitButton" value="${bundle("deposit.recharge.input.button.submit")}" hidefocus />
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