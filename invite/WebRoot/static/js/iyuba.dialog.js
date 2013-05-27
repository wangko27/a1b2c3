var _time = 0;
var _timer;
var exp_status = 0;
var EXPRESS_LIB = [{//表情库, 此为默认表情
		'em1' :'(发呆)',	'em2' :'(微笑)',	'em3' :'(大笑)',	'em4' :'(坏笑)',	'em5' :'(偷笑)',
		'em6' :'(生气)',	'em7' :'(不)',	'em8' :'(难过)',	'em9' :'(哭)',	'em10':'(偷瞄)',
		'em11':'(晕)',	'em12':'(汗)',	'em13':'(困)',	'em14':'(害羞)',	'em15':'(惊讶)',
		'em16':'(开心)',	'em17':'(色)',	'em18':'(得意)',	'em19':'(骷髅)',	'em20':'(囧)',
		'em21':'(睡觉)',	'em22':'(撇嘴)',	'em23':'(亲)',	'em24':'(疑问)',	'em25':'(闭嘴)',
		'em26':'(失望)',	'em27':'(茫然)',	'em28':'(努力)',	'em29':'(鄙视)',	'em30':'(猪头)',
		'em0' : 30},//默认表情结束
		{/* 此表情库为扩展表情待后续开发...*/},{},{},{}];

function deleteDialog(id, msg, callback) {
	var confirmBtn = $("<input class='input-submit' type='button' value='确定'/>");
	
	$("#divMsgDlg").html("<table cellspacing='0'><tr><td id='topLeft'></td>" + 
		"<td class='topBar'></td><td id='topRight'></td></tr><tr>" +
		"<td class='verticalBar'></td><td><h2><span>提示</span></h2>" +
		"<div id='tableDivInfo'><div id='tableDivInfoBody'>确定要删除 " + msg + 
		" 吗?</div><div id='tableDivInfoButton'>" +
		"<input class='input-submit' onclick='removeDialog()' type='button' value='取消'/>" +
		"</div></div></td><td class='verticalBar'></td></tr><tr><td id='bottomLeft'></td>" +
		"<td class='topBar'></td><td id='bottomRight'></td></tr></table>");
	$('#tableDivInfoButton').prepend(confirmBtn);
	confirmBtn.bind('click', function(){
		removeDialog();
		callback(id);
	});
}

function successDialog(operate, msg) {
	showDialog("提示", operate, msg + '成功', '确定');
}

function failedDialog(operate, msg) {
	showDialog("提示", operate, msg + '失败', '确定');
}

function timer() {
	_time--;
	if (_time == 0) {
		removeDialog();
		clearInterval(_timer);
	}
}

function successDialogTime(operate, msg, time) {
	showDialog("提示", operate, msg + '成功', '确定');
	_time = time;
	_timer = setInterval(timer,1000);
}

function failedDialogTime(operate, msg, time) {
	showDialog("提示", operate, msg + '失败', '确定');
	_time = time;
	_timer = setInterval(timer,1000);
}

function showDialogTime(notice, operate, msg, btnCtx, time) {
	showDialog(notice, operate, msg, btnCtx);
	_time = time;
	_timer = setInterval(timer,1000);
}

function showDialog(notice, operate, msg, btnCtx) {
	$("#divMsgDlg").html("<table cellspacing='0'><tr><td id='topLeft'></td>" + 
		"<td class='topBar'></td><td id='topRight'></td></tr><tr>" +
		"<td class='verticalBar'></td><td><h2><span>" + notice + "</span></h2>" +
		"<div id='tableDivInfo'><div id='tableDivInfoBody'>" + operate + msg +
		" </div><div id='tableDivInfoButton'>" +
		"<input class='input-submit' onclick='removeDialog()' type='button' value='" + btnCtx + "'/>" +
		"</div></div></td><td class='verticalBar'></td></tr><tr><td id='bottomLeft'></td>" +
		"<td class='topBar'></td><td id='bottomRight'></td></tr></table>");
}

