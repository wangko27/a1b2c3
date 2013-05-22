/***
 *	SHOP++ Shop JavaScript
 *
 *	http://www.shopxx.net
 *
 *	Copyright © 2010 shopxx.net All Rights Reserved.
 **/

shopxx = {
	base: "${base}",
	currencySign: "${setting.currencySign}",
	currencyUnit: "${setting.currencyUnit}",
	priceScale: "${setting.priceScale}",
	priceRoundType: "${setting.priceRoundType}"
};

// 货币格式化
function currencyFormat(price) {
	price = setScale(price, shopxx.priceScale, shopxx.priceRoundType);
	return shopxx.currencySign + price + shopxx.currencyUnit;
}

$().ready( function() {

	var $body = $("body");
	
	/* ---------- MemberVerify ---------- */
	
	$.memberVerify = function () {
		if(getCookie("memberUsername") != null) {
			var isMemberLogin = false;
			$.ajax({
				url: shopxx.base + "/shop/member!ajaxMemberVerify.action",
				type: "POST",
				dataType: "json",
				async: false,
				cache: false,
				success: function(data) {
					if (data.status) {
						isMemberLogin = true;
					}
				}
			});
			return isMemberLogin;
		} else {
			return false;
		}
	}
	
	/* ---------- Header ---------- */
	
	var $header = $("#header");
	if ($header.size() > 0) {
		var $headerShowLoginWindow = $("#headerShowLoginWindow");
		var $headerShowRegisterWindow = $("#headerShowRegisterWindow");
		var $headerLoginMemberUsername = $("#headerLoginMemberUsername");
		var $headerMemberCenter = $("#headerMemberCenter");
		var $headerLogout = $("#headerLogout");
		var $goodsSearchForm = $("#goodsSearchForm");
		var $goodsSearchKeyword = $("#goodsSearchKeyword");
		
		$.flushHeaderInfo = function () {
			if(getCookie("memberUsername") != null) {
				$headerLoginMemberUsername.text(getCookie("memberUsername"));
				$headerMemberCenter.show();
				$headerLogout.show();
				$headerShowLoginWindow.hide();
				$headerShowRegisterWindow.hide();
			} else {
				$headerLoginMemberUsername.text("");
				$headerShowLoginWindow.show();
				$headerShowRegisterWindow.show();
				$headerMemberCenter.hide();
				$headerLogout.hide();
			}
		}
		
		$.flushHeaderInfo();
		
		$.showLoginWindow = function (redirectUrl) {
			
			<@compress single_line = true>
				var loginWindowHtml = 
				'<form id="loginWindowForm">
					<table>
						<tr>
							<th>${bundle("goods.notify.memberCenter.profile.username")}: </th>
							<td>
								<input type="text" id="loginWindowMemberUsername" name="member.username" class="formText" />
							</td>
						</tr>
						<tr>
							<th>${bundle("goods.common.password")}: </th>
							<td>
								<input type="password" id="loginWindowMemberPassword" name="member.password" class="formText" />
							</td>
						</tr>
						<tr>
							<th>${bundle("goods.content.bottom.comment.sign")}: </th>
							<td>
								<input type="text" id="loginWindowCaptcha" name="j_captcha" class="formText loginWindowCaptcha" />
								<img id="loginWindowCaptchaImage" class="loginWindowCaptchaImage" src="' + shopxx.base + '/captcha.jpeg?timestamp=' + (new Date()).valueOf() + '" alt="${bundle("goods.content.bottom.comment.replace")}" />
							</td>
						</tr>
							<tr>
								<th>&nbsp;</th>
							<td>
								<span class="warnIcon">&nbsp;</span>
								<a href="' + shopxx.base + '/shop/member!passwordRecover.action">${bundle("goods.password.forget")}? ${bundle("goods.common.clickfind")}!</a>
							</td>
						</tr>
					</table>
				</form>';
			</@compress>
			
			$.dialog({title: "${bundle("goods.common.member.login")}", content: loginWindowHtml, ok: "${bundle("goods.common.login")}", cancel: "${bundle("goods.common.cancel")}", id: "loginWindow", className: "loginWindow", width: 420, okCallback: login, modal: true});
			
			var $loginWindowForm = $("#loginWindowForm");
			var $loginWindowMemberUsername = $("#loginWindowMemberUsername");
			var $loginWindowMemberPassword = $("#loginWindowMemberPassword");
			var $loginWindowCaptcha = $("#loginWindowCaptcha");
			var $loginWindowCaptchaImage = $("#loginWindowCaptchaImage");
			
			function loginWindowCaptchaImageRefresh() {
				$loginWindowCaptchaImage.attr("src", shopxx.base + "/captcha.jpeg?timestamp=" + (new Date()).valueOf());
			}
			
			$loginWindowCaptchaImage.click( function() {
				loginWindowCaptchaImageRefresh();
			});
			
			function login() {
				if ($.trim($loginWindowMemberUsername.val()) == "") {
					$loginWindowMemberUsername.focus();
					$.message({type: "warn", content: "${bundle("goods.notify.javascript.username.input")}!"});
					return false;
				}
				if ($.trim($loginWindowMemberPassword.val()) == "") {
					$loginWindowMemberPassword.focus();
					$.message({type: "warn", content: "${bundle("goods.notify.javascript.password.input")}!"});
					return false;
				}
				if ($.trim($loginWindowCaptcha.val()) == "") {
					$loginWindowCaptcha.focus();
					$.message({type: "warn", content: "${bundle("goods.message.push.captcha.input")}!"});
					return false;
				}
				
				$.ajax({
					url: shopxx.base + "/shop/member!ajaxLogin.action",
					data: $loginWindowForm.serialize(),
					type: "POST",
					dataType: "json",
					cache: false,
					beforeSend: function() {
						$loginWindowForm.find("button").attr("disabled", true);
					},
					success: function(data) {
						if (data.status == "success") {
							$.flushHeaderInfo();
							$.closeDialog("loginWindow");
						}
						$.message({type: data.status, content: data.message});
						if(redirectUrl != null) {
							location.href = redirectUrl;
						}
					},
					complete: function() {
						$loginWindowForm.find("button").attr("disabled", false);
						$loginWindowCaptcha.val("");
						loginWindowCaptchaImageRefresh();
					}
				});
				return false;
			}
		}
		
		$.showRegisterWindow = function () {
			
			<@compress single_line = true>
				var registerWindowHtml = '
				<form id="registerWindowForm">
					<table>
						<tr>
							<th>${bundle("goods.notify.memberCenter.profile.username")}: </th>
							<td>
								<input type="text" id="registerWindowMemberUsername" name="member.username" class="formText" title="${bundle("goods.common.user.require")}!" />
							</td>
						</tr>
						<tr>
							<th>${bundle("goods.common.password")}: </th>
							<td>
								<input type="password" id="registerWindowMemberPassword" name="member.password" class="formText" />
							</td>
						</tr>
						<tr>
							<th>${bundle("goods.common.repassword")}: </th>
							<td>
								<input type="password" id="registerWindowReMemberPassword" name="reMemberPassword" class="formText" title="${bundle("goods.common.password.require")}!" />
							</td>
						</tr>
						<tr>
							<th>E-mail: </th>
							<td>
								<input type="text" id="registerWindowMemberEmail" name="member.email" class="formText" />
							</td>
						</tr>
						<tr>
							<th>${bundle("goods.content.bottom.comment.sign")}: </th>
							<td>
								<input type="text" id="registerWindowCaptcha" name="j_captcha" class="formText registerWindowCaptcha" />
								<img id="registerWindowCaptchaImage" class="registerWindowCaptchaImage" src="' + shopxx.base + '/captcha.jpeg?timestamp=' + (new Date()).valueOf() + '" alt="${bundle("goods.content.bottom.comment.replace")}" />
							</td>
						</tr>
						<tr>
							<th>&nbsp;</th>
							<td>
								<label>
									<input type="checkbox" id="registerWindowIsAgreeAgreement" name="isAgreeAgreement" value="true" checked />${bundle("goods.register.agree")}
									<a id="registerWindowShowAgreementWindow" class="showAgreementWindow" href="javascript: void(0);" title="${bundle("goods.register.member.law.show")}">${bundle("goods.register.member.law")}</a>
								</label>
							</td>
						</tr>
					</table>
				</form>';
			</@compress>
			
			$.dialog({title: "${bundle("goods.register.member")}", content: registerWindowHtml, ok: "${bundle("goods.common.register")}", cancel: "${bundle("goods.common.cancel")}", id: "registerWindow", className: "registerWindow", width: 480, okCallback: register, modal: true});
			
			var $registerWindowForm = $("#registerWindowForm");
			var $registerWindowMemberUsername = $("#registerWindowMemberUsername");
			var $registerWindowMemberPassword = $("#registerWindowMemberPassword");
			var $registerWindowReMemberPassword = $("#registerWindowReMemberPassword");
			var $registerWindowMemberEmail = $("#registerWindowMemberEmail");
			var $registerWindowCaptcha = $("#registerWindowCaptcha");
			var $registerWindowCaptchaImage = $("#registerWindowCaptchaImage");
			var $registerWindowIsAgreeAgreement = $("#registerWindowIsAgreeAgreement");
			var $registerWindowShowAgreementWindow = $("#registerWindowShowAgreementWindow");
			
			function registerWindowCaptchaImageRefresh() {
				$registerWindowCaptchaImage.attr("src", shopxx.base + "/captcha.jpeg?timestamp=" + (new Date()).valueOf());
			}
			
			$registerWindowCaptchaImage.click( function() {
				registerWindowCaptchaImageRefresh();
			});
			
			$registerWindowShowAgreementWindow.click( function() {
				$.showAgreementWindow();
			});
			
			function register() {
				if ($.trim($registerWindowMemberUsername.val()) == "") {
					$registerWindowMemberUsername.focus();
					$.message({type: "warn", content: "${bundle("goods.notify.javascript.username.input")}!"});
					return false;
				}
				if (!/^[\u0391-\uFFE5\w]+$/.test($registerWindowMemberUsername.val())) {
					$registerWindowMemberUsername.focus();
					$.message({type: "warn", content: "${bundle("goods.notify.javascript.username.error")}!"});
					return false;
				}
				if ($.trim($registerWindowMemberUsername.val()).length < 2 || $.trim($registerWindowMemberUsername.val()).length > 20) {
					$registerWindowMemberUsername.focus();
					$.message({type: "warn", content: "${bundle("goods.notify.javascript.username.length")}!"});
					return false;
				}
				if ($.trim($registerWindowMemberPassword.val()) == "") {
					$registerWindowMemberPassword.focus();
					$.message({type: "warn", content: "${bundle("goods.notify.javascript.password.input")}!"});
					return false;
				}
				if ($.trim($registerWindowMemberPassword.val()).length < 4 || $.trim($registerWindowMemberPassword.val()).length > 20) {
					$registerWindowMemberPassword.focus();
					$.message({type: "warn", content: "${bundle("goods.notify.javascript.password.length")}!"});
					return false;
				}
				if ($.trim($registerWindowReMemberPassword.val()) == "") {
					$registerWindowReMemberPassword.focus();
					$.message({type: "warn", content: "${bundle("goods.notify.javascript.password.reinput")}!"});
					return false;
				}
				if ($.trim($registerWindowReMemberPassword.val()) != $.trim($registerWindowMemberPassword.val())) {
					$registerWindowReMemberPassword.focus();
					$.message({type: "warn", content: "${bundle("goods.notify.javascript.password.different")}!"});
					return false;
				}
				if ($.trim($registerWindowMemberEmail.val()) == "") {
					$registerWindowMemberEmail.focus();
					$.message({type: "warn", content: "${bundle("goods.notify.javascript.email.input")}E-mail!"});
					return false;
				}
				if (!/^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/.test($registerWindowMemberEmail.val())) {
					$registerWindowMemberEmail.focus();
					$.message({type: "warn", content: "E-mail${bundle("goods.notify.javascript.email.error")}!"});
					return false;
				}
				if ($.trim($registerWindowCaptcha.val()) == "") {
					$registerWindowCaptcha.focus();
					$.message({type: "warn", content: "${bundle("goods.message.push.captcha.input")}!"});
					return false;
				}
				if (!$registerWindowIsAgreeAgreement.attr("checked")) {
					$registerWindowIsAgreeAgreement.focus();
					$.message({type: "warn", content: "${bundle("goods.register.member.register.pre")}!"});
					return false;
				}
				
				$.ajax({
					url: shopxx.base + "/shop/member!checkUsername.action",
					data: {"member.username": $registerWindowMemberUsername.val()},
					type: "POST",
					cache: false,
					beforeSend: function() {
						$registerWindowForm.find("button").attr("disabled", true);
					},
					success: function(data) {
						if (data == "true") {
							$.ajax({
								url: shopxx.base + "/shop/member!ajaxRegister.action",
								data: $registerWindowForm.serialize(),
								type: "POST",
								dataType: "json",
								cache: false,
								success: function(data) {
									if (data.status == "success") {
										$.closeDialog("registerWindow");
										$.flushHeaderInfo();
									}
									$.message({type: data.status, content: data.message});
								},
								complete: function() {
									$registerWindowForm.find("button").attr("disabled", false);
									$registerWindowCaptcha.val("");
									registerWindowCaptchaImageRefresh();
								}
							});
						} else {
							$registerWindowMemberUsername.focus();
							$.message({type: "warn", content: "${bundle("goods.register.member.username.exist")}!"});
						}
					}
				});
				return false;
			}
		}
		
		$.showAgreementWindow = function() {
			if ($("#agreementWindow").length == 0) {
				var agreementWindowHtml = '<div id="agreementWindowContent" class="agreementWindowContent"></div>';
				
				function agreeAgreement() {
					var $registerWindowIsAgreeAgreement = $("#registerWindowIsAgreeAgreement");
					$registerWindowIsAgreeAgreement.attr("checked", true);
				}
			
				$.dialog({title: "${bundle("goods.register.member.law.title")}", content: agreementWindowHtml, ok: "${bundle("goods.common.agree")}", cancel: "${bundle("goods.common.cancel")}", id: "agreementWindow", className: "agreementWindow", width: 520, okCallback: agreeAgreement});
				
				var $agreementWindowContent = $("#agreementWindowContent");
				
				$.ajax({
					url: shopxx.base + "/html/register_agreement.html",
					datatype: "html",
					beforeSend: function(data) {
						$agreementWindowContent.html('<span class="loadingIcon">&nbsp;</span> ${bundle("goods.common.loading")}...');
					},
					success: function(data) {
						$agreementWindowContent.html(data);
					}
				});
			}
		}
		
		$headerShowLoginWindow.click( function() {
			$.showLoginWindow();
			return false;
		})
		
		$headerShowRegisterWindow.click( function() {
			$.showRegisterWindow();
			return false;
		})
		
		goodsSearchKeywordDefaultValue = $goodsSearchKeyword.val();
		$goodsSearchKeyword.focus( function() {
			if ($goodsSearchKeyword.val() == goodsSearchKeywordDefaultValue) {
				$goodsSearchKeyword.val("");
			}
		});
		
		$goodsSearchKeyword.blur( function() {
			if ($goodsSearchKeyword.val() == "") {
				$goodsSearchKeyword.val(goodsSearchKeywordDefaultValue);
			}
		});
		
		$goodsSearchForm.submit( function() {
			if ($.trim($goodsSearchKeyword.val()) == "" || $.trim($goodsSearchKeyword.val()) == goodsSearchKeywordDefaultValue) {
				return false;
			}
		});

	}
	
	/* ---------- SliderScrollable ---------- */
	
	var $sliderScrollable = $("#sliderScrollable");
	if ($sliderScrollable.size() > 0) {
		$sliderScrollable.scrollable({
			circular: true,
			speed: 500
		}).autoscroll({
			autoplay: true,
			interval: 4000
		}).navigator();
	}
	
	/* ---------- HotGoodsScrollable ---------- */
	
	var $hotGoodsScrollable = $("#hotGoodsScrollable");
	if ($hotGoodsScrollable.size() > 0) {
		$hotGoodsScrollable.scrollable({
			circular: true,
			speed: 500
		});
	}
	
	/* ---------- NewGoodsTab ---------- */
	
	var $newGoodsTab = $("#newGoodsTab");
	if ($newGoodsTab.size() > 0) {
		$newGoodsTab.tabs(".newGoodsTabContent", {
			event: "mouseover"
		});
	}
	
	/* ---------- AddFavorite ---------- */
	
	$.addFavorite = function(id) {
		if (!$.memberVerify()) {
			$.showLoginWindow();
			return false; 
		}
		$.ajax({
			url: shopxx.base + "/shop/favorite!ajaxAdd.action",
			data: {"id": id},
			type: "POST",
			dataType: "json",
			cache: false,
			success: function(data) {
				$.message({type: data.status, content: data.message});
			}
		});
	}
	
	/* ---------- AddCompare ---------- */
	
	$.addCompare = function(id) {
		var goodsCategory = $('#goodsCategory').val();
		$.cookie('compare-goodsCategory', goodsCategory, { path: '/' });
		var items = $.cookie('items-compare');
		if(id){
			if(items){
				var exist = false;
				var itemArray = items.split(',');
				if(itemArray.length < 5){
					for(var i = 0; i < itemArray.length; i++) {
						if(itemArray[i] == id) {
							exist = true;
							break;
						}
					}
					if(!exist){
						items += id + ',';
					}
				}
				
			} else {
				items = id + ',';
			}
		}
		if(items){
			$.cookie('items-compare', items, { path: '/' });
		
			$.ajax({
				url: shopxx.base + "/shop/compare!showSimple.action",
				data: {"compareIds": items},
				type: "GET",
				dataType: "html",
				cache: false,
				success: function(data) {
					$('#diff-items').html(data);
				}
			});
			$('#pop-compare').show();
			if(items.split(',').length > 2){
				$('#goto-contrast').attr('class', 'compare-active');
			}
		}
	}
	
	/* ---------- ClearCompare ---------- */
	$.clearCompare= function() {
		$('#pop-compare').show();
		$.cookie('items-compare', '', { path: '/' });
		var html = '<dl class="item-empty"><dt>1</dt><dd>${bundle("goods.order.add")}</dd></dl>'
		         + '<dl class="item-empty"><dt>2</dt><dd>${bundle("goods.order.add")}</dd></dl>'
		         + '<dl class="item-empty"><dt>3</dt><dd>${bundle("goods.order.add")}</dd></dl>'
		         + '<dl class="item-empty"><dt>4</dt><dd>${bundle("goods.order.add")}</dd></dl>';
		$('#diff-items').html(html);
		$('#goto-contrast').attr('class', 'btn-compare-b');
	}
	
	
	/* ---------- AddCartItem ---------- */
	
	$.addCartItem = function(id, quantity) {
		if ($.trim(id) == "") {
			$.dialog({type: "warn", content: "${bundle("goods.purchase.select")}!", modal: true, autoCloseTime: 3000});
			return false;
		}
		if (!/^[0-9]*[1-9][0-9]*$/.test($.trim(quantity))) {
			$.dialog({type: "warn", content: "${bundle("goods.purchase.number")}!", modal: true, autoCloseTime: 3000});
			return false;
		}

		$.ajax({
			url: shopxx.base + "/shop/cart_item!ajaxAdd.action",
			data: {"id": id, "quantity": quantity},
			type: "POST",
			dataType: "json",
			cache: false,
			success: function(data) {
				if (data.status == "success") {
					$.dialog({type: "success", content: "<span class=\"red\">" + data.message + "</span><br />${bundle("goods.purchase.total")}: " + data.totalProductQuantity + " ${bundle("goods.common.unit.goods")}, ${bundle("goods.purchase.cost")}: " + currencyFormat(data.totalProductPrice), width: 360, modal: true, autoCloseTime: 3000});
				} else {
					$.dialog({type: data.status, content: data.message, modal: true, autoCloseTime: 3000});
				}
			}
		});
	}
	
	/* ---------- GoodsList ---------- */
	
	var $goodsListForm = $("#goodsListForm");
	if ($goodsListForm.size() > 0) {
		var $brandId = $("#brandId");
		var $brand = $("#filter .brand");
		var $goodsAttributeOption = $("#filter .goodsAttributeOption");
		var $pageNumber = $("#pageNumber");
		var $pageSize = $("#pageSize");
		var $orderType = $("#orderType");
		var $viewType = $("#viewType");
		var $tableType = $("#tableType");
		var $pictureType = $("#pictureType");
		var $addFavorite = $("input.addFavorite");
		var $gotoCompare = $('#goto-contrast');
		var $addCompare = $("input.addCompare");
		
		$brand.click( function() {
			var $this = $(this);
			if ($this.hasClass("all")) {
				$brandId.val("");
			} else {
				$brandId.val($this.attr("brandId"));
			}
			$goodsListForm.submit();
			return false;
		});
		
		$goodsAttributeOption.click( function() {
			var $this = $(this);
			$this.parent().parent().find(":hidden").attr("disabled", true);
			if (!$this.hasClass("all")) {
				$this.prev(":hidden").attr("disabled", false);
			}
			$goodsListForm.submit();
			return false;
		});
		
		$pageSize.change( function() {
			$pageNumber.val("1");
			$goodsListForm.submit();
		});
		
		$orderType.change( function() {
			$pageNumber.val("1");
			$goodsListForm.submit();
		});
		
		$tableType.click( function() {
			$viewType.val("tableType");
			$goodsListForm.submit();
			return false;
		});
		
		$pictureType.click( function() {
			$viewType.val("pictureType");
			$goodsListForm.submit();
			return false;
		});
		
		$addFavorite.click( function() {
			var $this = $(this);
			$.addFavorite($this.attr("goodsId"));
		});
		
		$addCompare.click( function() {
			var $this = $(this);
			$.addCompare($this.attr("goodsId"));
		});
		
		$gotoCompare.click( function() {
			var items = $.cookie('items-compare');
			if(items){
				var itemArray = items.split(',');
				if(itemArray.length < 2){
					return;
				}
				var url = shopxx.base + "/shop/compare!showResult.action?compareIds=" + items;
				window.open(url);
			}
		});
		
	
	}
	
	/* ---------- GoodsContent ---------- */
	
	var $goodsContent = $("#goodsContent");
	if ($goodsContent.size() > 0) {
		var $zoom = $("a.zoom");
		var $thumbnailGoodsImageScrollable = $("#thumbnailGoodsImageScrollable");
		var $goodsImageTab = $("#goodsImageTab");
		var $goodsParameterTab = $("#goodsParameterTab");
		var $cmtTab = $("#cmtTab");
		var $addFavorite = $("#addFavorite");
		
		$thumbnailGoodsImageScrollable.scrollable({
			speed: 600
		});
		
		$goodsImageTab.tabs(".goodsImage .tabContent", {
			event: "mouseover"
		});
		
		$zoom.zoomimage({
			opacity: 0.6,
			controlsTrigger: "mouseover",
			controls: true,
			centered: true,
			hideSource: true
		});
		
		$goodsParameterTab.tabs(".goodsBottom .tabContent", {
			event: "mouseover"
		});
		
		$cmtTab.tabs(".commentTab", {
			event: "click",
			onClick: function(e, tab){
				var getCmtListUrl = shopxx.base + '/shop/comment!ajaxList.action';
				var goodsId = $('#goodsId').val();
				$.ajax({
					url: getCmtListUrl,
					data: 'id=' + goodsId + '&type=' + tab + '&date' + new Date(),
					type: "GET",
					dataType: "json",
					cache: false,
					success: function(data) {
						$('#totalCount').html('(' + data.totalCount + ')');
						$('#goodCount').html('(' + data.goodCount + ')');
						$('#middleCount').html('(' + data.middleCount + ')');
						$('#badCount').html('(' + data.badCount + ')');
						var commentItemHtml = '';
						var retList = data['retList'];
						for(var i = 0; i < retList.length; i++) {
							var comment = retList[i];
							commentItemHtml += '<div class="commentItem"><p><span class="red">' + comment.username + '</span>&nbsp;&nbsp;&nbsp;&nbsp;<span><img src="${base}/template/shop/images/discuss_s' + comment.score + '.gif" /></span>&nbsp;&nbsp;&nbsp;&nbsp;' + comment.formatCreateDate + '</p><p><pre>' + htmlEscape(comment.content) + '</pre></p></div><div class="blank"></div>';
						}
						$('#commentList_' + tab).html(commentItemHtml);
					}
				});
			}
		});
		
		$addFavorite.click( function() {
			var $this = $(this);
			$.addFavorite($this.attr("goodsId"));
		});
	}
	
	/* ---------- Goods Recommend ---------- */
	var $recommend = $("#recommendGoods");
	if ($recommend.size() > 0) {
		var goodsId = $('#goodsId').val();
		var goodsCategoryId = $('#goodsCategoryId').val();
		var getRecommendGoodsUrl = shopxx.base + '/shop/goods!recommend.action';
		$.ajax({
			url: getRecommendGoodsUrl,
			data: 'goodsId=' + goodsId + '&goodsCategoryId=' + goodsCategoryId,
			type: "GET",
			dataType: "html",
			cache: false,
			success: function(html) {
				$recommend.html(html);
				$recommend.show();
			}
		});
	}
	
	/* ---------- Comment ---------- */
	
	var $comment = $("#comment");
	if ($comment.size() > 0) {
		var $commentReply = $(".commentReply");
		var $sendTitle = $("#sendTitle");
		var $sendComment = $("#sendComment");
		var $commentForm = $("#commentForm");
		var $forCommentId = $("#forCommentId");
		var $commentContent = $("#commentContent");
		var $commentCaptcha = $("#commentCaptcha");
		var $commentCaptchaImage = $("#commentCaptchaImage");
		var forCommentId = null;
		var ajaxUrl = shopxx.base + "/shop/comment!ajaxSave.action";
		
		$commentReply.click( function() {
			var $this = $(this);
			forCommentId = $this.attr("forCommentId");
			$forCommentId.val(forCommentId);
			ajaxUrl = shopxx.base + "/shop/comment!ajaxReply.action";
			$sendTitle.html("${bundle("goods.comment.reply")}");
			$sendComment.show();
		});
		
		$sendComment.click( function() {
			forCommentId = null;
			$forCommentId.val("");
			ajaxUrl = shopxx.base + "/shop/comment!ajaxSave.action";
			$sendTitle.html("${bundle("goods.content.bottom.comment.say")}");
			$sendComment.hide();
		});
		
		function commentCaptchaImageRefresh() {
			$commentCaptchaImage.attr("src", shopxx.base + "/captcha.jpeg?timestamp=" + (new Date()).valueOf());
		}
	
		$commentCaptchaImage.click( function() {
			commentCaptchaImageRefresh();
		});
		
		$commentForm.submit( function() {
			<#if !setting.isCommentEnabled>
				$.dialog({type: "warn", content: "${bundle("goods.comment.close")}!", modal: true, autoCloseTime: 3000});
				return false;
			</#if>
			<#if setting.commentAuthority != "anyone">
				if (!$.memberVerify()) {
					$.showLoginWindow();
					return false; 
				}
			</#if>
			if ($.trim($commentContent.val()) == "") {
				$.dialog({type: "warn", content: "${bundle("goods.comment.content.input")}!", modal: true, autoCloseTime: 3000});
				return false;
			}
			<#if setting.isCommentCaptchaEnabled>
				if ($.trim($commentCaptcha.val()) == "") {
					$.dialog({type: "warn", content: "${bundle("goods.comment.captcha")}!", modal: true, autoCloseTime: 3000});
					return false;
				}
			</#if>
			
			var score = $("input[name='comment.score']:checked").val();
			$.ajax({
				url: ajaxUrl,
				data: $commentForm.serialize(),
				type: "POST",
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$commentForm.find("submit").attr("disabled", true);
				},
				success: function(data) {
					$.dialog({type: data.status, content: data.message, modal: true, autoCloseTime: 3000});
					if (data.status == "success") {
						<#if setting.commentDisplayType == "direct">
							var username = getCookie("memberUsername");
							if (username == null) {
								username = "${bundle("goods.content.bottom.comment.guest")}";
							}
							if (forCommentId == null) {
								var commentItemHtml = '<div class="commentItem"><p><span class="red">' + username + '</span>&nbsp;&nbsp;&nbsp;&nbsp;<span><img src="${base}/template/shop/images/discuss_s' + score + '.gif" /></span>&nbsp;&nbsp;&nbsp;&nbsp;' + new Date().toLocaleDateString() + '</p><p><pre>' + htmlEscape($commentContent.val()) + '</pre></p></div><div class="blank"></div>';
								// $comment.prepend(commentItemHtml);
								if($('#commentList_1').size() > 0){
									if(score > 3){
										$('#commentList_1').prepend(commentItemHtml);
									} else if (score < 3){
										$('#commentList_3').prepend(commentItemHtml);
									} else {
										$('#commentList_2').prepend(commentItemHtml);
									}
								}
								$('#commentList_0').prepend(commentItemHtml);
							} else {
								var replyHtml = '<div class="reply"><p><span class="red">' + username + '</span> ' + new Date().toLocaleDateString() + '</p><p><pre>' + htmlEscape($commentContent.val()) + '</pre></p></div>';
								$("#commentItem" + forCommentId).append(replyHtml);
							}
						</#if>
						$commentContent.val("");
					}
				},
				complete: function() {
					$commentForm.find("submit").attr("disabled", false);
					$commentCaptcha.val("");
					commentCaptchaImageRefresh();
				}
			});
			return false;
		});
		
	}
	
	/* ---------- GoodsHistory ---------- */
	
	var $goodsHistory = $("#goodsHistory");
	if ($goodsHistory.size() > 0) {
		var $goodsHistoryListDetail = $("#goodsHistoryListDetail");
		var maxGoodsHistoryListCount = 5;
		$.addGoodsHistory = function(name, htmlPath) {
			var goodsHistory = {
				name: name,
				htmlPath: htmlPath
			};
			var goodsHistoryArray = new Array();
			var goodsHistoryListCookie = getCookie("goodsHistoryList");
			if(goodsHistoryListCookie) {
				goodsHistoryArray = eval(goodsHistoryListCookie);
			}
			var goodsHistoryListHtml = "";
			for (var i in goodsHistoryArray) {
				goodsHistoryListHtml += '<li><a href="' + goodsHistoryArray[i].htmlPath + '">' + goodsHistoryArray[i].name + '</a></li>';
			}
			for (var i in goodsHistoryArray) {
				if(goodsHistoryArray[i].htmlPath == htmlPath) {
					return;
				}
			}
			if(goodsHistoryArray.length >= maxGoodsHistoryListCount) {
				goodsHistoryArray.shift();
			}
			goodsHistoryArray.push(goodsHistory);
			var newGoodsHistoryCookieString = "";
			for (var i in goodsHistoryArray) {
				newGoodsHistoryCookieString += ',{name: "' + goodsHistoryArray[i].name + '", htmlPath: "' + goodsHistoryArray[i].htmlPath + '"}'
			}
			newGoodsHistoryCookieString = "[" + newGoodsHistoryCookieString.substring(1, newGoodsHistoryCookieString.length) + "]";
			setCookie("goodsHistoryList", newGoodsHistoryCookieString);
		}
		
		var goodsHistoryArray = new Array();
		var goodsHistoryListCookie = getCookie("goodsHistoryList");
		if(goodsHistoryListCookie) {
			goodsHistoryArray = eval(goodsHistoryListCookie);
		}
		var goodsHistoryListHtml = "";
		for (var i in goodsHistoryArray) {
			goodsHistoryListHtml += '<li><span class="icon">&nbsp;</span><a href="' + goodsHistoryArray[i].htmlPath + '">' + goodsHistoryArray[i].name + '</a></li>';
		}
		$goodsHistoryListDetail.html(goodsHistoryListHtml);
	}
	
	/* ---------- ArticleSearch ---------- */
	
	var $articleSearch = $("#articleSearch");
	if ($articleSearch.size() > 0) {
		$articleSearchForm = $("#articleSearchForm");
		$articleSearchKeyword = $("#articleSearchKeyword");
		
		articleSearchKeywordDefaultValue = $("#articleSearchKeyword").val();
		$articleSearchKeyword.focus( function() {
			if ($articleSearchKeyword.val() == articleSearchKeywordDefaultValue) {
				$articleSearchKeyword.val("");
			}
		});
		
		$articleSearchKeyword.blur( function() {
			if ($articleSearchKeyword.val() == "") {
				$articleSearchKeyword.val(articleSearchKeywordDefaultValue);
			}
		});
		
		$articleSearchForm.submit( function() {
			if ($.trim($articleSearchKeyword.val()) == "" || $.trim($articleSearchKeyword.val()) == articleSearchKeywordDefaultValue) {
				return false;
			}
		});
	}
	
	/* ---------- ArticleContent ---------- */
	
	var $articleContent = $("#articleContent");
	if ($articleContent.size() > 0) {
		$changeBigFontSize = $("#changeBigFontSize");
		$changeNormalFontSize = $("#changeNormalFontSize");
		$changeSmallFontSize = $("#changeSmallFontSize");
		
		$changeBigFontSize.click(function () {
			$articleContent.css({"font-size": "16px"});
		});
		
		$changeNormalFontSize.click(function () {
			$articleContent.css({"font-size": "14px"});
		});
		
		$changeSmallFontSize.click(function () {
			$articleContent.css({"font-size": "12px"});
		});
	}
	
	/* ---------- InstantMessaging ---------- */
	
	<#if setting.isInstantMessagingEnabled>
	
		<@compress single_line = true>
			var instantMessagingHtml = '
			<div id="instantMessagingLayer" class="instantMessagingLayer <#if setting.instantMessagingPosition == "left">leftInstantMessagingLayer<#else>rightInstantMessagingLayer</#if>">
				<div id="instantMessagingMin" class="instantMessagingMin"></div>
				<div id="instantMessagingMain" class="instantMessagingMain">
					<div class="top"></div>
					<div class="middle">
						<dl>
							<dt>${setting.instantMessagingTitle}</dt>
							<@instant_messaging_list; instantMessagingList>
								<#list instantMessagingList as instantMessaging>
									<dd>
										<#if instantMessaging.instantMessagingType == "qq">
											<a href="http://wpa.qq.com/msgrd?v=3&uin=${instantMessaging.value}&site=SHOPXX_NET&menu=yes" target="_blank">
												<img src="http://wpa.qq.com/pa?p=2:${instantMessaging.value}:45" alt="QQ${bundle("goods.common.customer.service")}" align="absmiddle" /> ${instantMessaging.title}
											</a>
										<#elseif instantMessaging.instantMessagingType == "msn">
											<a href="msnim:chat?contact=${instantMessaging.value}" target="_blank">
												<img src="${base}/template/shop/images/instant_messaging_msn.gif" alt="MSN${bundle("goods.common.customer.service")}" align="absmiddle" /> ${instantMessaging.title}
											</a>
										<#elseif instantMessaging.instantMessagingType == "wangwang">
											<a href="http://amos1.taobao.com/msg.ww?v=2&uid=${instantMessaging.value}&s=2" target="_blank">
												<img src="${base}/template/shop/images/instant_messaging_wangwang.gif" alt="${bundle("goods.common.chart.wangwang")}${bundle("goods.common.customer.service")}" align="absmiddle" /> ${instantMessaging.title}
											</a>
										<#elseif instantMessaging.instantMessagingType == "skype">
											<a href="callto://${instantMessaging.value}" target="_blank">
												<img src="${base}/template/shop/images/instant_messaging_skype.gif" alt="Skype${bundle("goods.common.customer.service")}" align="absmiddle" /> ${instantMessaging.title}
											</a>
										</#if>
									</dd>
								</#list>
							</@instant_messaging_list>
						</dl>
					</div>
					<div id="closeInstantMessagingMain" class="bottom" title="${bundle("goods.content.buyInfo.closeHighlight")}"></div>
				</div>
			</div>';
		</@compress>
		
		$body.append(instantMessagingHtml);
		
		var $instantMessagingLayer = $("#instantMessagingLayer");
		var $instantMessagingMin = $("#instantMessagingMin");
		var $instantMessagingMain = $("#instantMessagingMain");
		var $closeInstantMessagingMain = $("#closeInstantMessagingMain");
		
		var lastScrollY = 60;
		
		$instantMessagingLayer.show();
		
		function moveInstantMessagingLayer() {
			var diffY;
			if (document.documentElement && document.documentElement.scrollTop) {
				diffY = document.documentElement.scrollTop;
			} else if (document.body) {
				diffY = document.body.scrollTop;
			}
			
			percent = .1 * (diffY - lastScrollY);
			if(percent > 0) {
				percent = Math.ceil(percent);
			} else {
				percent = Math.floor(percent);
			}
			$instantMessagingLayer.css("top", (isNaN(parseInt($instantMessagingLayer.css("top"))) ? 0 : parseInt($instantMessagingLayer.css("top"))) + percent);
			lastScrollY = lastScrollY + percent;
		}
		
		window.setInterval(moveInstantMessagingLayer, 20);
		
		$instantMessagingMin.mouseover( function() {
			$instantMessagingMin.hide();
			$instantMessagingMain.show();
		});
		
		$closeInstantMessagingMain.click( function() {
			$instantMessagingMain.hide();
			$instantMessagingMin.show();
		});
	</#if>

});

