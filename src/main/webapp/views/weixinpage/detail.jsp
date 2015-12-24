<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	// Set request data code convertion
	request.setCharacterEncoding("UTF-8");
	// Application common variables
	String root = request.getContextPath();
	request.setAttribute("root",root);	
%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" id="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"/>
	<meta name="apple-mobile-web-app-capable" content="yes"/>
	<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
	<link rel="styleSheet" type="text/css" href="${root}/static/css/weixin/icono.min.css"/>
	<link rel="styleSheet" type="text/css" href="${root}/static/css/weixin/detail.css">
	<link rel="styleSheet" type="text/css" href="${root}/static/css/weixin/weixin.css">
	<script language="javascript" src="${root}/static/js/common/jquery.min.js"></script>
	<title>
		注册侠
	</title>
	
</head>
<body>
	<div class="bg">
		<div style="width:100%">
			<img src="http://${good.pic}" class="cover" />
		</div>
		<div class="briefIntroducation">
			<span class="price">${good.price_market}<span style="font-size:12px">元</span></span>
			<span class='marketPrice'>市场价：${good.price_range}元</span>
			<hr/>
			<span>${good.apply_condition}</span>
			<hr/>
		</div>
		<div style="98%">
			<img src="jiading1.jpg" style="width:80%;margin:auto auto;"/>
		</div>
		<span class="content">服务介绍</span>
		<hr style="margin-top:1%;"/>
		<div class="good_detail">
			${good.detail_content }
		</div>
		<hr style="margin:0px 0px;"/>
	</div>
	<div class="bottom">
		<ul class="bottom_nav">
			<li class="bottom_nav_btn" style="width:20%;">
				<span class="icono-mail emails"></span>
			</li>
			<li class="bottom_nav_btn" style="width:59%;">
				<a href="#" class="orders" style="background:yellow;">免费下单</a>
			</li>
			<li class="bottom_nav_btn" style="width:20%;">
				<span class="icono-mail emails"></span>
			</li>
		</ul>	
	</div>
	<script type="text/javascript">
		alert("aaaaaaa");
		$(".good_detail p img").css("width","100%");
	</script>
</body>
</html>