//********************************************************************//
function createDialog(notice, msg, btnCtx, author, callback) {
	var nameLength = 40;
	var passwordLength = 10;
	var nameDescriptionLength = 100;
	
	$("#divMsgDlg").html("<table cellspacing='0'><tr><td id='topLeft'></td>" + 
		"<td class='topBar'></td><td id='topRight'></td></tr><tr>" +
		"<td class='verticalBar'></td><td><h2><span>" + notice + "</span></h2>" +
		"<div id='tableDivInfo'><div id='tableDivInfoBody'>" +
		" </div><div id='tableDivInfoButton'>" +
		"<input class='input-submit' onclick='removeDialog()' type='button' value='取消'/>" +
		"</div></div></td><td class='verticalBar'></td></tr><tr><td id='bottomLeft'></td>" +
		"<td class='topBar'></td><td id='bottomRight'></td></tr></table>");
	
	var confirmBtn = $("<input class='input-submit' type='button' value='" + btnCtx + "'/>");
	var closeBtn = $("<span id='shareDialog'>×</span>");
	
	var createTitleLabel = $("<span>" + msg + "名称 :</span>");
	var createTitleTextInput = $("<input type='text'>");
	var createTitleTextInputLength = $("<label>0/" + nameLength + "</label>");
	var createTitleText = $("<span></span>");
	var createTitle = $("<div></div>");
	
	var createDescTextInput = $("<textarea></textarea>");
	var createDescLabel = $("<span>" + msg + "描述 :</span>");
	var createDescText = $("<span></span>");
	var createDesc = $("<div></div>");
	
	var createDescInfoTextLength = $("<span>0/" + nameDescriptionLength + "</span>");
	var createDescInfo = $("<div></div>");
	
	var createAuthTextSelectChoose = $("<option value='0' selected='selected'>-----</option>");
	var createAuthTextSelectEveryone = $("<option value='0'>任何人可见</option>");
	var createAuthTextSelectFriend = $("<option value='1'>仅好友可见</option>");
	var createAuthTextSelectTheIds = $("<option value='2'>指定人可见</option>");
	var createAuthTextSelectMe = $("<option value='3'>仅自己可见</option>");
	var createAuthTextSelectPwd = $("<option value='4'>凭密码查看</option>");
	var createAuthTextSelect = $("<select name='AuthSelector'></select>")
	var createAuthTextInput = $("<input type='text'>");
	var createAuthTextPasswordInput = $("<input type='password'>");
	var createAuthTextInputLength = $("<span>0/" + passwordLength + "</span>");
	
	var createAuthLabel = $("<span>设置权限 :</span>");
	var createAuthText = $("<span></span>");
	var createAuth = $("<div></div>");
	
	// css
	createAuth.css("height", "26px").css("line-height", "20px");
	createDescInfo.css("height", "16px").css("line-height", "16px").css("color", "gray");
	createDescInfoTextLength.css("margin-left", "75px");
	createDescLabel.css("display", "block").css("float", "left").css("height", "22px").css("line-height", "22px");
	createTitleTextInput.css("padding", "0px").css("margin-left", "5px").css("width", "200px").css("border", "1px solid #D9D9DA");
	createTitleTextInputLength.css("margin-left", "10px").css("color", "gray");
	createDescTextInput.css("margin-left", "5px").css("width", "280px").css("height", "60px");
	createAuthTextPasswordInput.css("width", "80px").css("margin-left", "5px").css("border", "1px solid #D9D9DA");
	createAuthTextInputLength.css("margin-left", "10px").css("color", "gray");
	createAuthTextSelect.css("margin-left", "5px");
	createAuthTextInput.css("width", "180px").css("margin-left", "5px").css("border", "1px solid #D9D9DA");
	createAuthTextPasswordInput.hide();
	createAuthTextInput.hide();
	
	$('#tableDivInfoButton').prepend(confirmBtn);
	$('h2').prepend(closeBtn);
	// 添加
	createTitleText.prepend(createTitleTextInputLength);
	createTitleText.prepend(createTitleTextInput);
	createTitle.prepend(createTitleText);
	createTitle.prepend(createTitleLabel);
	
	createDescText.prepend(createDescTextInput);
	createDesc.prepend(createDescText);
	createDesc.prepend(createDescLabel);
	
	createDescInfo.prepend(createDescInfoTextLength);
	
	if (author == true) {
		createAuthTextSelect.prepend(createAuthTextSelectPwd);
		createAuthTextSelect.prepend(createAuthTextSelectMe);
		createAuthTextSelect.prepend(createAuthTextSelectTheIds);
		createAuthTextSelect.prepend(createAuthTextSelectFriend);
		createAuthTextSelect.prepend(createAuthTextSelectEveryone);
		createAuthTextSelect.prepend(createAuthTextSelectChoose);
		
		createAuthText.prepend(createAuthTextInput);
		createAuthText.prepend(createAuthTextPasswordInput);
		createAuthText.prepend(createAuthTextSelect);
		
		createAuth.prepend(createAuthText);
		createAuth.prepend(createAuthLabel);
		
		$('#tableDivInfoBody').prepend(createAuth);
	}
	$('#tableDivInfoBody').prepend(createDescInfo);
	$('#tableDivInfoBody').prepend(createDesc);
	$('#tableDivInfoBody').prepend(createTitle);
	
	$('#tableDivInfo').css('height', '180px');
	$('.verticalBar').css('height', '200px');
	$('#tableDivInfoBody').css('height', '145px');
	
	createAuthTextSelect.bind('change', function(){
		if (createAuthTextSelect.val() == 4) {
			createAuthTextInput.hide();
			createAuthTextPasswordInput.val("");
			createAuthTextPasswordInput.css("display", "inline");
			createAuthText.append(createAuthTextInputLength);
		} else if (createAuthTextSelect.val() == 2) {
			createAuthTextInputLength.remove();
			createAuthTextInput.val("");
			createAuthTextInput.css("display", "inline");
			createAuthTextPasswordInput.hide();
		} else {
			createAuthTextInputLength.remove();
			createAuthTextPasswordInput.hide();
			createAuthTextInput.hide();
		}
	});
	
	createAuthTextPasswordInput.bind('keyup', function(){
		cmnDivExpCtxLengthCk(createAuthTextPasswordInput, createAuthTextInputLength, passwordLength);
	});
	
	createDescTextInput.bind('keyup', function(){
		cmnDivExpCtxLengthCk(createDescTextInput, createDescInfoTextLength, nameDescriptionLength);
	});
	
	createDescTextInput.bind('change', function(){
		createDescTextInput.css("border", "1px solid #D9D9DA");
	});
	
	createTitleTextInput.bind('keyup', function(){
		cmnDivExpCtxLengthCk(createTitleTextInput, createTitleTextInputLength, nameLength);
	});
	
	createTitleTextInput.bind('change', function(){
		createTitleTextInput.css("border", "1px solid #D9D9DA");
	});
	
	closeBtn.bind('click', function(){
		removeDialog();
	});
	
	confirmBtn.bind('click', function(){
		var nameContext = createTitleTextInput.val();
		var descContext = createDescTextInput.val();
		var authorize = createAuthTextSelect.val();
		var additional = "";
		
		if (authorize == undefined)
			authorize = 0;
		if (authorize == 4)
			additional = createAuthTextPasswordInput.val();
		else if (authorize == 2)
			additional = createAuthTextInput.val();
		
		var inputOK = true;
		if (nameContext.replace(/(^\s*)|(\s*$)/g,"") == "") {
			createTitleTextInput.css("border", "1px solid red");
			inputOK = false;
		}
		if (descContext.replace(/(^\s*)|(\s*$)/g,"") == "") {
			createDescTextInput.css("border", "1px solid red");
			inputOK = false;
		}
		if (inputOK) {
			removeDialog();
			callback(nameContext, descContext, authorize, additional);
		} else
			return;
	});
}

