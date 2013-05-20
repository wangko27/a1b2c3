<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("favorite.list.pagetitle")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
<meta name="Author" content="SHOP++ Team" />
<meta name="Copyright" content="SHOP++" />
<link rel="icon" href="favicon.ico" type="image/x-icon" />
<link href="${base}/template/shop/css/base.css" rel="stylesheet" type="text/css" />
<link href="${base}/template/shop/css/shop.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/template/common/js/jquery.js"></script>
<script type="text/javascript" src="${base}/template/common/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/base.js"></script>
<script type="text/javascript" src="${base}/template/shop/js/shop.js"></script>
<!--[if lte IE 6]>
	<script type="text/javascript" src="${base}/template/common/js/belatedPNG.js"></script>
	<script type="text/javascript">
		// 解决IE6透明PNG图片BUG
		DD_belatedPNG.fix(".belatedPNG");
	</script>
<![endif]-->
<script type="text/javascript">
$().ready( function() {
	
	var $deleteFavorite = $("#favoriteTable .deleteFavorite");
	
	// 删除收藏
	$deleteFavorite.click( function() {
		var $this = $(this);
		var favoriteId = $this.attr("favoriteId");
		$.dialog({type: "warn", content: "${bundle("item.delete.tipmessage")}", ok: "${bundle("button.name.confirm")}", cancel: "${bundle("button.name.cancel")}", modal: true, okCallback: deleteFavoriteGoods});
		function deleteFavoriteGoods() {
			$.ajax({
				url: "favorite!ajaxDelete.action",
				data: {id: favoriteId},
				type: "POST",
				dataType: "json",
				cache: false,
				success: function(data) {
					$.message({type: data.status, content: data.message});
					$this.parent().parent().remove();
				}
			});
		}
		return false;
	});
	
});
</script>
</head>
<body class="memberCenter">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body favoriteList">
		<div class="bodyLeft">
			<div class="memberInfo">
				<div class="top"></div>
				<div class="middle">
					<p>${bundle("deposit.welcome.message")}&nbsp;&nbsp;<span class="username">${loginMember.username}</span>&nbsp;&nbsp;[<a class="userLogout" href="member!logout.action"">${bundle("button.name.logout")}</a>]</p>
					<p>${bundle("member.rank")} <span class="red"> ${loginMember.memberRank.name}</span></p>
				</div>
				<div class="bottom"></div>
			</div>
			<div class="blank"></div>
			<div class="memberMenu">
				<div class="top">
					<a href="member_center!index.action">${bundle("member.homepage")}</a>
				</div>
				<div class="middle">
					<ul>
	                	<li class="order">
	                    	<ul>
	                        	<li><a href="order!list.action">${bundle("member.menu.order")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="category favorite">
	                    	<ul>
	                        	<li><a href="favorite!list.action">${bundle("member.menu.favorite")}</a></li>
	                        	<li><a href="goods_notify!list.action">${bundle("member.menu.goods.notify")}</a></li>
	                        </ul>
	                    </li>
	                  	<li class="message">
	                    	<ul>
	                        	<li><a href="message!send.action">${bundle("member.menu.message.send")}</a></li>
	                            <li><a href="message!inbox.action">${bundle("member.menu.message.inbox")}</a></li>
	                            <li><a href="message!draftbox.action">${bundle("member.menu.message.draftbox")}</a></li>
	                            <li><a href="message!outbox.action">${bundle("member.menu.message.outbox")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="profile">
	                    	<ul>
	                        	<li><a href="profile!edit.action">${bundle("member.menu.profile.profile")}</a></li>
	                            <li><a href="password!edit.action">${bundle("member.menu.profile.password")}</a></li>
	                            <li><a href="receiver!list.action">${bundle("member.menu.profile.receiver")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="deposit">
	                    	<ul>
	                    		<li class="current"><a href="deposit!list.action">${bundle("member.menu.deposit.my")}</a></li>
	                        	<li><a href="deposit!recharge.action">${bundle("member.menu.deposit.recharge")}</a></li>
	                        </ul>
	                    </li>
	                </ul>
				</div>
				<div class="bottom"></div>
			</div>
		</div>
		<div class="bodyRight">
			<div class="memberCenterDetail">
				<div class="top">${bundle("favorite.list.title")}</div>
				<div class="middle">
					<div class="blank"></div>
					<table id="favoriteTable" class="listTable">
						<tr>
							<th>${bundle("favorite.list.header.pic")}</th>
							<th>${bundle("favorite.list.header.name")}</th>
							<th>${bundle("favorite.list.header.price")}</th>
							<th>${bundle("favorite.list.header.operation")}</th>
						</tr>
						<#list pager.result as favoriteGoods>
							<tr>
								<td>
									<a href="${base}${favoriteGoods.htmlPath}" class="goodsImage" target="_blank">
										<img src="${base}${favoriteGoods.defaultThumbnailGoodsImagePath}" />
									</a>
								</td>
								<td>
									<a href="${base}${favoriteGoods.htmlPath}" target="_blank">${favoriteGoods.name}</a>
								</td>
								<td>
									${favoriteGoods.price?string(currencyFormat)}
								</td>
								<td>
									<a href="#" class="deleteFavorite" favoriteId="${favoriteGoods.id}" title="${bundle("button.name.delete")}">${bundle("button.name.delete")}</a>
								</td>
							</tr>
						</#list>
					</table>
					<div class="blank"></div>
         			<@pagination pager=pager baseUrl="/shop/favorite!list.action">
         				<#include "/WEB-INF/template/shop/pager.ftl">
         			</@pagination>
				</div>
				<div class="bottom"></div>
			</div>
		</div>
		<div class="blank"></div>
		<#include "/WEB-INF/template/shop/friend_link.ftl">
	</div>
	<div class="blank"></div>
	<#include "/WEB-INF/template/shop/footer.ftl">
</body>
</html>