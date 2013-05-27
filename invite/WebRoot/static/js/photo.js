$(document).ready(function(){
	var _divPhotoManagement = $("#divPhotoManagement");
	var _divPhotoReply = $("#divPhotoReply");
	var _divPhotoShare = $("#divPhotoShare");
	var _divPhotoReplyContext = $("#divPhotoReplyContext textarea");
	var _divPhotoReplyBtnconfirm = $("#divPhotoReplyBtnconfirm");
	var _divPhotoLblReply = $(".div-photo-lbl-reply");
	var _divPhotoLblDelete = $(".div-photo-lbl-delete");
	var _divSubPhotoPrev = $("#divSubPhotoPrev");
	var _divSubPhotoNext = $("#divSubPhotoNext");
	
	_divPhotoManagement.bind('mouseover', function(){
		showList();
	});
	_divPhotoManagement.bind('mouseout', function(){
		hideList();
	});
	_divPhotoReply.bind('click', function(){
		divLblReply();
	});
	_divPhotoShare.bind('click', function(){
		// 928(uid) 1(picid) 需要通过jquery获取页面相关的值
		// shareDialog(928, 1, 'pic', successShare)
		
		$.ajax({
			url:'/photo/share',
			type:'POST',
			data: 'picid=' + $('#picid').val(),
			dataType: 'json',
	       	success: function(msg) {
       			successDialog('', msg.msg);
	       	}
		});
	});
	_divPhotoReplyContext.bind('keyup', function(){
		ctxLength();
	});
	_divPhotoReplyContext.bind('change', function(){
		ctxColor();
	});
	_divPhotoReplyBtnconfirm.bind('click', function(){
		photoSubmit();
	});
	_divPhotoLblReply.bind('click', function(){
		photoReply($(this).attr('id').replace("divPhotoLblReply", ""));
	});
	/*
	_divPhotoLblDelete.bind('click', function(){
		deleteDialog($(this).attr('id')
			.replace("divPhotoLblDelete", ""),'此条评论', successDelete);
	});
	*/
	_divSubPhotoPrev.bind('mouseover', function(){
		_divSubPhotoPrev.css("opacity", "1").css("filter", "alpha(opacity:100)");
		_divSubPhotoPrev.children()[0].src = "/img/album/leftClick.png";
	});
	_divSubPhotoPrev.bind('mouseout', function(){
		_divSubPhotoPrev.css("opacity", "0.3").css("filter", "alpha(opacity:30)");
		_divSubPhotoPrev.children()[0].src = "/img/album/left.png";
	});
	_divSubPhotoPrev.bind('click', function(){
		photoPrev();
	});
	_divSubPhotoNext.bind('mouseover', function(){
		_divSubPhotoNext.css("opacity", "1").css("filter", "alpha(opacity:100)");
		_divSubPhotoNext.children()[0].src = "/img/album/rightClick.png";
	});
	_divSubPhotoNext.bind('mouseout', function(){
		_divSubPhotoNext.css("opacity", "0.3").css("filter", "alpha(opacity:30)");
		_divSubPhotoNext.children()[0].src = "/img/album/right.png";
	});
	_divSubPhotoNext.bind('click', function(){
		photoNext();
	});
});

function showList() {
	var p = $("#divMyPhotoOperateList p");
	$("#divMyPhotoOperateList").show();
	$("#divMyPhotoOperateList").bind('mouseover', function(){
		$("#divMyPhotoOperateList").show();
	});
	$("#divMyPhotoOperateList").bind('mouseout', function(){
		hideList();
	});
	// 显示列表绑定
	p.bind('mouseover', function(){
		$(this).css("background-color", "#C2C3C3");
	});
	p.bind('mouseout', function(){
		$(this).css("background-color", "#FFFFFF");
	});
	
	// 绑定其他事件
	p.unbind('click');
	$(p[0]).bind('click', function(){
		//moveAlbum();
		hideList();
	});
	$(p[1]).bind('click', function(){
		//setImgSrc();
		hideList();
	});
	$(p[2]).bind('click', function(){
		//setPage();
		hideList();
	});
	$(p[3]).bind('click', function(){
		//rotatePic();
		hideList();
	});
	$(p[4]).bind('click', function(){
		//deletePic();
		hideList();
	});
}

function hideList() {
	$("#divMyPhotoOperateList").hide();
}

function divLblReply() {
	location.href="#divSubPhotoCtxInfo";
}

function photoReply(obj) {
	var username = $("#username" + obj).html();
	var ctx = $("#divPhotoReplyContext textarea");
	var lbl = $("#divPhotoReplyCtxLength");
	var temp = ctx.val();
	if(temp.indexOf("回复") != 0 && temp.indexOf(" : ") > 1)
		ctx.val("回复" + username + temp);
	else
		ctx.val("回复" + username + temp.substring(temp.indexOf(" : ") + 3));
	cmnDivExpCtxLengthCk(ctx, lbl, 200);
	divLblReply();
}

function ctxLength() {
	var ctx = $("#divPhotoReplyContext textarea");
	var lbl = $("#divPhotoReplyCtxLength");
	cmnDivExpCtxLengthCk(ctx, lbl, 200);
}

function ctxColor() {
	var ctx = $("#divPhotoReplyContext textarea");
	ctx.css("border", "1px solid #125D91");
}

/**************事件处理函数*******************/
function moveAlbum() {
	alert("moveAlbum function...");
}

function setImgSrc() {
	alert("setImgSrc function...");
}

function setPage() {
	alert("setPage function...");
}

function rotatePic() {
	alert("rotate function...");
}

function deletePic() {
	//alert("deletePic function...");
	deleteDialog(1, '这张照片', successDelete);
}

function photoSubmit() {
	var ctx = $("#divPhotoReplyContext textarea");
	if (ctx.val().replace(/(^\s*)|(\s*$)/g,"") == "") {
		ctx.css("border", "1px solid red");
		return;
	} else {
	/**************此处写评论处理信息*******************/
		var data = $('#commentForm').serialize();
		$.ajax({
			url:'/comment',
			type:'POST',
			data: data,
			success: function(html){
				$('#divPhotoReplys').append(html);
				var commentCount = Number($('#commentCount').html());
				$('#commentCount').html(commentCount + 1);
				$('#commentArea').val("");
			}
		});
	}
}

function photoPrev() {
	var previousId = $('#previousId').val();
	if(Number(previousId) != 0) {
		document.location.href = '/photo/' + previousId;
	}
}

function photoNext() {
	var nextId = $('#nextId').val();
	if(Number(nextId) != 0) {
		document.location.href = '/photo/' + nextId;
	}
}
/**********************操作成功的回调函数****************/
function successShare(myId, otherId, otherType, context) {
	alert(myId + "\n" + otherId + "\n" + otherType + "\n" + context);
}

function successDelete(id) {
	// 删除照片和评论都在此函数
	// 删除照片对应的jsp位置 : line 39 绑定事件在本文件的 37行 和 92行
	// 删除评论对应的jsp位置 : line 72
	alert(id + "已删除");
}
