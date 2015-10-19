<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/views/common/header.jsp" />
<jsp:include page="/views/common/top.jsp" />
<div class="list-banner">
	<!--广告位producttop_ad-->
</div>
<div id="mainmain">
	<c:forEach items="${ good}" var="go" varStatus="status">
	<c:if test="${status.index==0 }">
	<div class="pro-main  container">
		<div class="pro-left clearfix">
			<c:if test="${go.good_type_id  == 1}">
				<div class="pro-left-imgs">
					<div class="big-img">
						<a class="jqzoom" href="javascript:void(0);"><img id="bigSS"
							src="${root }/static/images/index/goods/${go.pic}"
							jqimg="${root }/static/images/product/product_hongkou_315.jpg"
							width="315"></a>
					</div>
				</div>
			</c:if>
			<c:if test="${go.good_type_id  == 2}">
				<div class="pro-left-imgs">
					<div class="big-img">
						<a class="jqzoom" href="javascript:void(0);"><img id="bigSS"
							src="${root }/static/images/index/banner/${go.pic}"
							jqimg="${root }/static/images/product/product_hongkou_315.jpg"
							width="315"></a>
					</div>
				</div>
			</c:if>
			<div class="pro-left-txts clearfix">
				<div class="proll">
					<div class="pro-name">${go.name}</div>
						<div class="clearfix price-wrap">
						<dl class="pro-price">
							<dt>价格</dt>
							<dd><span>${go.price_market }</span><del>${go.price_range }</del></dd>
						</dl>
						<dl class="pro-price">
							<dt>注册时长</dt>
							<dd>${go.register_cost}</dd>
						</dl>
						<em class="line"></em>	
					</div>					
					<div class="pro-attr">
						<c:forEach var="goodattr" items="${ good}">
							<dl>
							<dt>${goodattr.names }：</dt>
							<dd>${goodattr.option_value }</dd>
							</dl>
						</c:forEach>
						<dl>
							<dt>申请条件：</dt>
							<dd>${go.apply_condition }</dd>
						</dl>
					</div>
				</div>
				<div class="prorr">
					<div class="buy_content_button">
					<!-- 	<a class="btn" href="＃" target="_blank">加入订单</a>
						<a class="btn wrap_btn2" href="＃" target="_blank">在线咨询</a>
 -->						<a class="" href="＃" target="_blank">加入订单</a>
						<a class="wrap_btn2" href="＃" target="_blank">在线咨询</a>
						<span>?购买须知</span>
					
					</div>
				</div>
				<script src="${root }/static/js/detail/shop_common.js"></script>
				<link href="${root }/static/css/plugins/mallpublic.css" type="text/css" rel="stylesheet"/>
			</div>
		</div>
	</div>
	<div class="proInfo">
		<div class="">
			<div class="proDetail" id="proDetail">
				<div class="zc_detail_head">
					<ul class="navlist">
						<li class="actives select"><a href="javascript:">详细说明</a></li>
					</ul>
				</div>
				<div class="bd typo">
					<p style="text-align: center;">
						<span style="font-size: 24px;">套餐内容</span>
					</p>
					<p style="text-align: center">
						<img src="${root }/static/images/product/product_taocanneirong.jpg"
							alt="product_taocanneirong.jpg" width="950" height="208"
							border="0" vspace="0" style="width: 950px; height: 208px;">
					</p>
					<p style="text-align: center;">
						<span style="font-size: 24px;">注册流程<br></span>
					</p>
					<p>
						<br>
					</p>
					<p style="text-align: center">
						<img src="${root }/static/images/product/product_zhuceliucheng.jpg"
							alt="product_zhuceliucheng.jpg" width="950" height="236"
							border="0" vspace="0" style="width: 950px; height: 236px;">
					</p>
					<p style="text-align: center;">
						<span style="font-size: 24px;">企业需要做什么</span>
					</p>
					<p>
						<br>
					</p>
					<p style="text-align: center">
						<img src="${root }/static/images/product/product_qiyezuoshenme.jpg"
							alt="">
					</p>
					<p>
						<br>
					</p>
					<p style="text-align: center">
						<br>
					</p>
				</div>
			</div>
		</div>

	</div>
	</c:if>
			</c:forEach>
</div>

<jsp:include page="/views/common/footer.jsp" />