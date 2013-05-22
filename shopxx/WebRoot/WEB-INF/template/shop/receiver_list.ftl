<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("goods.order.ship.address")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
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

	var $deleteReceiver = $("#receiverTable .deleteReceiver");
	
	// 删除
	$deleteReceiver.click( function() {
		var $this = $(this);
		var receiverId = $this.attr("receiverId");
		$.dialog({type: "warn", content: "${bundle("goods.notify.javascript.deleteNotice")}?", ok: "${bundle("goods.common.ok")}", cancel: "${bundle("goods.common.cancel")}", modal: true, okCallback: deleteReceiver});
		function deleteReceiver() {
			$.ajax({
				url: "receiver!ajaxDelete.action",
				data: {id: receiverId},
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

})
</script>
</head>
<body class="memberCenter">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body receiverList">
		<div class="bodyLeft">
			<div class="memberInfo">
				<div class="top"></div>
				<div class="middle">
					<p>${bundle("goods.notify.memberCenter.welcome")}!&nbsp;&nbsp;<span class="username">${loginMember.username}</span>&nbsp;&nbsp;[<a class="userLogout" href="member!logout.action"">${bundle("goods.common.logout")}</a>]</p>
					<p>${bundle("goods.notify.memberCenter.memberLevel")}: <span class="red"> ${loginMember.memberRank.name}</span></p>
				</div>
				<div class="bottom"></div>
			</div>
			<div class="blank"></div>
			<div class="memberMenu">
				<div class="top">
					<a href="member_center!index.action">${bundle("goods.notify.memberCenter.mainPage")}</a>
				</div>
				<div class="middle">
					<ul>
	                	<li class="order">
	                    	<ul>
	                        	<li><a href="order!list.action">${bundle("goods.notify.memberCenter.myOrder")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="category favorite">
	                    	<ul>
	                        	<li><a href="favorite!list.action">${bundle("goods.notify.memberCenter.favorite")}</a></li>
	                        	<li><a href="goods_notify!list.action">${bundle("goods.notify.memberCenter.notify")}</a></li>
	                        </ul>
	                    </li>
	                  	<li class="message">
	                    	<ul>
	                        	<li><a href="message!send.action">${bundle("goods.notify.memberCenter.message.send")}</a></li>
	                            <li><a href="message!inbox.action">${bundle("goods.notify.memberCenter.message.inbox")}</a></li>
	                            <li><a href="message!draftbox.action">${bundle("goods.notify.memberCenter.message.draftbox")}</a></li>
	                            <li><a href="message!outbox.action">${bundle("goods.notify.memberCenter.message.outbox")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="profile">
	                    	<ul>
	                        	<li><a href="profile!edit.action">${bundle("goods.notify.memberCenter.profile.profile")}</a></li>
	                            <li><a href="password!edit.action">${bundle("goods.notify.memberCenter.profile.password")}</a></li>
	                            <li class="current"><a href="receiver!list.action">${bundle("goods.notify.memberCenter.profile.receiver")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="deposit">
	                    	<ul>
	                    		<li><a href="deposit!list.action">${bundle("goods.notify.memberCenter.deposit.store")}</a></li>
	                        	<li><a href="deposit!recharge.action">${bundle("goods.notify.memberCenter.deposit.charge")}</a></li>
	                        </ul>
	                    </li>
	                </ul>
				</div>
				<div class="bottom"></div>
			</div>
		</div>
		<div class="bodyRight">
			<div class="memberCenterDetail">
				<div class="top">${bundle("goods.order.ship.address")}</div>
				<div class="middle">
					<div class="blank"></div>
					<a class="addButton" href="${base}/shop/receiver!add.action" hidefocus>${bundle("goods.order.ship.address.add")}</a>
					<div class="blank"></div>
					<table id="receiverTable" class="listTable">
						<tr>
							<th>${bundle("goods.order.ship.name")}</th>
							<th>${bundle("goods.common.address")}</th>
							<th>${bundle("goods.order.ship.phone")}</th>
							<th>${bundle("goods.common.default")}</th>
							<th>${bundle("goods.notify.memberCenter.goods.operation")}</th>
						</tr>
						<#list receiverSet as receiver>
							<tr>
								<td>
									${receiver.name}
								</td>
								<td>
									${receiver.area.displayName}${receiver.address}
								</td>
								<td>
									${receiver.phone}
								</td>
								<td>
									<#if receiver.isDefault>${bundle("goods.common.yes")}<#else>${bundle("goods.common.no")}</#if>
								</td>
								<td>
									<a href="${base}/shop/receiver!edit.action?id=${receiver.id}">${bundle("goods.common.edit")}</a>
									<a href="#" class="deleteReceiver" receiverId="${receiver.id}">${bundle("goods.common.delete")}</a>
								</td>
							</tr>
						</#list>
					</table>
					<div class="blank"></div>
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