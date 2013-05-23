<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title><@s.text name="build.html.article.input.title"/> - Powered By SHOP++</title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/admin/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/admin/css/admin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.form.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/base.js"></script>
<script type="text/javascript" src="${base}/template/admin/js/admin.js"></script>
<script type="text/javascript">
$().ready(function() {

	$("#inputForm").submit(function() {
		$("#id").val($("#idSelect").val());
		$("#maxResults").val($("#maxResultsInput").val());
	});

	var isInitialized = false;
	var buildCount = 0;
	var buildTime = 0;
	$("#inputForm").ajaxForm({
		dataType: "json",
		beforeSubmit: function(data) {
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
				$("#idSelect").attr("disabled", true);
				$("#maxResultsInput").attr("disabled", true);
				$("#submitButton").attr("disabled", true);
				$("#statusTr").show();
				$("#status").text("<@s.text name="build.html.article.input.update.notice"/>...");
			}
		},
		success: function(data) {
			buildCount += data.buildCount;
			buildTime += data.buildTime;
			if (data.status == "ARTICLE_BUILDING") {
				var maxResults = Number($("#maxResults").val());
				var firstResult = Number(data.firstResult);
				$("#status").text("<@s.text name="build.html.all.input.title.update.article"/>[" + (firstResult + 1) + " - " + (firstResult + maxResults) + "],<@s.text name="build.html.all.input.title.waiting"/>...");
				$("#firstResult").val(firstResult);
				$("#inputForm").submit();
			} else if (data.status == "ARTICLE_FINISH") {
				$("#firstResult").val("0");
				$("#statusTr").hide();
				$("#idSelect").attr("disabled", false);
				$("#maxResultsInput").attr("disabled", false);
				$("#submitButton").attr("disabled", false);
				
				var time;
				if (buildTime < 60000) {
					time = (buildTime / 1000).toFixed(2) + "<@s.text name="build.html.all.input.title.unit.second"/>";
				} else {
					time = (buildTime / 60000).toFixed(2) + "<@s.text name="build.html.all.input.title.unit.minute"/>";
				}
				$.dialog({type: "success", content: "<@s.text name="build.html.article.input.update.success"/>! [<@s.text name="build.html.all.input.title.update.total"/>: " + buildCount + " <@s.text name="build.html.all.input.title.update.cost"/>: " + time + "]", width: 380, modal: true, autoCloseTime: 3000});
				isInitialized = false;
				buildCount = 0;
				buildTime = 0;
			}
		}
	});

})
</script>
</head>
<body class="input">
	<div class="body">
		<div class="bar">
			<@s.text name="build.html.article.input.title"/>
		</div>
		<form id="inputForm" action="build_html!article.action" method="post">
			<input type="hidden" id="id" name="id" value="" />
			<input type="hidden" id="maxResults" name="maxResults" value="" />
			<input type="hidden" id="firstResult" name="firstResult" value="0" />
			<table class="inputTable">
				<tr>
					<th>
						<@s.text name="article.input.article.category"/>: 
					</th>
					<td>
						<select id="idSelect" name="">
							<option value=""><@s.text name="build.html.article.input.update.category.all"/></option>
							<#list articleCategoryTreeList as articleCategoryTree>
								<option value="${articleCategoryTree.id}">
									<#if articleCategoryTree.grade != 0>
										<#list 1..articleCategoryTree.grade as i>
											&nbsp;&nbsp;
										</#list>
									</#if>
									${articleCategoryTree.name}
								</option>
							</#list>
						</select>
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
				<input type="submit" id="submitButton" class="formButton" value="<@s.text name="button.name.confirm"/>" hidefocus />&nbsp;&nbsp;
				<input type="button" class="formButton" onclick="window.history.back(); return false;" value="common.button.back" hidefocus />
			</div>
		</form>
	</div>
</body>
</html>