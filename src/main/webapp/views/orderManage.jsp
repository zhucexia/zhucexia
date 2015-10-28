<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	// Set request data code convertion
	request.setCharacterEncoding("UTF-8");
	// Application common variables
	String root = request.getContextPath();
	request.setAttribute("root",root);
	
%>
<jsp:include page="/views/common/header.jsp" />
<jsp:include page="/views/common/top.jsp" />
<html lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>助策侠网络科技有限公司 订单管理</title>
<link type="text/css" rel="stylesheet"
	href="${root }/static/css/plugins/bootstrap.css">
<link type="text/css" rel="stylesheet"
	href="${root }/static/css/user/ucenter.css">
<link rel="stylesheet"
	href="${root }/static/css/plugins/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${root }/static/css/plugins/facebox.css">
<link 
	rel="stylesheet" href="${root }/static/css/plugins/jquery-ui.min.css">
<link rel="stylesheet" type="text/css"
		href="${root }/static/css/common/skin.css" media="all">
<script 
	src="${root }/static/js/common/jquery-1.10.2.min.js"></script>
<script 
	src="${root }/static/js/plugins/jquery-ui-1.10.3.min.js"></script>
<script 
	src="${root }/static/js/plugins/jquery.ui.datepicker-zh-CN.js"></script>
<script 
	src="${root }/static/js/plugins/bootstrap-alert.js"></script>
<script 
	src="${root }/static/js/plugins/bootstrap-dropdown.js"></script>
<script type="text/javascript"
	src="${root }/static/js/plugins/bootstrap-modal_2_3.js"></script>
<script type="text/javascript"
	src="${root }/static/js/plugins/bootstrap-timepicker.js"></script>
<script 
	src="${root }/static/js/plugins/plupload.full.min.js"></script>
<script 
	src="${root }/static/js/plugins/facebox.js"></script>
<script 
	src="${root }/static/js/common/da.js"></script>
</head>
<body class="">
	<div class="WB_miniblog">
		<div class="topNavWrap-pindao" style="background-color:">
			<div class="grhead">
				<div class="grinfo">
					<div class="site-nav">
					</div>
				   <div class="navRt wisub">
					<!--<a href="http://www.zhucexia.com/home/"> 我的账户 </a> |
					<a href="./助策侠网络科技有限公司 订单管理_files/助策侠网络科技有限公司 订单管理.html" class="selected"> 我的交易 </a> |-->
				   </div>
				</div>
			</div>
		</div>
        <div class="second_newmenu">
                	<div class="navboxSecond">
                		<div class="subNav" id="widget-subnav">
                			<span class="clt"></span><span class="crt">
                			</span><span class="clb"></span>
                			<span class="crb"></span>
              				<div class="navRt wisub">
             					 <a href="http://www.zhucexia.com/home/"> 我的账户 </a> |
              					 <a href="http://www.zhucexia.com/orders/"> 我的交易 </a> |
              				</div>
              			</div>
              		</div> 	
        </div>		
		<div class="second_newmenu-fix"></div>
		<div class="grbg">
		<div class="s_main">
		<div class="border_gray clearfix">
			<!-- tabs -->
			<div class="pc_tabs pc_tabs-full mb20 clearfix">
				<div class="tabGray">
					<div class="tabBox leftTab">
						<ul class="tabLinks">
							<li class="selected">
								<a href="./助策侠网络科技有限公司 订单管理_files/助策侠网络科技有限公司 订单管理.html">订单管理</a>
							</li>
							<li>
								<a href="http://www.zhucexia.com/unreview/items/">评价管理</a>
							</li>
							<li>
								<a href="http://www.zhucexia.com/favorites/">收藏管理</a>
							</li>
							<li>
								<a href="http://www.zhucexia.com/addressbook/">收货地址管理</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- contant -->
			<div class="setting_wrap clearfix">
				<div class="setting_main">
					<div class="setting_main_inner">
						<div class="innerbox">
							<h1>我的订单列表</h1>
							<p>你目前没有任何订单.</p>
						</div>
					</div>
				</div>
				<div class="setting_aside">
					<ul class="aside_inner">
						<li class="selected">
							<a href="http://www.zhucexia.com/orders/?state=None">所有订单<i class="icon-arrow aside_inner_arrow"></i></a>
						</li>
						<li>
							<a href="http://www.zhucexia.com/orders/?state=0">待确认的订单<i class="icon-arrow aside_inner_arrow"></i></a>
						</li>
						<li>
							<a href="http://www.zhucexia.com/orders/?state=1">待付款的订单<i class="icon-arrow aside_inner_arrow"></i></a>
						</li>
						<li>
							<a href="http://www.zhucexia.com/orders/?state=2">待发货的订单<i class="icon-arrow aside_inner_arrow"></i></a>
						</li>
						<li>
							<a href="http://www.zhucexia.com/orders/?state=3">已发货的订单<i class="icon-arrow aside_inner_arrow"></i></a>
						</li>
						<li>
							<a href="http://www.zhucexia.com/orders/?state=4">已完成的订单<i class="icon-arrow aside_inner_arrow"></i></a>
						</li>
						<li>
							<a href="http://www.zhucexia.com/orders/?state=5">已取消的订单<i class="icon-arrow aside_inner_arrow"></i></a>
						</li>
					</ul>
				</div>
				<!--end-->
			</div>
		</div>
	  	<script type="text/javascript" charset="utf-8">
			$(function(){
			  $.ajaxSetup({
				data: {csrfmiddlewaretoken: 'oF0Z83AWina7gdj34qVGpM8IKOyQNS2U' },
			  });
			  $(".delete_order").click(function(event){
				event.preventDefault();
				if (confirm("确定要删除这个订单吗？")){
				  var pk = parseInt($(this).attr("order_id"));
				  $.ajax({
					url: "http://www.zhucexia.com/orders/delete/" + pk + "/",
					type: "POST",
					success: function(data, status, jqxhr){
					  location.reload();
					},
					error: function(data, status, jqxhr){
					  alert("删除订单失败，请刷新页面后重试");
					  location.reload();
					},
				  })
				}
			  });
			  $(".cancel_order").click(function(event){
				event.preventDefault();
				if (confirm("确定要取消这个订单吗？")){
				  var pk = parseInt($(this).attr("order_id"));
				  $.ajax({
					url: "http://www.zhucexia.com/orders/cancel/" + pk + "/",
					type: "POST",
					success: function(data, status, jqxhr){
					  location.reload();
					},
					error: function(data, status, jqxhr){
					  alert("取消订单失败，请刷新页面后重试");
					  location.reload();
					},
				  })
				}
			  });
			});
		</script>	
		<script type="text/javascript">
		     // 导航选卡
		     $(function(){
			   ch = $('.wisub').children();
			   $.each(ch, function(index, value){
				   if (value && (window.location.href ==value.href || window.location.pathname == value.href)) {
					   $(value).addClass("selected");
				   }
			   });
		     })
			   /*    window.onload=function(){
				  ct_name = document.body.getAttribute("class");

				  if (ct_name != "") {
				  current_tab = document.getElementById(ct_name);
				  current_tab.className += "active";
				  }
				  }*/
		</script>		
</body>
<jsp:include page="/views/common/footer.jsp" />
</html>

