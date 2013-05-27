$(document).ready(function(){
	var _createDialog = $("#divAlbumCreate label");
	var _returnMyAlbum = $("#divAlbumReturn label");
	var _gotoAdd = $("#divPicGotoAdd");
	var _gotoUpload = $("#divPicGotoUpload");
	
	_createDialog.bind('click', function(){
		createDialog('创建相册', '相册', '创建', true, successCreate);
	});
	_returnMyAlbum.bind('click', function(){
		returnMyAlbum();
	});
	/*
	_gotoAdd.bind('click', function(){
		gotoAddPic();
	});
	_gotoUpload.bind('click', function(){
		gotoPicUpload();
	});
	*/
	
	var num = $(".div-upload-single-pic").length;
	var _textArea = $("textarea");
	_textArea.bind('keyup', function(){
		cmnDivExpCtxLengthCk($(this), $($(this).parent().next().children()[1]), 100);
	});
});

function gotoAddPic() {
	alert("继续添加");
}

function gotoPicUpload() {
	alert("开始上传");
}

function returnMyAlbum() {
	document.location.href = '/album/list/0';
}

/**********************创建相册成功的回调函数******************************/
function successCreate(nameContext, descContext, authorize, additional) {
	var data = 'albumname=' + nameContext + '&depict=' + descContext + '&friend=' + authorize;
	$.ajax({
       	type: 'POST',
       	url: 'http://photo.iyuba.com/album/',
       	data: data,
       	dataType: 'json',
       	success: function(msg) {
       		if(msg.status == 0){
       			$('#albumSelect').append('<option value="' + msg.id + '">' + nameContext + '</option>');
       			successDialog('', msg.msg);
       		} else {
       			successDialog('', msg.msg);
       		}
       	}
   	});
}