<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	// Set request data code convertion
	request.setCharacterEncoding("UTF-8");
	// Application common variables
	String root = request.getContextPath();
	request.setAttribute("root",root);	
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 	<meta name="viewport" id="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"/>
  	<meta name="apple-mobile-web-app-capable" content="yes"/>
  	<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
	<title>注册侠网站</title>
	<link rel="stylesheet" type="text/css" href="${root}/static/css/weixin/weixin.css">
	<script language="javascript" src="${root}/static/js/common/jquery.min.js"></script>
	<script src="${root}/static/js/common/hammer.min.js"></script>
	<script src="${root}/static/js/common/jquery.hammer.js"></script>
	<script language="javascript" src="${root}/static/js/common/dialog-h5-min.js"></script>
</head>
<body>
	<div class="divbody" >
		<div class="head" >
			<div class="head_logo" >
				<img src="${root}/static/images/header/logo.png" style="height:100%;">
			</div>
			<div class="head_p">注册侠  你创业的梦想由我来守护</div>
		</div>
		<div class="retina-1px-border-bottom"></div>
		<c:forEach items="${list}" var="item">
		<div class="order">
			<div class="order_head">
				<div class="order_code">
					<span>订单编号:</span>${item.order_no}
				</div>
				<div class="order_code">
					<span>下单时间:</span>${item.orderstate_time}
				</div>
			</div>
			<div class="order_body">
				<div class="order_img">
					<img src="http://${item.order_pic}" style="height:100%;">
				</div>
				<div class="order_price">
					<span>订单金额:</span>${item.order_money}
				</div>
				<div class="order_addr">
					<span>收货地址:</span>${item.address}${item.areaRegion}${item.street}
				</div>
				<c:if test="${item.payment_code!='cash_on_delivery' or (empty item.payment_code)}">
				<c:if test="${item.payment_state==0 and item.order_state==1}">
				<div class="order_state">
					<span>订单状态:</span>待付款
				</div>
				</c:if>
				<c:if test="${item.payment_state==1 and item.order_state==1 }">
				<div class="order_state">
					<span>订单状态:</span>处理中
				</div>
				</c:if>
				<c:if test="${item.payment_state==1 and item.order_state==2 }">
				<div class="order_state">
					<span>订单状态:</span>交易完成
				</div>
				</c:if>
				<c:if test="${item.order_state==9 }">
				<div class="order_state">
					<span>订单状态:</span>已取消
				</div>
				</c:if>
				</c:if>
			</div>
		</div>
		</c:forEach>
	</div>
	<div class="bottom" >
		<ul class="bottom_nav" >
			<li class="bottom_nav_btn cur" >
				<a href="javascript:menushow();">订单管理</a>
			</li>
			<li class="bottom_nav_btn" >
				<a href="${root}/WXUser/userCenter">个人中心</a>
			</li>
			<li class="bottom_nav_btn" style="border:none;">
				<a href="${root}/WXIndex/goodList">返回首页</a>
			</li>
		</ul>
	</div>
	<div class="bottom_menu">
		<div class="bottom_menu_cld">
			<a href="${root}/WXOrder/orderManage?state=0">所有订单</a>
		</div>
		<div class="bottom_menu_cld">
			<a href="${root}/WXOrder/orderManage?state=1">待付款订单</a>
		</div>
		<div class="bottom_menu_cld">
			<a href="${root}/WXOrder/orderManage?state=2">处理中订单</a>
		</div>
		<div class="bottom_menu_cld">
			<a href="${root}/WXOrder/orderManage?state=3">已完成订单</a>
		</div>
		<div class="bottom_menu_cld">
			<a href="${root}/WXOrder/orderManage?state=4">已取消订单</a>
		</div>
	</div>
	<script type="text/javascript">
		function menushow(){
			var status=$(".bottom_menu").css("display");
			if (status=="none") {
				$(".bottom_menu").css("display","block");
			};
			if(status=="block"){
				$(".bottom_menu").css("display","none");
			};
		}
	</script>
</body>
</html>	