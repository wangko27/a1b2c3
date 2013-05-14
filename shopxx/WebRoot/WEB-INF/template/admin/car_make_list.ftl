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
	
	function gotoAddCarMode(){
		var carMode = prompt("请输入汽车型号","");
		var carMakeId = $('#carMakeId').val();
		if(!carMakeId || carMakeId == null || carMakeId == '') {
			$.message({type: 'error', content: '请选选择制造商'});
			return;
		}
		var url = shopxx.base + "/admin/car_mode!save.action";
		$.ajax({
			url: url,
			data: 'carMode.carMakeId=' + carMakeId + '&carMode.name=' + carMode,
			type: "POST",
			dataType: "json",
			success: function(data) {
				if (data.status == "success") {
					$('#carModeList').append('<li><a href="javascript:;" onclick="showCarStyleList(' + carMakeId + ')">' + carMode + '</a></li>');
				}
				$.message({type: data.status, content: data.message});
			}
		});
	}
	
	function showCarModeList(carMakeId){
		var url = shopxx.base + "/admin/car_mode!list.action";
		$.ajax({
			url: url,
			data: 'carMode.carMakeId=' + carMakeId,
			type: "POST",
			dataType: "json",
			success: function(data) {
				var html = '';
				for(var i = 0; i < data.length; i++){
					html += '<li><a href="javascript:;" onclick="showCarStyleList(\'' + data[i].id +'\')">' + data[i].name + '</a></li>';
				}
				$('#carMakeId').val(carMakeId);
				$('#carModeList').html(html);
			}
		});
	}
	
	function gotoAddCarStyle(){
		var carModeId = $('#carModeId').val();
		if(!carModeId || carModeId == null || carModeId == '') {
			$.message({type: 'error', content: '请选择车型'});
			return;
		}
		var carStyle = prompt("请输入汽车规格","");
		var yearMade = prompt("请输入生产年代","");
		var url = shopxx.base + "/admin/car_style!save.action";
		$.ajax({
			url: url,
			data: 'carStyle.carModeId=' + carModeId + '&carStyle.style=' + carStyle + '&carStyle.yearMade=' + yearMade,
			type: "POST",
			dataType: "json",
			success: function(data) {
				if (data.status == "success") {
					$('#carStyleList').append('<li><input type="hidden" value="" />' + carStyle + '---' + yearMade + '</li>')
				}
				$.message({type: data.status, content: data.message});
			}
		});
	}
	function showCarStyleList(carModeId){
		var url = shopxx.base + "/admin/car_style!list.action";
		$.ajax({
			url: url,
			data: 'carStyle.carModeId=' + carModeId,
			type: "POST",
			dataType: "json",
			success: function(data) {
				var html = '';
				for(var i = 0; i < data.length; i++){
					html += '<li>' + data[i].style + '---' + data[i].yearMade + '</li>';
				}
				$('#carModeId').val(carModeId);
				$('#carStyleList').html(html);
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
					<li><input type="hidden" value="${carMake.id}" /><a href="javascript:;" onclick="showCarModeList('${carMake.id}')">${carMake.name}</a></li>
					</#list>
				</ul>
			</form>
		</div>
		</td>
		<td style="width: 100px">
		<div class="bar">
			车型
		</div>
		<input type="hidden" id="carMakeId" value="" />
		<div class="listBar">
			<input type="button" class="formButton" onclick="gotoAddCarMode()" value="添加" hidefocus />
			<input type="button" class="formButton" onclick="gotoDeleteCarMake()" value="删除" hidefocus />
		</div>
		<ul id="carModeList">
		</ul>
		</td>
		<td style="width: 100px">
		<input type="hidden" id="carModeId" value="" />
		<div class="bar">
			出厂年限
		</div>
		<div class="listBar">
			<input type="button" class="formButton" onclick="gotoAddCarStyle()" value="添加" hidefocus />
			<input type="button" class="formButton" onclick="gotoDeleteCarMake()" value="删除" hidefocus />
		</div>
		<ul id="carStyleList">
		</ul>
		</td>
		</tr>
	</table>
</body>
</html>