(function($) {
	$.uniq = function(m) {
		var ret = [],
		l = m.length,
		e = 0,
		c = {};
		for (var i = 0; i < l; i++) {
			c[m[i]] = null
		}
		for (var i in c) {
			ret.push(i)
		}
		return ret;
	}
})($);

var compareList = function(b, c) {
	var d,
	a = [];
	$("#shop_contrast > table > tbody > tr").each(function(key, value) {
		d = $("td", value).not(".data_empty");
		var g = [];
		d.each(function(i, k) {
			g.push($.trim($(d[i]).text()))
		});
		var h = $.uniq(g).length;
		if (c) {
			if (h != 1 && b) {
				$(this).addClass("differ")
			} else {
				if (h != 1 && !b) {
					$(this).removeClass("differ")
				}
			}
		} else {
			if (h == 1 && b) {
				$(this).css("display", "none")
			} else {
				if (h == 1 && !b) {
					$(this).css("display", "")
				}
			}
		}
	})
};



var highlightFlag = false, k = false;
var highlightNotEqual = "\u9AD8\u4EAE\u663E\u793A\u4E0D\u540C\u9879",
    cancelHighlightNotEqual = "\u53D6\u6D88\u9AD8\u4EAE\u4E0D\u540C\u9879",
    j = "\u663E\u793A\u76F8\u540C\u9879",
		h = "\u9690\u85CF\u76F8\u540C\u9879";
var f = "<b></b>";
$("#compare_highlight").bind("click", function(e) {
    e.preventDefault();
    if (!highlightFlag) {
        highlightFlag = true;
        compareList(true, true);
        $(this).html(f + cancelHighlightNotEqual)
    } else {
        highlightFlag = false;
        compareList(false, true);
        $(this).html(f + highlightNotEqual)
    }
});

$("#compare_equal").bind("click", function(l) {
    l.preventDefault();
    if (!k) {
        k = true;
        compareList(true, false);
        $(this).html(f + j)
    } else {
        k = false;
        compareList(false, false);
        $(this).html(f + h)
    }
});

$("#add_compare_goods").bind("click", function(e) {
    e.preventDefault();
    var goodsCategory = $.cookie('compare-goodsCategory');
    var redirectUrl = '${base}/shop/goods_list/' + goodsCategory + '.htm';
    location.href = redirectUrl;
});