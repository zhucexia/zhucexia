<%@ page language="java" import="java.util.*,com.keji50.zhucexia.dao.po.CustomerPo" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/views/common/header.jsp" />

<jsp:include page="/views/common/top.jsp" />

	<div class="list-banner">
	<!--广告位producttop_ad-->
</div>
<div id="mainmain">
	<c:forEach items="${good}" var="go">
	<div class="pro-main  container">
		<div class="pro-left clearfix">
			<div class="pro-left-imgs">
				<div class="big-img">
					<a class="jqzoom" href="javascript:void(0);"><img id="bigSS"
						src="http://${go.pic}"
						jqimg="${root }/static/images/product/product_hongkou_315.jpg"
						width="315"></a>
				</div>
			</div>
			<div class="pro-left-txts clearfix">
				<div class="proll">
					<div class="pro-name">${go.name}</div>
						<div class="clearfix price-wrap">
						<dl class="pro-price">
							<dt>价格</dt>
							<dd><span>￥${go.price_range }</span><del>￥${go.price_market}</del></dd>
						</dl>
						<dl class="pro-price">
							<dt>注册时长</dt>
							<dd>${go.register_cost}</dd>
						</dl>
						<em class="line"></em>	
					</div>					

					<div class="pro-attr">
					<c:if test="${! empty go.names} }">
					
						<dl>
							<dt>${go.names }：</dt>
							<dd>${go.option_value }</dd>
						</dl>
					</c:if>
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
 -->						<a class="" href="javascript:void(0)"  id="bookOrder"  onclick="bookOrder(${go.id})"target="_blank">加入订单</a>
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
					${go.detail_content}
				</div>
			</div>
		</div>

	</div>
			</c:forEach>
</div>
<script type="text/javascript">
	function bookOrder(id){
			<%CustomerPo customerPo = (CustomerPo)request.getSession().getAttribute("customer");
				if(customerPo!=null){
			%>
				location.href="${root}/sales/toBuildOrder?id="+id;			
			<%}else{ %>
			$("#log").show();

			<%}%>

    }


</script>

<jsp:include page="/views/common/footer.jsp" />
