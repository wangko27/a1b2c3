<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("goods.notify.memberCenter.message.inbox")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
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

	var $deleteMessage = $("#messageTable .deleteMessage");
	var $showMessage = $("#messageTable .showMessage");
	
	// 删除
	$deleteMessage.click( function() {
		var $this = $(this);
		var messageId = $this.attr("messageId");
		$.dialog({type: "warn", content: "${bundle("goods.notify.javascript.deleteNotice")}?", ok: "${bundle("goods.common.ok")}", cancel: "${bundle("goods.common.cancel")}", modal: true, okCallback: deleteMessage});
		function deleteMessage() {
			$.ajax({
				url: "message!ajaxDelete.action",
				data: {id: messageId},
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
	
	// 显示消息内容
	$showMessage.click( function() {
		var $this = $(this);
		var $messageContentTr = $this.parent().parent().next(".messageContentTr");
		if ($.trim($messageContentTr.find("td").text()) == "") {
			var messageId = $this.attr("messageId");
			$.ajax({
				url: "message!ajaxShowMessage.action",
				data: {"id": messageId},
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				beforeSend: function(data) {
					$messageContentTr.find("td").html('<span class="loadingIcon">&nbsp;</span> 加载中...');
				},
				success: function(data) {
					if (data.status == "success") {
						$messageContentTr.find("td").html(htmlEscape(data.content));
					} else {
						$.message({type: data.status, content: data.message});
					}
				}
			});
		}
		var $showMessageContentIcon = $this.prev("span");
		if ($showMessageContentIcon.hasClass("downIcon")) {
			$messageContentTr.show();
			$showMessageContentIcon.removeClass("downIcon").addClass("upIcon");
		} else {
			$messageContentTr.hide();
			$showMessageContentIcon.removeClass("upIcon").addClass("downIcon");
		}
		return false;
	});
	
})
</script>
<style type="text/css">
<!--

.messageInbox .messageContentTr {
	display: none;
	background-color: #fafafa;
}

.messageInbox .messageContentTr td {
	padding-left: 30px;
}

-->
</style>
</head>
<body class="memberCenter">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body messageInbox">
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
	                            <li class="current"><a href="message!inbox.action">${bundle("goods.notify.memberCenter.message.inbox")}</a></li>
	                            <li><a href="message!draftbox.action">${bundle("goods.notify.memberCenter.message.draftbox")}</a></li>
	                            <li><a href="message!outbox.action">${bundle("goods.notify.memberCenter.message.outbox")}</a></li>
	                        </ul>
	                    </li>
	                    <li class="profile">
	                    	<ul>
	                        	<li><a href="profile!edit.action">${bundle("goods.notify.memberCenter.profile.profile")}</a></li>
	                            <li><a href="password!edit.action">${bundle("goods.notify.memberCenter.profile.password")}</a></li>
	                            <li><a href="receiver!list.action">${bundle("goods.notify.memberCenter.profile.receiver")}</a></li>
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
				<div class="top">${bundle("goods.notify.memberCenter.message.inbox")}</div>
				<div class="middle">
					<div class="blank"></div>
					<table id="messageTable" class="listTable">
						<tr>
							<th>${bundle("goods.message.push.title")}</th>
							<th>${bundle("goods.message.reply.receiver")}</th>
							<th>${bundle("goods.message.read")}</th>
							<th>${bundle("goods.message.time")}</th>
							<th>${bundle("goods.notify.memberCenter.goods.operation")}</th>
						</tr>
						<#list pager.result as message>
							<tr>
								<td>
									<span class="downIcon">&nbsp;</span>
									<a href="#" class="showMessage" messageId="${message.id}">${message.title}</a>
								</td>
								<td>
									${(message.fromMember.username)!"${bundle("goods.content.bottom.comment.admin")}"}
								</td>
								<td>
									<#if message.isRead>
										${bundle("goods.common.yes")}
									<#else>
										<span class="red">${bundle("goods.common.no")}</span>
									</#if>
								</td>
								<td>
									${message.createDate?string("yyyy-MM-dd HH: mm")}
								</td>
								<td>
									<a href="${base}/shop/message!reply.action?id=${message.id}">${bundle("goods.common.reply")}</a>
									<a href="#" class="deleteMessage" messageId="${message.id}">${bundle("goods.common.delete")}</a>
								</td>
							</tr>
							<tr class="messageContentTr">
								<td colspan="5"></td>
							</tr>
						</#list>
					</table>
					<div class="blank"></div>
					<@pagination pager=pager baseUrl="/shop/message!inbox.action">
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