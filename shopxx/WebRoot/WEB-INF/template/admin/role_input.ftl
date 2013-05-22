<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="role.input.pagetitle"/> - Powered By SHOP++</title>
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
	
	var $allChecked = $("#validateForm .allChecked");
	
	$allChecked.click( function() {
		var $this = $(this);
		var $thisCheckbox = $this.parent().parent().find(":checkbox");
		if ($thisCheckbox.filter(":checked").size() > 0) {
			$thisCheckbox.attr("checked", false);
		} else {
			$thisCheckbox.attr("checked", true);
		}
		return false;
	});
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"role.name": "required"
		},
		messages: {
			"role.name": "<@s.text name="role.messages.name"/>"
		},
		submitHandler: function(form) {
			$(form).find(":submit").attr("disabled", true);
			form.submit();
		}
	});
	
	$.validator.addMethod("roleAuthorityListRequired", $.validator.methods.required, "<@s.text name="role.messages.authority"/>");
	
	$.validator.addClassRules("roleAuthorityList", {
		roleAuthorityListRequired: true
	});
	
})
</script>
</head>
<body class="input role">
	<div class="bar">
		<#if isAddAction><@s.text name="role.title1"/><#else><@s.text name="role.title2"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="common.validateErrorTitle"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>role!save.action<#else>role!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${id}" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="role.name"/>: 
					</th>
					<td>
						<input type="text" name="role.name" class="formText" value="${(role.name)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="role.description"/>: 
					</th>
					<td>
						<textarea name="role.description" class="formTextarea">${(role.description)!}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						&nbsp;
					</td>
				</tr>
				<tr class="authorityList">
					<th>
						<a href="#" class="allChecked" title="<@s.text name="role.checkbox.fullselect"/>"><@s.text name="role.goodsmanage"/>: </a>
					</th>
					<td>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_GOODS"<#if (isAddAction || role.authorityList.contains("ROLE_GOODS"))!> checked</#if> /><@s.text name="role.goodsmanage.ROLE_GOODS"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_GOODS_NOTIFY"<#if (isAddAction || role.authorityList.contains("ROLE_GOODS_NOTIFY"))!> checked</#if> /><@s.text name="role.goodsmanage.ROLE_GOODS_NOTIFY"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_GOODS_CATEGORY"<#if (isAddAction || role.authorityList.contains("ROLE_GOODS_CATEGORY"))!> checked</#if> /><@s.text name="role.goodsmanage.ROLE_GOODS_CATEGORY"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_GOODS_TYPE"<#if (isAddAction || role.authorityList.contains("ROLE_GOODS_TYPE"))!> checked</#if> /><@s.text name="role.goodsmanage.ROLE_GOODS_TYPE"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_SPECIFICATION"<#if (isAddAction || role.authorityList.contains("ROLE_SPECIFICATION"))!> checked</#if> /><@s.text name="role.goodsmanage.ROLE_SPECIFICATION"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_BRAND"<#if (isAddAction || role.authorityList.contains("ROLE_BRAND"))!> checked</#if> /><@s.text name="role.goodsmanage.ROLE_BRAND"/>
						</label>
					</td>
				</tr>
				<tr class="authorityList">
					<th>
						<a href="#" class="allChecked" title="<@s.text name="role.checkbox.fullselect"/>"><@s.text name="role.ordermanage"/>: </a>
					</th>
					<td>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_ORDER"<#if (isAddAction || role.authorityList.contains("ROLE_ORDER"))!> checked</#if> /><@s.text name="role.ordermanage.ROLE_ORDER"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_PAYMENT"<#if (isAddAction || role.authorityList.contains("ROLE_PAYMENT"))!> checked</#if> /><@s.text name="role.ordermanage.ROLE_PAYMENT"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_REFUND"<#if (isAddAction || role.authorityList.contains("ROLE_REFUND"))!> checked</#if> /><@s.text name="role.ordermanage.ROLE_REFUND"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_SHIPPING"<#if (isAddAction || role.authorityList.contains("ROLE_SHIPPING"))!> checked</#if> /><@s.text name="role.ordermanage.ROLE_SHIPPING"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_RESHIP"<#if (isAddAction || role.authorityList.contains("ROLE_RESHIP"))!> checked</#if> /><@s.text name="role.ordermanage.ROLE_RESHIP"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_DELIVERY_CENTER"<#if (isAddAction || role.authorityList.contains("ROLE_DELIVERY_CENTER"))!> checked</#if> /><@s.text name="role.ordermanage.ROLE_DELIVERY_CENTER"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_DELIVERY_TEMPLATE"<#if (isAddAction || role.authorityList.contains("ROLE_DELIVERY_TEMPLATE"))!> checked</#if> /><@s.text name="role.ordermanage.ROLE_DELIVERY_TEMPLATE"/>
						</label>
					</td>
				</tr>
				<tr class="authorityList">
					<th>
						<a href="#" class="allChecked" title="<@s.text name="role.checkbox.fullselect"/>"><@s.text name="role.membermanage"/>: </a>
					</th>
					<td>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_MEMBER"<#if (isAddAction || role.authorityList.contains("ROLE_MEMBER"))!> checked</#if> /><@s.text name="role.membermanage.ROLE_MEMBER"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_MEMBER_RANK"<#if (isAddAction || role.authorityList.contains("ROLE_MEMBER_RANK"))!> checked</#if> /><@s.text name="role.membermanage.ROLE_MEMBER_RANK"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_MEMBER_ATTRIBUTE"<#if (isAddAction || role.authorityList.contains("ROLE_MEMBER_ATTRIBUTE"))!> checked</#if> /><@s.text name="role.membermanage.ROLE_MEMBER_ATTRIBUTE"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_COMMENT"<#if (isAddAction || role.authorityList.contains("ROLE_COMMENT"))!> checked</#if> /><@s.text name="role.membermanage.ROLE_COMMENT"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_LEAVE_MESSAGE"<#if (isAddAction || role.authorityList.contains("ROLE_LEAVE_MESSAGE"))!> checked</#if> /><@s.text name="role.membermanage.ROLE_LEAVE_MESSAGE"/>
						</label>
					</td>
				</tr>
				<tr class="authorityList">
					<th>
						<a href="#" class="allChecked" title="<@s.text name="role.checkbox.fullselect"/>"><@s.text name="role.pagecontentmanage"/>: </a>
					</th>
					<td>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_NAVIGATION"<#if (isAddAction || role.authorityList.contains("ROLE_NAVIGATION"))!> checked</#if> /><@s.text name="role.pagecontentmanage.ROLE_NAVIGATION"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_ARTICLEE"<#if (isAddAction || role.authorityList.contains("ROLE_ARTICLEE"))!> checked</#if> /><@s.text name="role.pagecontentmanage.ROLE_ARTICLEE"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_ARTICLE_CATEGORY"<#if (isAddAction || role.authorityList.contains("ROLE_ARTICLE_CATEGORY"))!> checked</#if> /><@s.text name="role.pagecontentmanage.ROLE_ARTICLE_CATEGORY"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_FRIEND_LINK"<#if (isAddAction || role.authorityList.contains("ROLE_FRIEND_LINK"))!> checked</#if> /><@s.text name="role.pagecontentmanage.ROLE_FRIEND_LINK"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_PAGE_TEMPLATE"<#if (isAddAction || role.authorityList.contains("ROLE_PAGE_TEMPLATE"))!> checked</#if> /><@s.text name="role.pagecontentmanage.ROLE_PAGE_TEMPLATE"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_MAIL_TEMPLATE"<#if (isAddAction || role.authorityList.contains("ROLE_MAIL_TEMPLATE"))!> checked</#if> /><@s.text name="role.pagecontentmanage.ROLE_MAIL_TEMPLATE"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_PRINT_TEMPLATE"<#if (isAddAction || role.authorityList.contains("ROLE_PRINT_TEMPLATE"))!> checked</#if> /><@s.text name="role.pagecontentmanage.ROLE_PRINT_TEMPLATE"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_CACHE"<#if (isAddAction || role.authorityList.contains("ROLE_CACHE"))!> checked</#if> /><@s.text name="role.pagecontentmanage.ROLE_CACHE"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_BUILD_HTML"<#if (isAddAction || role.authorityList.contains("ROLE_BUILD_HTML"))!> checked</#if> /><@s.text name="role.pagecontentmanage.ROLE_BUILD_HTML"/>
						</label>
					</td>
				</tr>
				<tr class="authorityList">
					<th>
						<a href="#" class="allChecked" title="<@s.text name="role.checkbox.fullselect"/>"><@s.text name="role.adminmanage"/>: </a>
					</th>
					<td>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_ADMIN"<#if (isAddAction || role.authorityList.contains("ROLE_ADMIN"))!> checked</#if> /><@s.text name="role.adminmanage.ROLE_ADMIN"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_ROLE"<#if (isAddAction || role.authorityList.contains("ROLE_ROLE"))!> checked</#if> /><@s.text name="role.adminmanage.ROLE_ROLE"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_MESSAGE"<#if (isAddAction || role.authorityList.contains("ROLE_MESSAGE"))!> checked</#if> /><@s.text name="role.adminmanage.ROLE_MESSAGE"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_LOG"<#if (isAddAction || role.authorityList.contains("ROLE_LOG"))!> checked</#if> /><@s.text name="role.adminmanage.ROLE_LOG"/>
						</label>
					</td>
				</tr>
				<tr class="authorityList">
					<th>
						<a href="#" class="allChecked" title="<@s.text name="role.checkbox.fullselect"/>"><@s.text name="role.sitemanage"/>: </a>
					</th>
					<td>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_SETTING"<#if (isAddAction || role.authorityList.contains("ROLE_SETTING"))!> checked</#if> /><@s.text name="role.sitemanage.ROLE_SETTING"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_INSTANT_MESSAGING"<#if (isAddAction || role.authorityList.contains("ROLE_INSTANT_MESSAGING"))!> checked</#if> /><@s.text name="role.sitemanage.ROLE_INSTANT_MESSAGING"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_PAYMENT_CONFIG"<#if (isAddAction || role.authorityList.contains("ROLE_PAYMENT_CONFIG"))!> checked</#if> /><@s.text name="role.sitemanage.ROLE_PAYMENT_CONFIG"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_DELIVERY_TYPE"<#if (isAddAction || role.authorityList.contains("ROLE_DELIVERY_TYPE"))!> checked</#if> /><@s.text name="role.sitemanage.ROLE_DELIVERY_TYPE"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_AREA"<#if (isAddAction || role.authorityList.contains("ROLE_AREA"))!> checked</#if> /><@s.text name="role.sitemanage.ROLE_AREA"/>
						</label>
						<label>
							<input type="checkbox" name="role.authorityList" class="roleAuthorityList" value="ROLE_DELIVERY_CORP"<#if (isAddAction || role.authorityList.contains("ROLE_DELIVERY_CORP"))!> checked</#if> /><@s.text name="role.sitemanage.ROLE_DELIVERY_CORP"/>
						</label>
					</td>
				</tr>
				<#if (role.isSystem)!false>
					<tr>
						<th>
							&nbsp;
						</th>
						<td>
							<span class="warnInfo"><span class="icon">&nbsp;</span><@s.text name="role.manage.tips1"/>: </b><@s.text name="role.manage.tips2"/></span>
						</td>
					</tr>
				</#if>
			</table>
			<div class="buttonArea">
				<input type="submit" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>