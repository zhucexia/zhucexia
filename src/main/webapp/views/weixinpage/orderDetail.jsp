<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	// Set request data code convertion
	request.setCharacterEncoding("UTF-8");
	// Application common variables
	String root = request.getContextPath();
	request.setAttribute("root",root);
	Map<String,Object> order = (HashMap<String,Object>)request.getAttribute("order");
%>
<!DOCTYPE html>
<html>
<head>
 	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 	<meta name="viewport" id="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"/>
  	<meta name="apple-mobile-web-app-capable" content="yes"/>
  	<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
	<title></title>
	<script language="javascript" src="${root}/static/js/common/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${root}/static/css/weixin/weixin.css">
</head>
<body>
	<div class="divbody">
		<div class="head" >
			<div class="head_logo" >
				<img src="${root}/static/images/header/logo.png" style="height:100%;">
			</div>
			<div class="head_p">注册侠  你创业的梦想由我来守护</div>
		</div>
		<div class="order">
		<div class="order_head">
			<div class="order_code">
				<span>订单编号:</span>${order.order_no}
			</div>
			<div class="order_code">
				<span>下单时间:</span>${order.orderstate_time}
			</div>
		</div>
		<div class="order_body">
			<img src="http://${order.order_pic}" style="height:100%;float:left;margin-right:10px;">
			<div >
				<span>订单金额:</span>${order.order_money}
			</div>
			<div >
				<span>收货地址:</span>${order.address}${order.areaRegion}${order.street}
			</div>
			<c:if test="${order.payment_code!='cash_on_delivery' or (empty order.payment_code)}">
				<c:if test="${order.payment_state==0 and order.order_state==1}">
					<div >
						<span>订单状态:</span>待付款
					</div>
				</c:if>
				<c:if test="${order.payment_state==1 and order.order_state==1}">
					<div >
						<span>订单状态:</span>处理中
					</div>
				</c:if>
				<c:if test="${order.payment_state==1 and order.order_state==2 }">
					<div >
						<span>订单状态:</span>交易完成
					</div>
				</c:if>
				<c:if test="${order.order_state==9 }">
					<div>
						<span>订单状态:</span>已取消
					</div>
				</c:if>
			</c:if>
			<c:if test="${order.payment_code=='cash_on_delivery'}">
				<c:if test="${order.order_state==1 }">
					<div >
						<span>订单状态:</span>处理中
					</div>
				</c:if>
				<c:if test="${order.payment_state==1 and order.order_state==2 }">
					<div >
						<span>订单状态:</span>交易完成
					</div>
				</c:if>
				<c:if test="${ order.order_state==9 }">
					<div >
						<span>订单状态:</span>已取消
					</div>
				</c:if>
			</c:if>
		</div>
		<div>
			<c:if test="${order.payment_code!='cash_on_delivery' or (empty order.payment_code)}">
				<c:if test="${order.payment_state==0 and order.order_state==1}">
					<div class="order_btn">
						<a href="${root}/details/querryOrderDetail?id=${order.id}" target="_blank">立即付款</a>
						<a class="cancle_order" href="javascript:;">取消订单</a>
					</div>
				</c:if>
				<c:if test="${order.payment_state==1 and order.order_state==1}">
					<div class="order_btn">
						<a class="complete_order" href="javascript:;">确认完成</a>
						<a class="cancle_order" href="javascript:;">取消订单</a>
					</div>
				</c:if>
				<c:if test="${order.payment_state==1 and order.order_state==2 }">
					<div class="order_btn">
						<a href="${root}/details/querryOrderDetail?id=${order.id}" target="_blank">查看详情</a>
						<a class="del_order" href="javascript:void(0)">删除订单</a>
					</div>
				</c:if>
				<c:if test="${order.order_state==9 }">
					<div class="order_btn">
						<a href="${root}/details/querryOrderDetail?id=${order.id}" target="_blank">查看详情</a>
						<a class="del_order" href="javascript:void(0)">删除订单</a>
					</div>
				</c:if>
			</c:if>
			<c:if test="${order.payment_code=='cash_on_delivery'}">
				<c:if test="${order.order_state==1 }">
					<div class="order_btn">
						<a class="complete_order" href="javascript:;">确认完成</a>
						<a class="cancle_order" href="javascript:;">取消订单</a>
					</div>
				</c:if>
				<c:if test="${order.payment_state==1 and order.order_state==2 }">
					<div class="order_btn">
						<a href="${root}/details/querryOrderDetail?id=${order.id}" target="_blank">查看详情</a>
						<a class="del_order" href="javascript:void(0)">删除订单</a>
					</div>
				</c:if>
				<c:if test="${ order.order_state==9 }">
					<div class="order_btn"> 
						<a href="${root}/details/querryOrderDetail?id=${order.id}" target="_blank">查看详情</a>
						<a class="del_order" href="javascript:void(0)">删除订单</a>
					</div>
				</c:if>
			</c:if>
		</div>
	</div>
	</div>
	
	<style type="text/css">
		.order_btn{position:relative;height:30px;}
		.order_btn a{position:absolute;text-decoration:none;color:#477FFF;top:10px;}
		.order_btn a:nth-child(1){left:10px;}
		.order_btn a:nth-child(2){right:10px;}
	</style>
	<script type="text/javascript">
		$(".cancle_order").click(function(){
			var id=${order.id};
			$.ajax({
				url:"${root}/WXOrder/cancleOrder",
				data:{"id":id},
				type:"post",
				success:function(data){
					if(data==0){
						location.reload();
					}
					if(data==1){
						alert("取消订单失败，请稍后重试");
					}
				}
			});
		});
		$(".complete_order").click(function(){
			var id=${order.id};
			$.ajax({
				url:"${root}/WXOrder/completeOrder",
				data:{"id":id},
				type:"post",
				success:function(data){
					if(data==0){
						location.reload();
					}
					if(data==1){
						alert("订单确认完成失败，请好厚重试");
					}
				}
			});
		});
		$(".del_order").click(function(){
			var id=${order.id};
			alert(id);
			$.ajax({
				url:"${root}/WXOrder/delOrder",
				data:{"id":id},
				type:"post",
				success:function(data){
					if(data==0){
						location.href="${root}/WXOrder/orderManage"
					}
					if(data==1){
						alert("删除订单失败，请稍后重试");
					}
				}
			});
		});
	</script>
<jsp:include page="/views/weixinpage/foot.jsp"/>