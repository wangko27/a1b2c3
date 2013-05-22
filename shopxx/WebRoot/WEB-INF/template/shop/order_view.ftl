<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("goods.order.view")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
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
	<div class="body orderList">
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
	                        	<li class="current"><a href="order!list.action">${bundle("goods.notify.memberCenter.myOrder")}</a></li>
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
				<div class="top">${bundle("goods.order.view")}[${order.orderSn}]</div>
				<div class="middle">
					<div class="blank"></div>
					<div class="operationInfo">
						<strong class="green">${bundle("goods.notify.memberCenter.order.status")} [${bundle("goods.notify.memberCenter.order.sn")}: ${order.orderSn}]</strong>
						<#if order.orderStatus == "unprocessed">
							<p class="red">${bundle("goods.order.deal")}</p>
						<#elseif order.orderStatus == "completed">
							<p class="red">${bundle("goods.order.complete")}</p>
						<#elseif order.orderStatus == "invalid">
							<p class="red">${bundle("goods.order.invalid")}</p>
						</#if>
						<#if order.orderStatus != "completed" && order.orderStatus != "invalid">
							<#if order.paymentConfig??>
								<#if order.paymentStatus == "unpaid">
									<form action="payment!submit.action" method="post">
										<#if order.paymentConfig.paymentConfigType == "deposit">
											<input type="hidden" name="paymentType" value="deposit" />
										<#elseif  order.paymentConfig.paymentConfigType == "offline">
											<input type="hidden" name="paymentType" value="offline" />
										<#else>
											<input type="hidden" name="paymentType" value="online" />
										</#if>
										<input type="hidden" name="order.id" value="${order.id}" />
										<p class="red">${bundle("goods.order.notcomplete")}</p>
										<input type="submit" class="formButton" value="${bundle("goods.payment.rightnow")}" />
									</form>
								<#elseif order.paymentStatus == "partPayment">
									<form action="payment!submit.action" method="post">
										<#if order.paymentConfig.paymentConfigType == "deposit">
											<input type="hidden" name="paymentType" value="deposit" />
										<#elseif  order.paymentConfig.paymentConfigType == "offline">
											<input type="hidden" name="paymentType" value="offline" />
										<#else>
											<input type="hidden" name="paymentType" value="online" />
										</#if>
										<input type="hidden" name="order.id" value="${order.id}" />
										<p class="red">${bundle("goods.order.notcomplete")}</p>
										<input type="submit" class="formButton" value="${bundle("goods.payment.remain")}" />
									</form>
								<#else>
									<p class="red">${action.getText("PaymentStatus." + order.paymentStatus)}</p>
								</#if>
							</#if>
							<#if order.shippingStatus != "unshipped">
								<p class="red">${action.getText("ShippingStatus." + order.shippingStatus)}</p>
							</#if>
						</#if>
					</div>
					<div class="blank"></div>
					<table class="listTable">
						<tr>
							<th colspan="4">${bundle("goods.order.ship.info")}</th>
						</tr>
						<tr>
							<td class="title">${bundle("goods.order.ship.name")}: </td>
							<td>${order.shipName}</td>
							<td class="title">${bundle("goods.order.ship.area")}: </td>
							<td>${order.shipArea.displayName}</td>
						</tr>
						<tr>
							<td class="title">${bundle("goods.order.ship.address")}: </td>
							<td>${order.shipAddress}</td>
							<td class="title">${bundle("goods.order.ship.zipcode")}: </td>
							<td>${order.shipZipCode}</td>
						</tr>
						<tr>
							<td class="title">${bundle("goods.order.ship.phone")}: </td>
							<td>${order.shipPhone}</td>
							<td class="title">${bundle("goods.order.ship.mobile")}: </td>
							<td>${order.shipMobile}</td>
						</tr>
						<tr>
							<td class="title">${bundle("goods.order.ship.addition")}: </td>
							<td colspan="3">${order.memo}</td>
						</tr>
					</table>
					<div class="blank"></div>
					<table class="listTable">
						<tr>
							<th colspan="4">${bundle("goods.payment.info")}</th>
						</tr>
						<tr>
							<td class="title">${bundle("goods.payment.delivery")}: </td>
							<td>${order.deliveryTypeName}</td>
							<td class="title">${bundle("goods.payment.way")}: </td>
							<td>${order.paymentConfigName}</td>
						</tr>
						<tr>
							<td class="title">${bundle("goods.order.weight")}: </td>
							<td>${order.totalProductWeight} ${bundle("goods.common.unit.gram")}</td>
							<td class="title">${bundle("goods.order.price")}: </td>
							<td><span class="red">${order.deliveryFee?string(currencyFormat)}</span></td>
						</tr>
					</table>
					<div class="blank"></div>
					<div class="blank"></div>
					<table class="listTable">
						<tr>
							<th>${bundle("goods.notify.memberCenter.goods.name")}</th>
							<th>${bundle("goods.content.buyInfo.buy.price")}</th>
							<th>${bundle("goods.content.buyInfo.buy.number")}</th>
							<th>${bundle("goods.order.calculate")}</th>
						</tr>
						<#list order.orderItemSet as orderItem>
							<tr>
								<td>
									<a href="${base}${orderItem.goodsHtmlPath}" target="_blank">
										${orderItem.productName}
									</a>
								</td>
								<td>
									${orderItem.productPrice?string(currencyFormat)}
								</td>
								<td>
									${orderItem.productQuantity}
								</td>
								<td>
									<span class="subtotalPrice">${orderItem.subtotalPrice?string(currencyFormat)}</span>
								</td>
							</tr>
						</#list>
						<tr>
							<td class="info" colspan="4">
								${bundle("goods.payment.goods.cost")}: <span class="red">${order.totalProductPrice?string(currencyFormat)}</span>&nbsp;&nbsp;
								${bundle("goods.order.price")}: <span class="red">${order.deliveryFee?string(currencyFormat)!}</span>&nbsp;&nbsp;
								${bundle("goods.payment.goods.payment.fee")}: <span class="red">${order.paymentFee?string(currencyFormat)!}</span>&nbsp;&nbsp;
								${bundle("goods.payment.order.cost")}: <span class="red">${order.totalAmount?string(currencyFormat)}</span>
							</td>
						</tr>
					</table>
					<div class="blank"></div>
					<table class="listTable">
						<tr>
							<th colspan="5">${bundle("goods.order.log")}</th>
						</tr>
						<tr>
							<th>${bundle("goods.order.log.sn")}</th>
							<th>${bundle("goods.order.log.type")}</th>
							<th>${bundle("goods.order.log.info")}</th>
							<th>${bundle("goods.order.log.time")}</th>
							<th>${bundle("goods.order.log.user")}</th>
						</tr>
						<#list order.orderLogSet as orderLog>
							<tr>
								<td>${orderLog_index + 1}</td>
								<td>${action.getText("OrderLogType." + orderLog.orderLogType)}</td>
								<td>${orderLog.info!"-"}</td>
								<td>${orderLog.createDate?string("yyyy-MM-dd HH:mm")}</td>
								<td>${orderLog.operator!"[${bundle("goods.common.user")}]"}</td>
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