<%@ page language="java"
	import="java.util.*,com.keji50.zhucexia.dao.po.CustomerPo"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<jsp:include page="/views/common/header.jsp" />
<jsp:include page="/views/common/top.jsp" />
<link rel="stylesheet" type="text/css"
	href="${root }/static/css/order/base.css" />
<script type="text/javascript"
	src="${root }/static/js/order/jquery_cart.js"></script>
<link rel="stylesheet" type="text/css"
	href="${root }/static/css/order/checkOut.css" />
<div class="list-banner">
	<!--广告位producttop_ad-->
</div>
<div id="mainmain">
	<!--收货地址body部分开始-->
	<div>
		<script type="text/javascript">
			var checkoutConfig = {
				addressMatch : 'common',
				addressMatchVarName : 'data',
				hasPresales : false,
				hasBigTv : false,
				hasAir : false,
				hasScales : false,
				hasGiftcard : false,
				totalPrice : 244.00,
				postage : 10,//运费
				postFree : true,//活动是否免邮了
				bcPrice : 150,//计算界值
				activityDiscountMoney : 0.00,//活动优惠
				showCouponBox : 0,
				invoice : {
					NA : "0",
					personal : "1",
					company : "2",
					electronic : "4"
				}
			};
			var miniCartDisable = true;
		</script>
		<div class="container">
			<br />
			<div>
				<%-- <form id="checkoutForm" action="${root}/payment/pay" method="post" target="_blank"> --%>
				<form id="checkoutForm" action="${root}/payment/pay" method="post" target="_blank">
					<div class="checkout-box-bd">
						<!-- 地址状态 0：默认选择；1：新增地址；2：修改地址 -->
						<input type="hidden" name="Checkout[addressState]" id="addrState"
							value="0">
						<!-- 收货地址 -->
						<div class="xm-box">
							<div class="box-hd ">
								<h2 class="title" style="font-weight: bold">收货地址</h2>
								<!---->
							</div>
							<div class="box-bd">
								<div class="clearfix xm-address-list" id="checkoutAddrList">
										<c:if test="${!empty customerAddr}">
											<c:set value="${fn:split(customerAddr.addressId,',')}" var="strs"/>
											<c:set value="${fn:split(customerAddr.address,' ')}" var="str"/>
											<dl class="item selected"  data-isnew="true" data-consignee="${customerAddr.name}" 
													data-tel="${customerAddr.telephone}" data-province="${strs[0]}" 
													data-provincename="${str[0]}" 
													data-city="${strs[1]}" data-cityname="${str[1]}" 
													data-county="${strs[2]}" data-countyname="${customerAddr.areaRegion}" 
													data-zipcode="${customerAddr.zip_code}" data-street="${customerAddr.street}" 
													data-tag="${customerAddr.remark}"
													data-id="${custoemrAddr.id }">
									            <dt>
									                <strong class="itemConsignee">${ customerAddr.name}</strong>
									                <span class="itemTag tag">${customerAddr.remark}</span>
									           </dt>
									            <dd>
									                <p class="tel itemTel">${customerAddr.telephone}</p>
									                <p class="itemRegion">${customerAddr.address} ${customerAddr.areaRegion}</p>
									                <p class="itemStreet">${customerAddr.street} (${customerAddr.zip_code})</p>
									                <input type="hidden" name="addressId" value="${customerAddr.id}" id="Addid">
									                 <c:if test="${saleOrder.paymentstate==0 and saleOrder.paymentcode!='cash_on_delivery'}"> 
									                	<span class="edit-btn J_editAddr">编辑</span>
									                 </c:if> 
									            </dd>
									            <dd style="display:none">
									                <input type="radio" name="Checkout[address]" class="addressId"  value="10140916720030323">
									            </dd>
									        </dl>
								        </c:if>
								        <c:if test="${saleOrder.paymentstate==0 && saleOrder.paymentcode!='cash_on_delivery'}">
								        	<div class="item use-new-addr" id="J_useNewAddr" data-state="off">
												<span class="iconfont icon-add">
												<img src="${root }/static/images/cart/add_cart.png" /></span> 使用新地址
											</div>
								        </c:if>
								</div>
								<input type="hidden" name="newAddress[type]" id="newType" value="common">
								<input type="hidden" name="newAddress[consignee]" id="newConsignee"> 
								<input type="hidden" name="newAddress[province]" id="newProvince">
								<input type="hidden" name="newAddress[city]" id="newCity">
								<input type="hidden" name="newAddress[district]" id="newCounty">
								<input type="hidden" name="newAddress[address]" id="newStreet">
								<input type="hidden" name="newAddress[zipcode]" id="newZipcode">
								<input type="hidden" name="newAddress[tel]" id="newTel">
								<input type="hidden" name="newAddress[tag_name]" id="newTag">
								<!--点击弹出新增/收货地址界面start-->
								<div class="xm-edit-addr-box" id="J_editAddrBox">
									<div class="bd">
										<div class="item">
											<label>收货人姓名<span>*</span></label> <input type="text"
												name="userAddress[consignee]" id="Consignee" class="input"
												placeholder="收货人姓名" maxlength="15" autocomplete='off'>
											<p class="tip-msg tipMsg"></p>
										</div>
										<div class="item">
											<label>联系电话<span>*</span></label> <input type="text"
												name="userAddress[tel]" class="input" id="Telephone"
												placeholder="11位手机号" autocomplete='off'>
											<p class="tel-modify-tip" id="telModifyTip"></p>
											<p class="tip-msg tipMsg"></p>
										</div>
										<div class="item">
											<label>地址<span>*</span></label> <select
												name="userAddress[province]" id="Provinces" class="select-1">
												<option>省份/自治区</option>
											</select> <select name="userAddress[city]" id="Citys" class="select-2"
												disabled>
												<option>城市/地区/自治州</option>
											</select> <select name="userAddress[county]" id="Countys"
												class="select-3" disabled>
												<option>区/县</option>
											</select>
											<textarea name="userAddress[street]" class="input-area"
												id="Street" placeholder="路名或街道地址，门牌号"></textarea>
											<p class="tip-msg tipMsg"></p>
										</div>
										<div class="item">
											<label>邮政编码<span>*</span></label> <input type="text"
												name="userAddress[zipcode]" id="Zipcode" class="input"
												placeholder="邮政编码" autocomplete='off'>
											<p class="zipcode-tip" id="zipcodeTip"></p>
											<p class="tip-msg tipMsg"></p>
										</div>
										<div class="item">
											<label>地址标签<span>*</span></label> <input type="text"
												name="userAddress[tag]" id="Tag" class="input"
												placeholder='地址标签：如"家"、"公司"。限5个字内'>
											<p class="tip-msg tipMsg"></p>
											<input type="hidden" id="AddIds" name="AddrIds">
										</div>
									</div>
									<div class="ft clearfix">
										<button type="button" class="btn btn-lineDake btn-small "
											id="J_editAddrCancel">取消</button>
										<button type="button" class="btn btn-primary  btn-small "
											id="J_editAddrOk">保存</button>
									</div>
								</div>
								<!--点击弹出新增/收货地址界面end-->
								<div class="xm-edit-addr-backdrop" id="J_editAddrBackdrop"></div>
							</div>
						</div>
						<!-- 收货地址 END-->
						<div id="checkoutPayment">
							<!-- 支付方式 -->
							<div class="xm-box">
								<div class="box-hd ">
									<h2 class="title" style="font-weight: bold">支付方式</h2>
								</div>
								<div class="box-bd">
									<ul id="checkoutPaymentList"
										class="checkout-option-list clearfix J_optionList">
										<c:if test="${saleOrder.paymentstate==0 && saleOrder.paymentcode!='cash_on_delivery'}">
											<c:forEach items="${list}" var="item" >
												<c:if test="${item.code=='alipay'}">
													<li class="item selected" style="text-align: center"><input
														type="radio" name="Checkout[pay_id]" checked="checked" value="${item.code}">
														<p>
															${item.name}		
														</p></li>
												</c:if>
												<c:if test="${item.code!='alipay'}">
													<li class="item " style="text-align: center"><input
														type="radio" name="Checkout[pay_id]" value="${item.code}">
														<p>
															${item.name}
														</p></li>
												</c:if>
	                                        </c:forEach>
                                        </c:if>
                                        <c:if test="${saleOrder.paymentstate==1 ||(saleOrder.paymentstate==0 && saleOrder.paymentcode=='cash_on_delivery')}">
                                        	<li class="item selected" style="text-align: center"><input
														type="radio" name="Checkout[pay_id]"	 checked="checked" value="${saleOrder.paymentcode}">
														<p>
															${saleOrder.paymentname}		
														</p></li>
                                        </c:if>
									</ul>
								</div>
							</div>
							<!-- 支付方式 END-->

							<!-- 配送方式 END-->
							<!-- 配送方式 END-->
						</div>
						<!-- 发票信息 -->
						<div id="checkoutInvoice">
							<div class="xm-box">
								<div class="box-hd">
									<h2 class="title" style="font-weight: bold">发票信息</h2>
								</div>
								<div class="box-bd">
									<ul
										class="checkout-option-list checkout-option-invoice clearfix J_optionList J_optionInvoice">
										<li class="hide">电子个人发票4</li>
										<li class="item selected">
											<!--<label><input type="radio"  class="needInvoice" value="0" name="Checkout[invoice]">不开发票</label>-->
											<input type="radio" checked="checked" value="4"
											name="Checkout[invoice]">
											<p>电子发票（非纸质）</p>
										</li>
										<li class="item "><input type="radio" value="1"
											name="Checkout[invoice]">
											<p>普通发票（纸质）</p></li>
									</ul>
									<p id="eInvoiceTip" class="e-invoice-tip ">
										电子发票是税务局认可的有效凭证，可作为售后维权凭据，不随商品寄送。开票后不可更换纸质发票，如需报销请选择普通发票。<!-- <a
											href="http://bbs.xiaomi.cn/thread-9285999-1-1.html"
											target="_blank">什么是电子发票？</a> -->
									</p>
									<div class="invoice-info nvoice-info-1"
										id="checkoutInvoiceElectronic" style="display: none;">

										<p class="tip">电子发票目前仅对个人用户开具，不可用于单位报销 ，不随商品寄送</p>
										<p>发票内容：购买商品明细</p>
										<p>发票抬头：个人</p>
										<p>
											<span class="hide"><input type="radio" value="4"
												name="Checkout[invoice_type]" checked="checked"
												id="electronicPersonal" class="invoiceType"></span>
										<dl>
											<dt>什么是电子发票?</dt>
											<dd>&#903;
												电子发票是纸质发票的映像，是税务局认可的有效凭证，与传统纸质发票具有同等法律效力，可作为售后维权凭据。</dd>
											<dd>&#903; 开具电子服务于个人，开票后不可更换纸质发票，不可用于单位报销。</dd>
											<dd>
												&#903; 您在订单详情的"发票信息"栏可查看、下载您的电子发票。<!-- <a
													href="http://bbs.xiaomi.cn/thread-9285999-1-1.html"
													target="_blank">什么是电子发票？</a> -->
											</dd>
										</dl>
										</p>
									</div>
									<div class="invoice-info invoice-info-2"
										id="checkoutInvoiceDetail" style="display: none;">
										<p>发票内容：购买商品明细</p>
										<p>发票抬头：请确认单位名称正确,以免因名称错误耽搁您的报销。注：合约机话费仅能开个人发票</p>
										<ul class="type clearfix J_invoiceType">
											<li class="hide"><input type="radio" value="0"
												name="Checkout[invoice_type]" id="noNeedInvoice"></li>
											<li class=""><input class="invoiceType" type="radio"
												id="commonPersonal" name="Checkout[invoice_type]" value="1">
												个人</li>
											<li class=""><input class="invoiceType" type="radio"
												name="Checkout[invoice_type]" value="2"> 单位</li>
										</ul>
										<div id='CheckoutInvoiceTitle' class=" hide  invoice-title">
											<label for="Checkout[invoice_title]">单位名称：</label> <input
												name="Checkout[invoice_title]" type="text" maxlength="49"
												value="" class="input"> <span
												class="tip-msg J_tipMsg"></span>
										</div>

									</div>

								</div>
							</div>
						</div>
						<!-- 发票信息 END-->
					</div>
					<div class="checkout-box-ft">
						<!-- 商品清单 -->
						<div id="checkoutGoodsList" class="checkout-goods-box">
							<div class="xm-box">
								<div class="box-hd">
									<h2 class="title" style="font-weight: bold">确认订单信息</h2>
								</div>
								<div class="box-bd">
									<dl class="checkout-goods-list">
										<dt class="clearfix">
											<span class="col col-1">商品名称</span> <span class="col col-2">购买价格</span>
											<span class="col col-3">小计（元）</span>
										</dt>
										<c:if test="${! empty chooseGood}">
											<c:forEach items="${chooseGood}" var="item"
												varStatus="status">
												<dd class="item clearfix">
													<div class="item-row">
														<div class="col col-1">
															<div class="g-pic">
																<img src="http://${item.value.pic}"
																	width="40" height="40" />
															</div>
															<div class="g-info">
																<a
																	href="${root }/good/goodsdetail?id="
																	+${item.value.id} target="_blank">
																	${item.value.name}</a>
															</div>
														</div>
														<div class="col col-2">${item.value.price_market}元</div>
														<!--  <div class="col col-3">1</div> -->
														<div class="col col-4">${item.value.price_market}元</div>
													</div>
												</dd>
											</c:forEach>
										</c:if>
										<dt class="clearfix">
											<span class="col col-1">&nbsp;</span> <span class="col col-2">&nbsp;</span>
											<span class="col col-3"
												style="font-weight: bold; color: red; font-size: 18px;">总计：&nbsp;&nbsp;${saleOrder.ordermoney}元</span>
										</dt>
									</dl>
								</div>
							</div>
						</div>
						<!-- 商品清单 END -->
						<!-- 总价格 -->
						<!-- 订单id -->
						<input type="hidden" name="orderId" value="${saleOrder.id}">
						<input type="hidden" name="addrId" id="addrId" value="<c:if test="${!empty customerAddr}">${customerAddr.id}</c:if>">
						<input type="hidden" id="couponType" name="Checkout[couponsType]">
						<input type="hidden" id="couponValue"
							name="Checkout[couponsValue]">
						<div class="checkout-confirm">
						<c:if test="${saleOrder.paymentstate==0 && saleOrder.paymentcode!='cash_on_delivery'}">
							<a href="${root}/sales/returnCart"
								class="btn btn-lineDakeLight btn-back-cart">返回购物车</a> <input
								type="submit" class="btn btn-primary" value="立即付款"
								id="checkoutToPay" />
						</c:if>
						</div>
					</div>
			</div>

			</form>

		</div>
		<!-- 禮品卡提示 S-->
		<div class="modal hide lipin-modal" id="lipinTip">
			<div class="modal-header">
				<h2 class="title">温馨提示</h2>
				<p>
					为保障您的利益与安全，下单后礼品卡将会被使用，<br> 且订单信息将不可修改。请确认收货信息：
				</p>
			</div>
			<div class="modal-body">
				<ul>
					<li><strong>收&nbsp;&nbsp;货&nbsp;&nbsp;人：</strong><span
						id="lipin-uname"></span></li>
					<li><strong>联系电话：</strong><span id="lipin-uphone"></span></li>
					<li><strong>收货地址：</strong><span id="lipin-uaddr"></span></li>
				</ul>
			</div>
			<div class="modal-footer">
				<span class="btn btn-primary" id="useGiftCard">确认下单</span><span
					class="btn btn-dakeLight" id="closeGiftCard">返回修改</span>
			</div>
		</div>
		<!--  禮品卡提示 E-->
		<!-- 预售提示 S-->
		<div class="modal hide yushou-modal" id="yushouTip">
			<div class="modal-body">
				<h2>请确认收货地址及发货时间</h2>
				<ul class="list">
					<li><strong>请确认配送地址，提交后不可变更：</strong>
						<p id="yushouAddr"></p> <span class="icon-common icon-1"></span></li>
					<li><strong>支付后发货</strong>
						<p>如您随预售商品一起购买的商品，将与预售商品一起发货</p> <span class="icon-common icon-2"></span>
					</li>
					<li><strong>以支付价格为准</strong>
						<p>如预售产品发生调价，已支付订单价格将不受影响。</p> <span class="icon-common icon-3"></span>
					</li>
				</ul>
			</div>
			<div class="modal-footer">
				<p id="yushouOk" class="yushou-ok">
					<span class="icon-checkbox"><i class="iconfont">&#xe626;</i></span>
					我已确认收货地址正确，不再变更
				</p>
				<span class="btn btn-lineDakeLight" data-dismiss="modal">返回修改地址</span>
				<span class="btn btn-primary" id="yushouCheckout">继续下单</span>

			</div>
		</div>
		<!-- 选择页面，该页面为2 -->
		<input type="hidden" value="2" id="flag">
		<!--  预售提示 E-->

		<script id="newAddrTemplate" type="text/x-dot-template">
        <dl class="item selected" data-isnew="true" data-consignee="{{=it.consignee}}" data-tel="{{=it.tel}}" data-province="{{=it.province}}" data-provincename="{{=it.provinceName}}" data-city="{{=it.city}}" data-cityname="{{=it.cityName}}" data-county="{{=it.county}}" data-countyname="{{=it.countyName}}" data-zipcode="{{=it.zipcode}}" data-street="{{=it.street}}" data-tag="{{=it.tag}}">
            <dt>
                <strong class="itemConsignee">{{=it.consignee}}</strong>
                {{? it.tag }}
                    <span  class="itemTag tag">{{=it.tag}}</span>
                {{?}}
            </dt>
            <dd>
                <p class="tel itemTel">{{=it.tel}}</p>
                <p class="itemRegion">{{=it.provinceName}} {{=it.cityName}} {{=it.countyName}}</p>
                <p class="itemStreet">{{=it.street}} ({{=it.zipcode}})</p>
                <span class="edit-btn J_editAddr">编辑</span>
            </dd>
			<dd style="display:none">
				 <input type="radio" name="Checkout[address]" class="addressId"  value="10140916720030323">
		   </dd>
        </dl>
</script>

		<script src="${root }/static/js/order/base.min.js"></script>
		<script type="text/javascript"
			src="${root }/static/js/order/address_all.js"></script>
		<script type="text/javascript"
			src="${root }/static/js/order/checkout.min.js"></script>
	</div>
</div>

<jsp:include page="/views/common/footer.jsp" />