function editDescription(idtype, type, name, description, author, level, additional, callback) {
	// idtype : 编辑的id（如相册id）
	// type   : 何种编辑（如相册、图片）
	// name   : 相册或者图片的名称
	// description : 描述
	// author : true为有权限设置, false为没有权限设置
	// level  : 权限设置, 当author为true 时有效
	// additional : 当权限设置为密码查看或指定用户查看时存储的内容
	var typeName = "";
	if (type == "pic")
		typeName = "图片";
	else if (type == "album")
		typeName = "相册";
		
	
	createDialog(typeName + '编辑', typeName, '修改', author, callback);
	var txtName = $($("#tableDivInfoBody span input")[0]);
	var txtDescription = $("#tableDivInfoBody span textarea");
	var lblNameLength = $("#tableDivInfoBody span label");
	var lblDescriptionLenght = $($("#tableDivInfoBody div span")[4]);
	
	txtName.val(name);
	cmnDivExpCtxLengthCk(txtName, lblNameLength, 40);
	txtDescription.val(description);
	cmnDivExpCtxLengthCk(txtDescription, lblDescriptionLenght, 100);
	
	// author true, setLevel
	if (author == true) {
		var selectAuthor = $("#tableDivInfoBody span select");
		selectAuthor.val(level);
		
		if (level == 2) {
			var txtUsers = $($("#tableDivInfoBody span input")[2]);
			txtUsers.css("display", "inline");
			txtUsers.val(additional);
		} else if (level == 4) {
			var txtPassword = $($("#tableDivInfoBody span input")[1]);
			var lblPasswordLength = $("<span>0/10</span>");;
			var authSpan = $($("#tableDivInfoBody span")[6]);
			authSpan.append(lblPasswordLength);
			txtPassword.css("display", "inline");
			txtPassword.val(additional);
			cmnDivExpCtxLengthCk(txtPassword, lblPasswordLength, 10);
		}
	}
}

