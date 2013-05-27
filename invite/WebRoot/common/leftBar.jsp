<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="left"><!--body左部-->
	<div id="newguide"><!--新手指南-->
		<a href="#" class="v3">
			<img src="${urlStatic}/static/images/guide.png" width="25px" height="29px" border="0" id="guide_pic"/>
			<div id="guide_word">
			新手指南
			</div>
		</a>
	</div>
	<div class="leftbule">
		<a href="javascript:main(${cookie.iyuba_ID.value })" class="v2">
			<img src="${urlStatic}/static/images/mainpage.png" width="26px" height="22px" border="0" id="mainpage_pic"/>
			<div id="mainpage_word">
			首页
			</div>
		</a>
	</div>
	<div class="leftbule">
		<a href="javascript:profile(${cookie.iyuba_ID.value })" class="v2">
			<img src="${urlStatic}/static/images/mypage.png" width="23px" height="22px" border="0" id="mypage_pic"/>
			<div id="mypage_word">
			我的主页
			</div>
		</a>
	</div>
	<div class="leftwhite">
		<div id="iyu">
			<a href="javascript:goStatus(${cookie.iyuba_ID.value}, '${cookie.iyuba_ZH.value}')" class="v3">i&nbsp;语</a>
		</div>
	</div>
	<div class="leftwhite">
		<div id="wordsnote">
			<a href="javascript:goWords(${cookie.iyuba_ID.value })" class="v3">生词本</a>
		</div>
	</div>
	<div class="leftwhite">
		<div id="album">
			<a href="javascript:goAlbum(${cookie.iyuba_ID.value })" class="v3">相册</a>
		</div>
	</div>
	<div class="leftwhite">
		<div id="log">
			<a href="javascript:goBlog(${cookie.iyuba_ID.value })" class="v3">日志</a>
		</div>
	</div>
	<div class="leftwhite">
		<div id="share">
			<a href="#" class="v3">分享</a>
		</div>
	</div>
	<div class="leftbule">
		<a href="#" class="v2">
			<img src="${urlStatic}/static/images/attention.png" width="25px" height="19px" border="0" id="attention_pic"/>
			<div id="attention_word">
			关注
			</div>
		</a>
	</div>
	<div class="leftwhite">
		<div id="myattention">
			<a href="#" class="v3">我关注的</a>
		</div>
	</div>
	<div class="leftwhite">
		<div id="eachotherattention">
			<a href="#" class="v3">互相关注</a>
		</div>
	</div>
	<div class="leftwhite">
		<div id="quietlyattention">
			<a href="#" class="v3">悄悄关注</a>
		</div>
	</div>
	<div class="leftbule">
		<a href="javascript:application(${cookie.iyuba_ID.value})" class="v2">
			<img src="${urlStatic}/static/images/app.png" width="17px" height="24px" border="0" id="app_pic"/>
			<div id="app_word">
			应用
			</div>
		</a>
	</div>
	<div class="leftwhite">
		<div id="bbc">
			<a href="#" class="v3">BBC六分钟英语</a>
		</div>
	</div>
	<div class="leftwhite">
		<div id="voa">
			<a href="#" class="v3">VOA常速英语</a>
		</div>
	</div>
	<div class="leftwhite">
		<div id="get">
			<a href="#" class="v3">英语四六级</a>
		</div>
	</div>
	<div class="leftbule">
		<a href="#" class="v2">
			<img src="${urlStatic}/static/images/fans.png" width="26px" height="22px" border="0" id="fans_pic"/>
			<div id="fans_word">
			粉丝
			</div>
		</a>
	</div>
	<div class="leftbule">
		<a href="#" class="v2">
			<img src="${urlStatic}/static/images/invite.png" width="24px" height="21px" border="0" id="invite_pic"/>
			<div id="invite_word">
			邀请
			</div>
		</a>
	</div>
	<div class="leftbule">
		<a href="#" class="v2">
			<img src="${urlStatic}/static/images/private_letter.png" width="27px" height="20px" border="0" id="private_letter_pic"/>
			<div id="private_letter_word">
			私信
			</div>
		</a>
	</div>
	<div class="leftbule">
		<a href="#" class="v2">
			<img src="${urlStatic}/static/images/findsb.png" width="26px" height="23px" border="0" id="findsb_pic"/>
			<div id="findsb_word">
			找人
			</div>
		</a>
	</div>
</div>