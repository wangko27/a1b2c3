<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("goods.notify.memberCenter")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
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
</head>
<body class="memberCenter">
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body memberCenterIndex">
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
				<div class="top">${bundle("goods.notify.memberCenter.mainPage")}</div>
				<div class="middle">
					<div class="blank"></div>
					<table class="listTable">
						<tr>
							<td colspan="4">
								${bundle("goods.notify.memberCenter.static")}[${loginMember.memberRank.name}]
								<#if loginMember.memberRank.preferentialScale != 100>
									<span class="red">[${bundle("goods.notify.memberCenter.off")}: ${loginMember.memberRank.preferentialScale}%]</span>
								</#if>
							</td>
						</tr>
						<tr>
							<th>${bundle("goods.notify.memberCenter.account.score")}</th>
							<td>${loginMember.score}</td>
							<th>${bundle("goods.notify.memberCenter.orderTotal")}</th>
							<td>
								${loginMember.orderSet?size}&nbsp;&nbsp;
								<a href="order!list.action">[${bundle("goods.notify.memberCenter.orderList")}]</a>
							</td>
						</tr>
						<tr>
							<th>${bundle("goods.notify.memberCenter.deposit.remain")}</th>
							<td>${loginMember.deposit?string(currencyFormat)}</td>
							<th>${bundle("goods.notify.memberCenter.message.unread")}</th>
							<td>
								${unreadMessageCount}&nbsp;&nbsp;
								<a href="message!inbox.action">[${bundle("goods.notify.memberCenter.message.inbox.show")}]</a>
							</td>
						</tr>
						<tr>
							<th>${bundle("goods.common.register.time")}</th>
							<td>${loginMember.createDate?string("yyyy-MM-dd HH:mm:ss")}</td>
							<th>${bundle("goods.common.login.last")}IP</th>
							<td>${loginMember.loginIp}</td>
						</tr>
					</table>
					<div class="blank"></div>
					<table class="listTable">
						<tr>
							<th>${bundle("goods.notify.memberCenter.goods.name")}</th>
							<th>${bundle("goods.notify.memberCenter.order.sn")}</th>
							<th>${bundle("goods.notify.memberCenter.order.time")}</th>
							<th>${bundle("goods.notify.memberCenter.order.price")}</th>
							<th>${bundle("goods.notify.memberCenter.order.status")}</th>
						</tr>
						<#list loginMember.orderSet as order>
							<tr>
								<td width="350">
									<a href="order!view.action?id=${order.id}">
										<span title="<#list order.productItemSet as productItem><#if productItem_index != 0>、</#if>${productItem.name}</#list>">
											<#list order.orderItemSet as orderItem>
												<#if orderItem_index != 0>、</#if>
												${orderItem.productName}
												<#if orderItem_index == 3 && orderItem_has_next>
													...<#break />
												</#if>
											</#list>
										</span>
									</a>
								</td>
								<td>
									<a href="order!view.action?id=${order.id}">${order.orderSn}</a>
								</td>
								<td>
									<span title="${order.createDate?string("yyyy-MM-dd HH:mm:ss")}">${order.createDate}</span>
								</td>
								<td>
									${order.totalAmount?string(currencyFormat)}
								</td>
								<td>
									<#if order.orderStatus != "completed" && order.orderStatus != "invalid">
										[${action.getText("PaymentStatus." + order.paymentStatus)}]
										[${action.getText("ShippingStatus." + order.shippingStatus)}]
									<#else>
										[${action.getText("OrderStatus." + order.orderStatus)}]
									</#if>
								</td>
							</tr>
							<#if (order_index + 1 > 10)>
								<#break />
							</#if>
						</#list>
						<tr>
							<td colspan="5">
								<a href="order!list.action">${bundle("goods.notify.memberCenter.order.more")}>></a>
							</td>
						</tr>
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