function showEditDialog(title, content, callback) {
	var confirmBtn = $("<input class='input-submit' type='button' value='确定'/>");
	
	$("#divMsgDlg").html("<table cellspacing='0'><tr><td id='topLeft'></td>" + 
		"<td class='topBar'></td><td id='topRight'></td></tr><tr>" +
		"<td class='verticalBar'></td><td><h2><span>" + title + "</span></h2>" +
		"<div id='tableDivInfo'><div id='tableDivInfoBody'>" + content + "</div><div id='tableDivInfoButton'>" +
		"<input class='input-submit' onclick='removeDialog()' type='button' value='取消'/>" +
		"</div></div></td><td class='verticalBar'></td></tr><tr><td id='bottomLeft'></td>" +
		"<td class='topBar'></td><td id='bottomRight'></td></tr></table>");
	$('#tableDivInfoButton').prepend(confirmBtn);
	$('.verticalBar').css('height', '183px');
	$('#tableDivInfo').css('height', '155px');
	$('#tableDivInfoBody').css('height', '125px');
	
	var description = $("<label>0/100</label>")
	$('#tableDivInfoBody').append(description);
	description.css('color', 'gray').css('margin-left', '80px');
	
	confirmBtn.bind('click', function(){
		callback();
		removeDialog();
	});
}

