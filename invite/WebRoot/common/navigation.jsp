<%@ page language="java" pageEncoding="utf-8"%>
<div align="center" id="navigation" style="width:100%; font-family: MicroSoft YaHei; z-index:1999; position: fixed; top: expression(this.offsetParent.scrollTop); _position: absolute;">
	<div style="width:1000px;">
		<div id="mainpage1" >
			<a href="javascript:main(${cookie.iyuba_ID.value })" class="v2">首页</a>
		</div>
		<div id="mypage">
			<a href="javascript:profile(${cookie.iyuba_ID.value })" class="v2">个人主页</a>
		</div>
		<div id="friend">
			<a href="javascript:friend(${cookie.iyuba_ID.value })" class="v2">关注</a>
		</div>
		<div id="app">
			<a href="javascript:application(${cookie.iyuba_ID.value })" class="v2">应用</a>
		</div>
		<div id="forum">
			<a href="javascript:forum(${cookie.iyuba_ID.value })" class="v2">论坛</a>
		</div>
		<form name="searchform"><!--搜索-->
			<input type="text" name="search" id="search"/>        
			<div id="search_pic">
				<a href="javascript:search()">
					<img src="/img/search.png" border="0"/>
				</a>
			</div>
		</form>
	</div>
</div>