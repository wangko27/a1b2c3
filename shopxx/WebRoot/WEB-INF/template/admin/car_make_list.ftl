<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>适用车型信息维护 - Powered By SHOP++</title>
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
	function gotoAddCarMake(){
		var carMake = prompt("请输入制造商","");
		var url = shopxx.base + "/admin/car_make!save.action";
		$.ajax({
			url: url,
			data: 'name=' + carMake,
			type: "POST",
			dataType: "json",
			success: function(data) {
				if (data.status == "success") {
					$('#carMakeList').append('<li><input type="hidden" value="" />' + carMake + '</li>')
				}
				$.message({type: data.status, content: data.message});
			}
		});
	}
</script>
</head>
<body class="list">
	<table>
		<tr>
		<td style="width: 100px">
		<div class="bar">
			制造商
		</div>
		<div class="body">
			<form id="listForm" action="brand!list.action" method="post">
				<div class="listBar">
					<input type="button" class="formButton" onclick="gotoAddCarMake()" value="添加" hidefocus />
					<input type="button" class="formButton" onclick="gotoDeleteCarMake()" value="删除" hidefocus />
				</div>
				<ul id="carMakeList">
					<#list carMakeList as carMake>
					<li><input type="hidden" value="${carMake.id}" />${carMake.name}</li>
					</#list>
				</ul>
			</form>
		</div>
		</td>
		<td style="width: 100px">
		<div class="bar">
			车型
		</div>
		<ul id="carModeList">
		</ul>
		</td>
		<td style="width: 100px">
		<div class="bar">
			出厂年限
		</div>
		</td>
		<td style="width: 100px">
		<div class="bar">
			规格
		</div>
		</td>
		</tr>
	</table>
</body>
</html>