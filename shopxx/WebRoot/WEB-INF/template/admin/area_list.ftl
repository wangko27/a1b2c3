<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="area.list.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready( function() {

	var $deleteArea = $("#listTable .deleteArea");
	
	// 地区删除
	$deleteArea.click( function() {
		var $this = $(this);
		$.dialog({type: "warn", content: "<@s.text name="area.list.delete.tipmessage"/>?", ok: "<@s.text name="button.name.confirm"/>", cancel: "<@s.text name="button.name.cancel"/>", modal: true, okCallback: deleteArea});
		function deleteArea() {
			var id = $this.attr("areaId");
			$.ajax({
				url: "area!delete.action",
				data: {"id": id},
				type: "POST",
				dataType: "json",
				success: function(data) {
					if (data.status == "success") {
						$this.parent().html("&nbsp;");
					}
					$.message({type: data.status, content: data.message});
				}
			});
		}
		return false;
	});
	
})
</script>
</head>
<body class="list">
	<div class="bar">
		<@s.text name="role.sitemanage.ROLE_AREA"/>&nbsp;<@s.text name="goods.specification.list.page.tips1"/>: ${areaList?size}
	</div>
	<div class="body">
		<form id="listForm" action="area!list.action" method="post">
			<div class="listBar">
				<input type="button" class="formButton" onclick="location.href='area!add.action<#if parent??>?parentId=${parentId}</#if>'" value="<@s.text name="area.input.area.add"/>" hidefocus />
			</div>
			<table id="listTable" class="listTable">
				<tr>
					<th colspan="5" class="green" style="text-align: center;">
						<#if parent??><@s.text name="area.input.area.super"/> - [${(parent.name)!}]<#else><@s.text name="area.input.area.top"/></#if>
					</th>
				</tr>
				<#list areaList as area>
					<#if (area_index + 1) == 1>
						<tr>
					</#if>
					<td>
						<a href="area!list.action?parentId=${area.id}" title="<@s.text name="area.input.area.subArea.show"/>">${area.name}</a>
						<a href="area!edit.action?id=${area.id}" title="<@s.text name="goods.specification.list.search.result.header.edit"/>">[<@s.text name="goods.specification.list.search.result.header.edit"/>]</a>
						<a href="#" class="deleteArea" title="<@s.text name="common.button.delete"/>" areaId="${area.id}">[<@s.text name="common.button.delete"/>]</a>
					</td>
					<#if (area_index + 1) % 5 == 0 && area_has_next>
						</tr>
						<tr>
					</#if>
					<#if (area_index + 1) % 5 == 0 && !area_has_next>
						</tr>
					</#if>
					<#if (area_index + 1) % 5 != 0 && !area_has_next>
							<td colspan="${5 - areaList?size % 5}">&nbsp;</td>
						</tr>
					</#if>
				</#list>
				<#if areaList?size == 0>
					<tr>
						<td colspan="5" style="text-align: center; color: red;">
							<@s.text name="area.input.area.subArea.none"/>! <a href="area!add.action<#if parent??>?parentId=${parentId}</#if>" style="color: gray"><@s.text name="area.input.area.subArea.addClick"/></a>
						</td>
					</tr>
				</#if>
			</table>
			<#if parent??>
				<div class="blank"></div>
				<#if parent.parent??>
					<input type="button" class="formButton" onclick="location.href='area!list.action?parentId=${parent.parent.id}'" value="<@s.text name="area.input.area.super"/>" hidefocus />
				<#else>
					<input type="button" class="formButton" onclick="location.href='area!list.action'" value="<@s.text name="area.input.area.super"/>" hidefocus />
				</#if>
			</#if>
		</form>
	</div>
</body>
</html>