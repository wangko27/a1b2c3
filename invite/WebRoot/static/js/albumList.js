$(document).ready(function(){
	var _divMyAlbumList = $("#divMyAlbumList");
	var _divMyFriendAlbumList = $("#divMyFriendAlbumList");
	var _divUploadPic = $("#divUploadPic");
	var _divCreateAlbum = $("#divCreateAlbum");
	var _divTimeSort = $("#divTimeSort");
	
	var _divAlbumPic = $(".div-album-pic");
	var _liAlbumName = $(".li-album-name label");
	var _liAlbumEdit = $(".li-album-edit");
	var _liAlbumDelete = $(".li-album-delete");
	
	/*
	_divMyAlbumList.bind('click', function(){
		if(_divMyAlbumList.attr("class") == "div-album-unselect"){
			_divMyAlbumList.attr("class", "div-album-selected");
			_divMyFriendAlbumList.attr("class", "div-album-unselect");
			changeMyAlbum();
		}
	});
	_divMyFriendAlbumList.bind('click', function(){
		if(_divMyFriendAlbumList.attr("class") == "div-album-unselect"){
			_divMyFriendAlbumList.attr("class", "div-album-selected");
			_divMyAlbumList.attr("class", "div-album-unselect");
			changeFriendsAlbum();
		}
	});
	
	_divUploadPic.bind('click', function(){
		gotoUploadPic();
	});
	*/
	_divCreateAlbum.bind('click', function(){
		createAlbum();
	});
	_divTimeSort.bind('click', function(){
		albumSort();
	});
	
	/*
	_divAlbumPic.bind('click', function(){
		showAlbumsPic($(this).parent().attr('id').replace('divAlbum', ''));
	});
	_liAlbumName.bind('click', function(){
		showAlbumsPic($(this).parent().parent().parent().attr('id').replace('divAlbum', ''));
	});
	*/
	_liAlbumEdit.bind('click', function(){
		editAlbum($(this).parent().parent().parent().attr('id').replace('divAlbum', ''));
	});
	_liAlbumDelete.bind('click', function(){
		deleteAlbum($(this).parent().parent().parent().attr('id').replace('divAlbum', ''));
	});
});

function changeFriendsAlbum() {
	alert("changeFriendsAlbum");
}

function changeMyAlbum() {
	document.location.href = '/album/list/0';
}

function gotoUploadPic() {
	alert("gotoUploadPic");
}

function createAlbum() {
	createDialog('创建相册', '相册', '创建', true, successCreate);
}

function albumSort() {
	alert("排序");
}

function showAlbumsPic(id) {
	alert("showAlbumsPic 进入相册其id为 :" + id);
}

function editAlbum(id) {
	alert("editAlbum 开始编辑相册 :" + id);
}

function deleteAlbum(id) {
	deleteDialog(id, '该相册', successDelete);
}
/**********************创建相册成功的回调函数******************************/
function successCreate(nameContext, descContext, authorize, additional) {
	alert("创建的对象是：" + nameContext + "\n其描述是：" + descContext + "\n权限是：" + authorize + "\n权限附加值是：" + additional);
}

function successDelete(id) {
	alert("相册id:" + id + " 删除成功");
}