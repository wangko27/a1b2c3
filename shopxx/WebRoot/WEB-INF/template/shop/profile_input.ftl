<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("goods.notify.memberCenter.profile.profile")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
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
<script type="text/javascript" src="${base}/template/common/datePicker/WdatePicker.js"></script>
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
	var $validateForm = $("#validateForm");

	var $areaSelect = $("#areaSelect");

	// 地区选择菜单
	$areaSelect.lSelect({
		url: "${base}/shop/area!ajaxArea.action"// AJAX数据获取url
	});
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"member.email": {
				required: true,
				email: true
			},
			"member.score": {
				required: true,
				digits: true
			},
			"member.deposit": {
				required: true,
				min: 0
			}
			<#list memberAttributeList as memberAttribute>
				<#if memberAttribute.isRequired || memberAttribute.attributeType == "number" || memberAttribute.attributeType == "alphaint">
					,"memberAttributeValueMap['${memberAttribute.id}']": {
						<#if memberAttribute.isRequired>
							<#if memberAttribute.attributeType == "number" || memberAttribute.attributeType == "alphaint">
								required: true,
							<#else>
								required: true
							</#if>
						</#if>
						<#if memberAttribute.attributeType == "number">
							<#if memberAttribute.attributeType == "alphaint">
								number: true,
							<#else>
								number: true
							</#if>
						</#if>
						<#if memberAttribute.attributeType == "alphaint">
							lettersonly: true
						</#if>
					}
				</#if>
			</#list>
		},
		messages: {
			"member.email": {
				required: "${bundle("goods.profile.input")}E-mail",
				email: "E-mail${bundle("goods.profile.input.invalid")}"
			},
			"member.score": {
				required: "${bundle("goods.profile.input.score")}",
				digits: "${bundle("goods.profile.input.score.invalid")}"
			},
			"member.deposit": {
				required: "${bundle("goods.profile.input.deposit")}",
				min: "${bundle("goods.profile.input.deposit.invalid")}"
			}
			<#list memberAttributeList as memberAttribute>
				<#if memberAttribute.isRequired || memberAttribute.attributeType == "number" || memberAttribute.attributeType == "alphaint">
					,"memberAttributeValueMap['${memberAttribute.id}']": {
						<#if memberAttribute.isRequired>
							<#if memberAttribute.attributeType == "number" || memberAttribute.attributeType == "alphaint">
								required: "${bundle("goods.profile.input")}${memberAttribute.name}",
							<#else>
								required: "${bundle("goods.profile.input")}${memberAttribute.name}"
							</#if>
						</#if>
						<#if memberAttribute.attributeType == "number">
							<#if memberAttribute.attributeType == "alphaint">
								number: "${memberAttribute.name}${bundle("goods.profile.input.number.only")}",
							<#else>
								number: "${memberAttribute.name}${bundle("goods.profile.input.number.only")}"
							</#if>
						</#if>
						<#if memberAttribute.attributeType == "alphaint">
							lettersonly: "${memberAttribute.name}${bundle("goods.profile.input.letter.only")}"
						</#if>
					}
				</#if>
			</#list>
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
	<div class="body profileInput">
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
	                        	<li class="current"><a href="profile!edit.action">${bundle("goods.notify.memberCenter.profile.profile")}</a></li>
	                            <li><a href="password!edit.action">${bundle("goods.notify.memberCenter.profile.password")}</a></li>
	                            <li><a href="receiver!list.action">${bundle("goods.notify.memberCenter.profile.receiver")}</a></li>
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
				<div class="top">${bundle("goods.notify.memberCenter.profile.profile")}</div>
				<div class="middle">
					<div id="validateErrorContainer" class="validateErrorContainer">
						<div class="validateErrorTitle">${bundle("goods.message.reply.title.error.validate")}</div>
						<ul></ul>
					</div>
					<div class="blank"></div>
					<form id="validateForm" action="profile!update.action" method="post">
						<table class="inputTable">
							<tr>
								<th>
									E-mail: 
								</th>
								<td>
									<input type="text" name="member.email" class="formText" value="${(member.email)!}" />
									<label class="requireField">*</label>
								</td>
							</tr>
							<#list memberAttributeList as memberAttribute>
								<tr>
									<th>
										${memberAttribute.name}: 
									</th>
									<td>
										<#if memberAttribute.systemAttributeType??>
											<#if memberAttribute.systemAttributeType == "name">
												<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											<#elseif memberAttribute.systemAttributeType == "gender">
												<label><input type="radio" name="memberAttributeValueMap['${memberAttribute.id}']" value="male"<#if (member.getMemberAttributeValue(memberAttribute) == "male")!> checked</#if> />${bundle("goods.common.gender.male")}</label>
												<label><input type="radio" name="memberAttributeValueMap['${memberAttribute.id}']" value="female"<#if (member.getMemberAttributeValue(memberAttribute) == "female")!> checked</#if> />${bundle("goods.common.gender.female")}</label>
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											<#elseif memberAttribute.systemAttributeType == "birth">
												<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" onclick="WdatePicker()" />
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											<#elseif memberAttribute.systemAttributeType == "area">
												<input type="text" id="areaSelect" name="memberAttributeValueMap['${memberAttribute.id}']" class="hidden" value="${(member.getMemberAttributeValue(memberAttribute).id)!}" defaultSelectedPath="${(member.getMemberAttributeValue(memberAttribute).path)!}" />
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											<#elseif memberAttribute.systemAttributeType == "address">
												<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											<#elseif memberAttribute.systemAttributeType == "zipCode">
												<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											<#elseif memberAttribute.systemAttributeType == "phone">
												<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											<#elseif memberAttribute.systemAttributeType == "mobile">
												<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											</#if>
										<#else>
											<#if memberAttribute.attributeType == "text">
												<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											<#elseif memberAttribute.attributeType == "number">
												<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											<#elseif memberAttribute.attributeType == "alphaint">
												<input type="text" name="memberAttributeValueMap['${memberAttribute.id}']" class="formText" value="${(member.getMemberAttributeValue(memberAttribute))!}" />
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											<#elseif memberAttribute.attributeType == "select">
												<select name="memberAttributeValueMap['${memberAttribute.id}']">
													<option value="">${bundle("goods.content.buyInfo.tipsTitle")}...</option>
													<#list memberAttribute.optionList as option>
														<option value="${option}"<#if (option == member.getMemberAttributeValue(memberAttribute))!> selected</#if>>
															${option}
														</option>
													</#list>
												</select>
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											<#elseif memberAttribute.attributeType == "checkbox">
												<#list memberAttribute.optionList as option>
													<label>
														<input type="checkbox" name="memberAttributeValueMap['${memberAttribute.id}']" value="${option}"<#if (member.getMemberAttributeValue(memberAttribute).contains(option))!> checked</#if> />${option}
													</label>
												</#list>
												<#if memberAttribute.isRequired><label class="requireField">*</label></#if>
											</#if>
										</#if>
									</td>
								</tr>
							</#list>
							<tr>
								<th>
									&nbsp;
								</th>
								<td>
									<input type="submit" class="submitButton" value="${bundle("goods.message.push.submit")}" hidefocus />
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