function shareDialog(myId, otherId, otherType, callback) {
	$("#divMsgDlg").html("<table cellspacing='0'><tr><td id='topLeft'></td>" + 
		"<td class='topBar'></td><td id='topRight'></td></tr><tr>" +
		"<td class='verticalBar'></td><td><h2><span>分享</span></h2>" +
		"<div id='tableDivInfo'><div id='tableDivInfoBody' class='shareDivInfoBody'>" +
		"<img src='http://apis.iyuba.com/v2/api.iyuba?protocol=10005&uid=" + myId +
		"'/><textarea></textarea></div><div id='divDialogInfo'></div><div id='tableDivInfoButton'>" +
		"<input class='input-submit' onclick='removeDialog()' type='button' value='取消'/>" +
		"</div></div></td><td class='verticalBar'></td></tr><tr><td id='bottomLeft'></td>" +
		"<td class='topBar'></td><td id='bottomRight'></td></tr></table>");
	
	var confirmBtn = $("<input class='input-submit' type='button' value='确定'/>");
	var closeBtn = $("<span id='shareDialog'>×</span>");
	var stringLength = $("<div>0/500</div>");
	var express = $("<div><img src='/profile/img/express.png'/></div>");
	var expressList = $("<div></div>");
	var tblTextarea = $("#tableDivInfoBody textarea");
	
	$('#tableDivInfoButton').prepend(confirmBtn);
	$('h2').prepend(closeBtn);
	$('#divDialogInfo').prepend(stringLength);
	$('#divDialogInfo').prepend(expressList);
	$('#divDialogInfo').prepend(express);
	
	// 添加表情函数
	addExpresses(expressList);
	
	stringLength.attr('id', 'divDlgLetterLength');
	expressList.attr('id', 'divDlgExpressList');
	express.attr('id', 'divDlgExpress');
	
	$('#tableDivInfo').css('height', '180px');
	$('.verticalBar').css('height', '200px');
	$('#tableDivInfoBody').css('height', '95px');
	
	tblTextarea.bind('keyup', function(){
		cmnDivExpCtxLengthCk(tblTextarea, stringLength, 500);
	});
	
	tblTextarea.bind('change', function(){
		tblTextarea.css("border", "1px solid #D9D9DA");
	});
	
	confirmBtn.bind('click', function(){
		var context = tblTextarea.val();
		if (context.replace(/(^\s*)|(\s*$)/g,"") == "") {
			tblTextarea.css("border", "1px solid red");
			return;
		}
		removeDialog();
		callback(myId, otherId, otherType, context);
	});
	
	$('#divDlgExpressList img').bind('click', function(){
		tblTextarea.val(tblTextarea.val() + $(this).attr('title'));
		cmnDivExpCtxLengthCk(tblTextarea, stringLength, 500);
	});
	
	closeBtn.bind('click', function(){
		removeDialog();
	});
	
	express.bind('click', function(){
		expressList.css('display') == 'none' ? expressList.show(500) : expressList.hide(500);
	})
}

function addExpresses(obj) {
	var i;
	for (i = 30; i > 0; i--) {
		obj.prepend("<img src='/profile/image/face/" + i +".gif' " +
					"title='" + EXPRESS_LIB[exp_status]['em' + i] + "'/>");
	}
}

function cmnDivExpCtxLengthCk(tblTextarea, stringLength, len) {
	var context = tblTextarea.val();
	var ctxLength = context.length;
	if (ctxLength < len)
		stringLength.html(ctxLength + "/" + len);
	else{
		stringLength.html(len + "/" + len);
		context = context.substring(0, len);
		tblTextarea.val(context);
	}
}

function removeDialog() {
	$("#divMsgDlg").html("");
}

//*******************************************************************************
// 以下都是需要自己写的函数
//*******************************************************************************
function aa(id) {
	alert(id + "已删除");
}

function bb(id, otherid, otherType, ctx) {
	alert("用户：" + id + "\n分享的是：" + otherType + "\n其id是：" + otherid + "\n分享的评论是：" + ctx);
}

function cc(name, desc, level, additional) {
	alert("创建的对象是：" + name + "\n其描述是：" + desc + "\n权限是：" + level + "\n权限附加值是：" + additional);
}
function dd(name, desc, level, additional) {
	alert("修改的对象是：" + name + "\n其描述是：" + desc + "\n权限是：" + level + "\n权限附加值是：" + additional);
}