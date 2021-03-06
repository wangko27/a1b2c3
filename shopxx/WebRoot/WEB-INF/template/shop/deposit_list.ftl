<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("deposit.list.pagetitle")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
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
				<div class="top">${bundle("deposit.list.title")} <span class="red">[${bundle("deposit.list.prefix")} ${loginMember.deposit?string(currencyFormat)}]</span></div>
				<div class="middle">
					<div class="blank"></div>
					<table class="listTable">
						<tr>
							<th>${bundle("deposit.list.header.operation")}</th>
							<th>${bundle("deposit.list.header.moneyin")}</th>
							<th>${bundle("deposit.list.header.moneyout")}</th>
							<th>${bundle("deposit.list.header.moneycurrent")}</th>
							<th>${bundle("deposit.list.header.date")}</th>
						</tr>
						<#list pager.result as deposit>
							<tr>
								<td>
									<#if (deposit.payment?? && deposit.payment.order??)!>
										<a href="order!view.action?id=${deposit.payment.order.id}">
											${action.getText("DepositType." + deposit.depositType)}
										</a>
									<#else>
										${action.getText("DepositType." + deposit.depositType)}
									</#if>
								</td>
								<td>
									<#if deposit.credit != 0>
										${deposit.credit?string(currencyFormat)}
									<#else>
										-
									</#if>
								</td>
								<td>
									<#if deposit.debit != 0>
										${deposit.debit?string(currencyFormat)}
									<#else>
										-
									</#if>
								</td>
								<td>
									${deposit.balance?string(currencyFormat)}
								</td>
								<td>
									<span title="${deposit.createDate?string("yyyy-MM-dd HH:mm:ss")}">${deposit.createDate}</span>
								</td>
							</tr>
						</#list>
					</table>
					<div class="blank"></div>
					<@pagination pager=pager baseUrl="/shop/deposit!list.action">
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