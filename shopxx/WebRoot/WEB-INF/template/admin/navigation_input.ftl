<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="navigation.input.pagetitle"/> - Powered By SHOP++</title>
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
$().ready( function() {

	var $validateErrorContainer = $("#validateErrorContainer");
	var $validateErrorLabelContainer = $("#validateErrorContainer ul");
	var $validateForm = $("#validateForm");

	var $systemUrl = $("#systemUrl");
	var $url = $("#url");

	// 将选择的系统内容地址填充至链接地址中
	$systemUrl.change( function() {
		$url.val($systemUrl.val());
	});
	
	// 链接地址内容修改时,系统内容选择框修改为不选择任何项目
	$url.keypress( function() {
		$systemUrl.val("");
	});
	
	// 表单验证
	$validateForm.validate({
		errorContainer: $validateErrorContainer,
		errorLabelContainer: $validateErrorLabelContainer,
		wrapper: "li",
		errorClass: "validateError",
		ignoreTitle: true,
		rules: {
			"navigation.name": "required",
			"navigation.url": "required",
			"navigation.orderList": 	"digits"
		},
		messages: {
			"navigation.name": "<@s.text name="navigation.messages.name"/>",
			"navigation.url": "<@s.text name="navigation.messages.url"/>",
			"navigation.orderList": 	"<@s.text name="navigation.messages.orderList"/>"
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
		<#if isAddAction><@s.text name="navigation.input.title1"/><#else><@s.text name="navigation.input.title2"/></#if>
	</div>
	<div id="validateErrorContainer" class="validateErrorContainer">
		<div class="validateErrorTitle"><@s.text name="common.validateErrorTitle"/></div>
		<ul></ul>
	</div>
	<div class="body">
		<form id="validateForm" action="<#if isAddAction>navigation!save.action<#else>navigation!update.action</#if>" method="post">
			<input type="hidden" name="id" value="${id}" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="navigation.name"/>: 
					</th>
					<td>
						<input type="text" id="name" name="navigation.name" class="formText" value="${(navigation.name)!}" />	 
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="navigation.systemContent"/>: 
					</th>
					<td>
						<select id="systemUrl">
							<option value="">------------</option>
							<option value="<#noparse>${base}/</#noparse>"<#if ("$" + "{base}/" == navigation.url)!> selected</#if>><@s.text name="navigation.input.url.default1"/></option>
							<option value="<#noparse>${base}</#noparse>/shop/leave_message.htm"<#if ("$" + "{base}/shop/leave_message.htm" == navigation.url)!> selected</#if>><@s.text name="navigation.input.url.default2"/></option>
							<#list articleCategoryTreeList as articleCategoryTree>
								<option value="<#noparse>${base}</#noparse>${articleCategoryTree.url}"<#if (("$" + "{base}" + articleCategoryTree.url) == navigation.url)!> selected</#if>>
									<#if articleCategoryTree.grade != 0>
										<#list 1..articleCategoryTree.grade as i>
											&nbsp;&nbsp;
										</#list>
									</#if>
									${articleCategoryTree.name}
								</option>
							</#list>
							<#list goodsCategoryTreeList as goodsCategoryTree>
								<option value="<#noparse>${base}</#noparse>${goodsCategoryTree.url}"<#if (("$" + "{base}" + goodsCategoryTree.url) == navigation.url)!> selected</#if>>
									<#if goodsCategoryTree.grade != 0>
										<#list 1..goodsCategoryTree.grade as i>
											&nbsp;&nbsp;
										</#list>
									</#if>
									${goodsCategoryTree.name}
								</option>
							</#list>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="navigation.url"/>: 
					</th>
					<td>
						<input type="text" id="url" name="navigation.url" class="formText" value="${(navigation.url)!}" />
						<label class="requireField">*</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="navigation.navigationPosition"/>: 
					</th>
					<td>
						<select name="navigation.navigationPosition">
							<option value="top" <#if (navigation.navigationPosition == "top")!> selected</#if>>
								${action.getText("NavigationPosition.top")}
							</option>
							<option value="middle" <#if (isAddAction || navigation.navigationPosition == "middle")!> selected</#if>>
								${action.getText("NavigationPosition.middle")}
							</option>
							<option value="bottom" <#if (navigation.navigationPosition == "bottom")!> selected</#if>>
								${action.getText("NavigationPosition.bottom")}
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="navigation.setting"/>: 
					</th>
					<td>
						<label>
							<@checkbox name="navigation.isVisible" value="${(navigation.isVisible)!true}" /><@s.text name="navigation.visible"/>
						</label>
						<label>
							<@checkbox name="navigation.isBlankTarget" value="${(navigation.isBlankTarget)!false}" /><@s.text name="navigation.isBlankTarget"/>
						</label>
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="navigation.orderList"/>: 
					</th>
					<td>
						<input type="text" name="navigation.orderList" class="formText" value="${(navigation.orderList)!}" title="<@s.text name="navigation.messages.orderList"/>" />
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