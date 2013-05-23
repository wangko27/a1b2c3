<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="build.html.all.input.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.form.js"></script>
<script type="text/javascript" src="${base}/template/common/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready( function() {

	// 根据更新选项显示/隐藏开始日期和结束日期
	$(".buildTypeInput").click( function() {
		if ($(this).val() == "date") {
			$(".dateTr").show();
		} else {
			$(".dateTr").hide();
		}
	})
	
	$("#inputForm").submit(function() {
		$("#buildType").val($(".buildTypeInput:checked").val());
		$("#maxResults").val($("#maxResultsInput").val());
		$("#beginDate").val($("#beginDateInput").val());
		$("#endDate").val($("#endDateInput").val());
	});

	var isInitialized = false;
	var buildCount = 0;
	var buildTime = 0;
	$("#inputForm").ajaxForm({
		dataType: "json",
		beforeSubmit: function(data) {
			var beginDateInputValue = $("#beginDateInput").val();
			var endDateInputValue = $("#endDateInput").val();
			var maxResultsInputValue = $("#maxResultsInput").val();
			if ($.trim(maxResultsInputValue) == "") {
				$.message({type: "warn", content: "<@s.text name="build.html.all.input.title.input"/>!"});
				return false;
			}
			if (!/^[1-9]\d*$/.test(maxResultsInputValue)) {
				$.message({type: "warn", content: "<@s.text name="build.html.all.input.title.input.positive"/>!"});
				return false;
			}
			
			if (!isInitialized) {
				isInitialized = true;
				$(".buildTypeInput").attr("disabled", true);
				$("#maxResultsInput").attr("disabled", true);
				$("#beginDateInput").attr("disabled", true);
				$("#endDateInput").attr("disabled", true);
				$("#submitButton").attr("disabled", true);
				$("#statusTr").show();
				$("#status").text("<@s.text name="build.html.all.input.title.update.main"/>...");
			}
		},
		success: function(data) {
			buildCount += data.buildCount;
			buildTime += data.buildTime;
			if (data.status == "indexFinish") {
				$("#status").text("<@s.text name="build.html.all.input.title.update.login"/>...");
				$("#buildContent").val("login");
				$("#inputForm").submit();
			} else if (data.status == "loginFinish") {
				$("#status").text("<@s.text name="build.html.all.input.title.update.register"/>...");
				$("#buildContent").val("registerAgreement");
				$("#inputForm").submit();
			} else if (data.status == "registerAgreementFinish") {
				$("#status").text("<@s.text name="build.html.all.input.title.update"/>ADMIN.JS,<@s.text name="build.html.all.input.title.waiting"/>...");
				$("#buildContent").val("adminJs");
				$("#inputForm").submit();
			} else if (data.status == "adminJsFinish") {
				$("#status").text("<@s.text name="build.html.all.input.title.update"/>SHOP.JS,<@s.text name="build.html.all.input.title.waiting"/>...");
				$("#buildContent").val("shopJs");
				$("#inputForm").submit();
			} else if (data.status == "shopJsFinish") {
				$("#status").text("<@s.text name="build.html.all.input.title.update.error"/>...");
				$("#buildContent").val("errorPage");
				$("#inputForm").submit();
			} else if (data.status == "errorPageFinish") {
				$("#status").text("<@s.text name="build.html.all.input.title.update.articleWait"/>...");
				$("#buildContent").val("article");
				$("#inputForm").submit();
			} else if (data.status == "articleBuilding") {
				var maxResults = Number($("#maxResults").val());
				var firstResult = data.firstResult;
				$("#status").text("<@s.text name="build.html.all.input.title.update.article"/>[" + (firstResult + 1) + " - " + (firstResult + maxResults) + "],<@s.text name="build.html.all.input.title.waiting"/>...");
				$("#buildContent").val("article");
				$("#firstResult").val(firstResult);
				$("#inputForm").submit();
			} else if (data.status == "articleFinish") {
				$("#status").text("<@s.text name="build.html.all.input.title.update.goodsWait"/>...");
				$("#buildContent").val("goods");
				$("#firstResult").val("0");
				$("#inputForm").submit();
			} else if (data.status == "goodsBuilding") {
				var maxResults = Number($("#maxResults").val());
				var firstResult = data.firstResult;
				$("#status").text("<@s.text name="build.html.all.input.title.update.goods"/>[" + (firstResult + 1) + " - " + (firstResult + maxResults) + "],<@s.text name="build.html.all.input.title.waiting"/>...");
				$("#buildContent").val("goods");
				$("#firstResult").val(firstResult);
				$("#inputForm").submit();
			} else if (data.status == "goodsFinish") {
				$("#buildContent").val("");
				$("#firstResult").val("0");
				$("#statusTr").hide();
				$(".buildTypeInput").attr("disabled", false);
				$("#maxResultsInput").attr("disabled", false);
				$("#beginDateInput").attr("disabled", false);
				$("#endDateInput").attr("disabled", false);
				$("#submitButton").attr("disabled", false);
				
				var time;
				if (buildTime < 60000) {
					time = (buildTime / 1000).toFixed(2) + "<@s.text name="build.html.all.input.title.unit.second"/>";
				} else {
					time = (buildTime / 60000).toFixed(2) + "<@s.text name="build.html.all.input.title.unit.minute"/>";
				}
				$.dialog({type: "success", content: "<@s.text name="build.html.all.input.title.update.success"/>! [<@s.text name="build.html.all.input.title.update.total"/>: " + buildCount + " <@s.text name="build.html.all.input.title.update.cost"/>: " + time + "]", width: 380, modal: true, autoCloseTime: 3000});
				isInitialized = false;
				buildCount = 0;
				buildTime = 0;
			}
		}
	});

});
</script>
</head>
<body class="input">
	<div class="bar">
		<@s.text name="build.html.all.input.title"/>
	</div>
	<div class="body">
		<form id="inputForm" action="build_html!all.action" method="post">
			<input type="hidden" id="buildType" name="buildType" value="" />
			<input type="hidden" id="maxResults" name="maxResults" value="" />
			<input type="hidden" id="firstResult" name="firstResult" value="0" />
			<input type="hidden" id="buildContent" name="buildContent" value="" />
			<input type="hidden" id="beginDate" name="beginDate" value="" />
			<input type="hidden" id="endDate" name="endDate" value="" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="build.html.all.input.update.selector"/>: 
					</th>
					<td>
						<label><input type="radio" name="buildTypeInput" class="buildTypeInput" value="date" checked /><@s.text name="build.html.all.input.update.theDate"/></label>&nbsp;&nbsp;
						<label><input type="radio" name="buildTypeInput" class="buildTypeInput" value="all" /><@s.text name="build.html.all.input.update.all"/></label>
					</td>
				</tr>
				<tr class="dateTr">
					<th>
						<@s.text name="build.html.all.input.update.begin"/>: 
					</th>
					<td>
						<input type="text" id="beginDateInput" name="" class="formText" value="${(defaultBeginDate?string("yyyy-MM-dd"))!}" title="<@s.text name="build.html.all.input.update.begin.blank"/>" onclick="WdatePicker()" />
					</td>
				</tr>
				<tr class="dateTr">
					<th>
						<@s.text name="build.html.all.input.update.end"/>: 
					</th>
					<td>
						<input type="text" id="endDateInput" name="" class="formText" value="${(defaultEndDate?string("yyyy-MM-dd"))!}" title="<@s.text name="build.html.all.input.update.end.blank"/>" onclick="WdatePicker()" />
					</td>
				</tr>
				<tr>
					<th>
						<@s.text name="build.html.all.input.update.frequency"/>
					</th>
					<td>
						<input type="text" id="maxResultsInput" name="" class="formText" value="50" />
					</td>
				</tr>
				<tr id="statusTr" class="hidden">
					<th>
						&nbsp;
					</th>
					<td>
						<span class="loadingBar">&nbsp;</span>
						<p id="status"></p>
					</td>
				</tr>
			</table>
			<div class="buttonArea">
				<input type="submit" id="submitButton" class="formButton" value="<@s.text name="caritem.delete.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="<@s.text name="common.button.back"/>" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>