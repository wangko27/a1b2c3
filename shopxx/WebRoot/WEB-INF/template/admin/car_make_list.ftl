<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="car.make.list.title"/> - Powered By SHOP++</title>
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
		var carMake = prompt("<@s.text name="car.make.producer"/>","");
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
		var carMode = prompt("<@s.text name="car.make.type"/>","");
		var carMakeId = $('#carMakeId').val();
		if(!carMakeId || carMakeId == null || carMakeId == '') {
			$.message({type: 'error', content: '<@s.text name="car.make.producer.choose"/>'});
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
			$.message({type: 'error', content: '<@s.text name="car.make.type.choose"/>'});
			return;
		}
		var carStyle = prompt("<@s.text name="car.make.style"/>","");
		var yearMade = prompt("<@s.text name="car.make.generate.age"/>","");
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
			<@s.text name="car.make.maker"/>
		</div>
		<div class="body">
			<form id="listForm" action="brand!list.action" method="post">
				<div class="listBar">
					<input type="button" class="formButton" onclick="gotoAddCarMake()" value="<@s.text name="common.button.add"/>" hidefocus />
					<input type="button" class="formButton" onclick="gotoDeleteCarMake()" value="<@s.text name="common.button.delete"/>" hidefocus />
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
			<@s.text name="car.make.car.type"/>
		</div>
		<input type="hidden" id="carMakeId" value="" />
		<div class="listBar">
			<input type="button" class="formButton" onclick="gotoAddCarMode()" value="<@s.text name="common.button.add"/>" hidefocus />
			<input type="button" class="formButton" onclick="gotoDeleteCarMake()" value="<@s.text name="common.button.delete"/>" hidefocus />
		</div>
		<ul id="carModeList">
		</ul>
		</td>
		<td style="width: 100px">
		<input type="hidden" id="carModeId" value="" />
		<div class="bar">
			<@s.text name="car.make.maker.age"/>
		</div>
		<div class="listBar">
			<input type="button" class="formButton" onclick="gotoAddCarStyle()" value="<@s.text name="common.button.add"/>" hidefocus />
			<input type="button" class="formButton" onclick="gotoDeleteCarMake()" value="<@s.text name="common.button.delete"/>" hidefocus />
		</div>
		<ul id="carStyleList">
		</ul>
		</td>
		</tr>
	</table>
</body>
</html>