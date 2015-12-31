<%@ page language="java" import="java.util.*,com.keji50.zhucexia.dao.po.CustomerPo" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% CustomerPo customer = (CustomerPo)request.getSession().getAttribute("customer");%>
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
	<title>注册侠</title>
	<script language="javascript" src="${root}/static/js/common/jquery.min.js"></script>
	<script src="${root}/static/js/common/hammer.min.js"></script>
	<script src="${root}/static/js/common/jquery.hammer.js"></script>
	<script language="javascript" src="${root}/static/js/common/dialog-h5-min.js"></script>
	<link rel="stylesheet" type="text/css" href="${root}/static/css/weixin/weixin.css">
</head>
<body>
	<div class="divbody" style="padding-bottom:10px" >
		<!-- <div class="city_box" >
			<div class="ui_list_btn_left" >
				<div class="cityname" >
					<i class="icon iconfont" ></i>
					<span>ä¸æµ·å¸</span>
				</div>
			</div>
			<div class="ui_list_btn_right" >
				<div class="ui_list_btn_right_icon" >
					<i><</i>
				</div>
			</div>
		</div>
		<div class="retina-1px-border-bottom" ></div> -->
		<div class="bannerBox" >
			<img src="${root}/static/images/index/ads/ads1.jpeg" style="width:100%;" >
		</div>
		<ul style="padding:0; list-style-type:none;">
			<c:forEach items="${goodList}" var="good" >
			<li>
				<div class="plistBox" >
					<div class="p_list" >
						<div class="p_list_h1" >
							<div class="p_list_name" >${good.name }</div>
							<div class="p_price" >
								<span class="cs" >${good.price_market}</span>元
							</div>
						</div>
						<div class="retina-1px-border-bottom"></div>
						<div class="p_list_h2" >
							<div class="p_list_h2_title">服务内容:</div>
							<div style="width:100%;">
								<img src="${good.detail_content }" style="width:50%;">
							</div>
						</div>
						<div class="p_list_h3" >
							<a href="${root}/WXGood/goodDetail?id=${good.id}" class="p_list_btn" >立即注册</a>
						</div>
						<div class="retina-1px-border-bottom" ></div>
					</div>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>

	<script type="text/javascript">
		function myorder(){
			<%if(customer==null){%>
				location.href="${root}/WXUser/toLogin?aim=1";
			<%}else{%>
				location.href="${root}/WXOrder/orderManage";
			<%}%>
		}
		function userCenter(){
			<%if(customer==null){%>
				location.href="${root}/WXUser/toLogin?aim=3";
			<%}else{%>
				location.href="${root}/WXUser/userCenter";
			<%}%>
		}
	</script>
<jsp:include page="/views/weixinpage/foot.jsp"></jsp:include>