<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${bundle("caritem.view.title")}<#if setting.isShowPoweredInfo> - Powered By SHOP++</#if></title>
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
<script type="text/javascript">
$().ready( function() {

	var $listTable = $("#listTable");
	var $quantity = $("#cartItemTable .quantity");
	var $changeQuantityTip = $("#changeQuantityTip");
	var $changeQuantityTipClose = $("#changeQuantityTipClose");
	var $changeQuantityTipTopMessage = $("#changeQuantityTipTopMessage");
	var $changeQuantityTipBottomMessage = $("#changeQuantityTipBottomMessage");
	var $deleteCartItem = $("#cartItemTable .deleteCartItem");
	var $clearCartItem = $("#clearCartItem");
	var $totalProductQuantity = $("#totalProductQuantity");
	var $totalProductPrice = $("#totalProductPrice");
	var $totalScore = $("#totalScore");
	var $orderInfoButton = $("#orderInfoButton");
	
	
	// 记录初始商品购买数
	$quantity.each(function(){
		$this = $(this);
		$this.data("previousQuantity", $this.val());
	});
	
	// 修改商品数量
	$quantity.change( function() {
		$this = $(this);
		var productId = $this.attr("productId");
		var quantity = $this.val();
		
		var x = $this.offset().left - 63;
		var y = $this.offset().top + 25;
		$changeQuantityTip.css({"left" : x, "top" : y});
		
		var reg = /^[0-9]*[1-9][0-9]*$/;
		if (!reg.test(quantity)) {
			var previousQuantity = $this.data("previousQuantity");
			$this.val(previousQuantity);
			$changeQuantityTipTopMessage.text("${bundle("goods.quantity.change.message.fail.top")}");
			$changeQuantityTipBottomMessage.text("${bundle("goods.quantity.change.message.fail.bottom")}");
			$changeQuantityTip.fadeIn();
			setTimeout(function() {$changeQuantityTip.fadeOut()}, 3000);
			return false;
		}
		
		$.ajax({
			url: "cart_item!ajaxEdit.action",
			data: {"id": productId, "quantity": quantity},
			type: "POST",
			dataType: "json",
			cache: false,
			beforeSend: function() {
				$quantity.attr("disabled", true);
			},
			success: function(data) {
				if (data.status == "success") {
					$this.data("previousQuantity", quantity);
					$this.parent().parent().find(".subtotalPrice").text(currencyFormat(data.subtotalPrice));
					$this.next(".storeInfo").empty();
					$totalProductQuantity.text(data.totalProductQuantity);
					$totalProductPrice.text(currencyFormat(data.totalProductPrice));
					$totalScore.text(currencyFormat(data.totalScore));
					$changeQuantityTipTopMessage.text("${bundle("goods.quantity.change.message.success.top")}");
					$changeQuantityTipBottomMessage.text("${bundle("goods.quantity.change.message.success.bottom")}" + currencyFormat(data.totalProductPrice));
					$changeQuantityTip.fadeIn();
					setTimeout(function() {$changeQuantityTip.fadeOut()}, 3000);
				} else {
					var previousQuantity = $this.data("previousQuantity");
					$this.val(previousQuantity);
					$changeQuantityTipTopMessage.text("${bundle("goods.quantity.change.message.fail.top")}");
					$changeQuantityTipBottomMessage.text(data.message);
					$changeQuantityTip.fadeIn();
					setTimeout(function() {$changeQuantityTip.fadeOut()}, 3000);
				}
				$quantity.attr("disabled", false);
			}
		});
	});
	
	// 修改商品数量提示框隐藏
	$changeQuantityTipClose.click( function() {
		$changeQuantityTip.fadeOut();
		return false;
	});
	
	// 删除购物车项
	$deleteCartItem.click( function() {
		$this = $(this);
		var productId = $this.attr("productId");
		$.dialog({type: "warn", content: "${bundle("caritem.delete.message")}", ok: "确 定",${bundle("caritem.delete.confirm")} cancel: "${bundle("caritem.delete.cancel")}", modal: true, okCallback: deleteCartItem});
		function deleteCartItem() {
			$.ajax({
				url: "cart_item!ajaxDelete.action",
				data: {"id": productId},
				type: "POST",
				dataType: "json",
				cache: false,
				success: function(data) {
					if (data.status == "success") {
						$this.parent().parent().remove();
						$totalProductQuantity.text(data.totalProductQuantity);
						$totalProductPrice.text(currencyFormat(data.totalProductPrice));
						$totalScore.text(currencyFormat(data.totalScore));
					}
					$.message({type: data.status, content: data.message});
				}
			});
		}
	});
	
	// 清空购物车项
	$clearCartItem.click( function() {
		$.dialog({type: "warn", content: "${bundle("caritem.clear.message")}", ok: "${bundle("caritem.clear.confirm")}", cancel: "${bundle("caritem.clear.cancel")}", modal: true, okCallback: clearCartItem});
		function clearCartItem() {
			$.ajax({
				url: "cart_item!ajaxClear.action",
				type: "POST",
				dataType: "json",
				cache: false,
				success: function(data) {
					if (data.status == "success") {
						$(".listTable tr:gt(0)").remove();
						<#if (loginMember.memberRank.preferentialScale != 100)!>
							$listTable.append('<tr><td class="noRecord" colspan="7">${bundle("caritem.empty.message")}</td></tr>');
						<#else>
							$listTable.append('<tr><td class="noRecord" colspan="6">${bundle("caritem.empty.message")}</td></tr>');
						</#if>
						$orderInfoButton.remove();
						$clearCartItem.remove();
					}
					$.message({type: data.status, content: data.message});
				}
			});
		}
	});
	
	// 结算前检测购物车状态
	$orderInfoButton.click( function() {
		var $this = $(this);
		if (parseInt($totalProductQuantity.text()) < 1) {
			$.message({type: "warn", content: "${bundle("caritem.empty.message")}"});
			return false;
		}
		if (!$.memberVerify()) {
			$.showLoginWindow("${base}/shop/order!info.action");
			return false; 
		}
	});

});
</script>
</head>
<body class="cartItemList">
	<div id="changeQuantityTip" class="changeQuantityTip">
		<div class="tipArrow"></div>
		<div class="tipDetail">
			<div id="changeQuantityTipClose" class="tipClose"></div>
			<p id="changeQuantityTipTopMessage"></p>
			<p id="changeQuantityTipBottomMessage" class="red"></p>
		</div>
	</div>
	<#include "/WEB-INF/template/shop/header.ftl">
	<div class="body">
		<div class="cartItemListBar"></div>
		<div class="blank"></div>
		<div class="cartItemListDetail">
			<div class="top">
				<div class="topLeft"></div>
				<div class="topMiddle">${bundle("caritem.list.title")} </div>
				<div class="topRight"></div>
			</div>
			<div class="middle">
				<table id="cartItemTable" class="listTable">
					<tr>
						<th>${bundle("caritem.list.th.pic")}</th>
						<th>${bundle("caritem.list.th.name")}</th>
						<th>${bundle("caritem.list.th.price")}</th>
						<#if (loginMember.memberRank.preferentialScale != 100)!>
							<th>${bundle("caritem.list.th.discount")}</th>
						</#if>
						<th>${bundle("caritem.list.th.count")}</th>
						<th>${bundle("caritem.list.th.total")}</th>
						<th>${bundle("caritem.list.th.delete")}</th>
					</tr>
					<#list cartItemList as cartItem>
						<#assign product = cartItem.product />
						<#assign goods = cartItem.product.goods />
						<tr>
							<td class="goodsImage">
								<a href="${base}${goods.htmlPath}" target="_blank">
									<img src="${base}${goods.defaultThumbnailGoodsImagePath}" />
								</a>
							</td>
							<td>
								<a href="${base}${goods.htmlPath}" target="_blank">
									${product.name}
								</a>
							</td>
							<#if (loginMember.memberRank.preferentialScale != 100)!>
								<td class="priceTd">
									<span class="lineThrough">${product.price?string(currencyFormat)}</span>
								</td>
								<td class="priceTd">
									${cartItem.preferentialPrice?string(currencyFormat)}
								</td>
							<#else>
								<td class="priceTd">
									${product.price?string(currencyFormat)}
								</td>
							</#if>
							<td>
								<input type="text" name="quantity" class="formText quantity" value="${cartItem.quantity}" productId="${product.id}" />
								<#if (product.store?? && product.freezeStore + cartItem.quantity > product.store)>
									<strong class="storeInfo red">[${bundle("caritem.not.enough.store")}]</strong>
								</#if>
							</td>
							<td>
								<span class="subtotalPrice">${cartItem.subtotalPrice?string(currencyFormat)}</span>
							</td>
							<td>
								<a class="deleteCartItem" href="javascript: void(0);" productId="${product.id}">${bundle("caritem.list.th.delete")}</a>
							</td>
						</tr>
					</#list>
					<#if (cartItemList == null || cartItemList?size == 0)!>
						<tr>
							<td class="noRecord" colspan="<#if (loginMember.memberRank.preferentialScale != 100)!>7<#else>6</#if>">${bundle("caritem.empty.message")}</td>
						</tr>
					<#else>
						<tr>
							<td class="info" colspan="<#if (loginMember.memberRank.preferentialScale != 100)!>7<#else>6</#if>">
								${bundle("caritem.total.message")} <span id="totalProductQuantity" class="red">${totalProductQuantity}</span> ${bundle("caritem.total.unit")}&nbsp;&nbsp;
								<#if setting.scoreType != "disable">
									${bundle("caritem.total.score")} <span id="totalScore" class="red">${totalScore}</span>&nbsp;&nbsp;
								</#if>
								${bundle("caritem.total.price")} <span id="totalProductPrice" class="red">${totalProductPrice?string(currencyFormat)}</span>
							</td>
						</tr>
					</#if>
				</table>
				<div class="blank"></div>
				<a class="continueShopping" href="${base}/"><span class="icon">&nbsp;</span>${bundle("caritem.button.continue")}</a>
				<#if (cartItemList?? && cartItemList?size > 0)!>
					<a id="clearCartItem" class="clearCartItem" href="javascript: void(0);"><span class="icon">&nbsp;</span>${bundle("caritem.button.clear")}</a>
					<a id="orderInfoButton" class="formButton" href="order!info.action">${bundle("caritem.button.pay")}</a>
				</#if>
				<div class="clear"></div>
			</div>
			<div class="bottom">
				<div class="bottomLeft"></div>
				<div class="bottomMiddle"></div>
				<div class="bottomRight"></div>
			</div>
		</div>
		<div class="blank"></div>
		<#include "/WEB-INF/template/shop/friend_link.ftl">
	</div>
	<div class="blank"></div>
	<#include "/WEB-INF/template/shop/footer.ftl">
</body>
</html>