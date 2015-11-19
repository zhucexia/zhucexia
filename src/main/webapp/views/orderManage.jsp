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
<body class="" onload="getSelected();">
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
             					 <a href="${root }/sales/userManager"> 我的账户 </a> |
              					 <a href="${root}/sales/toOrderManage"> 我的交易 </a> |
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
									<a href="${root}/sales/toOrderManage">订单管理</a>
								</li>
								<!-- <li>
									<a href="http://www.zhucexia.com/unreview/items/">评价管理</a>
								</li>
								<li>
									<a href="http://www.zhucexia.com/favorites/">收藏管理</a>
								</li> -->
								<li>
									<a href="${root}/address/addrManage">收货地址管理</a>
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
			              		<c:if test="${ ! empty list }">
			              		<div class="order-actions">
			              			<div class="ll">
			              				<form action="${root}/sales/toOrderManage" method="post" class="form-search">
			              					<input type="hidden" name="csrfmiddlewaretoken" value="rSAEEvaYG3XRFZN0sY84Dlzv57oq4UTN">
			              					<select name="date-filter" id="date-filter">
			              						<option value="0">全部</option>
			              						<option value="1">1个月</option>
			              						<option value="3">3个月</option>
			              						<option value="6">6个月</option>
			              						<option value="12" >12个月</option>
			              					</select>
			              					<input type="hidden" value="${types}" name="state">
			              					<input type="submit" class="btn"  id="submits" value="筛选">
			              				</form>
			              			</div>
<!-- 			              			<div class="rr"> 
			              				待付款/已确认订单数：<strong id="noPayCount" class="ftx-01">4</strong>&nbsp;&nbsp;
										已付款订单数：<strong id="paidCount" class="ftx-01">5</strong>&nbsp;&nbsp;
										已发货订单数：<strong id="sentCount" class="ftx-01">0</strong>&nbsp;&nbsp;
										订单总数：<strong id="totalCount" class="ftx-01">10</strong>&nbsp;&nbsp; 
									</div> -->
								</div>
								<table class="order-table lfs-default" width="100%">
									<thead>
										<tr>
											<th colspan="2" width="40%">订单简介</th>
											<th width="15%">收货人</th><th width="10%">订单金额</th>
											<th width="10%">下单时间</th><th width="15%">订单状态</th>
											<th width="10%">操作</th>
										</tr>
									</thead>
									<c:forEach var="item" items="${list}">
									<tbody>
										<tr class="sep-row">
											<td colspan="6"></td>
										</tr>
									    <tr class="order-hd">
									    	<td colspan="9">
									    		<span class="order-count ml8">
			          								订单编号：<span class="order-num">${item.order_no}</span>
			          							</span>
			          							<span class="deal-time ml10">下单时间: <fmt:formatDate value="${item.orderstate_time }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
			          							<span class="seller ml8">助策侠网络科技有限公司</span>
			          						</td>
			          					</tr>
			          					<tr class="order-bd">
			          						<td colspan="2">
			          							<div class="order-item-block">
			          								<div class="order-pitem">
			          									<img src="${root }/static/images/${item.order_pic}" alt="" width="70">
			          									<a href="" title="" target="_blank">${item.remark}</a>
			          								</div>
			          							</div>
			          						</td>
			          						<td>${item.name }</td>
			          						<td>￥${item.order_money}<br>${item.payment_name }</td>
			          						<td><fmt:formatDate value="${item.orderstate_time }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			          							<c:if test="${item.payment_code!='cash_on_delivery' or (empty item.payment_code)}">
			          								<c:if test="${item.payment_state==0 and item.order_state==1 }">
			          									<td>待付款</td>
			          									<td>
			          										<a class="blue" href="${root}/details/querryOrderDetail?id=${item.id}" target="_blank">立即付款</a><br><br>
			          										<a class="blue" href="${root}/details/querryOrderDetail?id=${item.id}" target="_blank">查看详情</a><br>
						          							<a class="blue cancel_order" order_id="${item.id }" href="javascript:void(0)">取消订单</a>
			          										
			          								</c:if>
			          								<c:if test="${item.payment_state==1 and item.order_state==1 }">
			          									<td>平台处理中</td>
			          									<td>
			          										<a class="blue" href="${root}/sales/">确认完成</a><br><br>
			          										<a class="blue" href="${root}/details/querryOrderDetail?id=${item.id}" target="_blank">查看详情</a><br>
						          							<a class="blue cancel_order" order_id="${item.id }" href="javascript:void(0)">取消订单</a>
			          									</td>	
			          								</c:if>
			          								<c:if test="${item.payment_state==1 and item.order_state==2 }">
			          									<td>交易完成</td>
			          									<td>
			          										<a class="blue" href="${root}/details/querryOrderDetail?id=${item.id}" target="_blank">查看详情</a><br>
						          							<a class="blue delete_order" order_id="${item.id }" href="javascript:void(0)">删除订单</a>
			          									</td>
			          								</c:if>	
			          								<c:if test="${item.order_state==9 }">
			          									<td>订单取消</td>
			          									<td>
			          										<a class="blue" href="${root}/details/querryOrderDetail?id=${item.id}" target="_blank">查看详情</a><br>
						          							<a class="blue delete_order" order_id="${item.id }" href="javascript:void(0)">删除订单</a>
			          									</td>
			          								</c:if>		          								
			          							</c:if>
			          							<c:if test="${item.payment_code=='cash_on_delivery'}">
			          								<c:if test="${item.order_state==1 }">
			          									<td>平台处理中</td>
			          									<td>
			          										<a class="blue" href="${root}/sales/">确认完成</a><br><br>
			          										<a class="blue" href="${root}/details/querryOrderDetail?id=${item.id}" target="_blank">查看详情</a><br>
						          							<a class="blue cancel_order" order_id="${item.id }" href="javascript:void(0)">取消订单</a>
			          									</td>
			          								</c:if>
			          								<c:if test="${item.payment_state==1 and item.order_state==2 }">
			          									<td>交易完成</td>
			          									<td>
						          							<a class="blue" href="${root}/details/querryOrderDetail?id=${item.id}" target="_blank">查看详情</a><br>
						          							<a class="blue delete_order" order_id="${item.id }" href="javascript:void(0)">删除订单</a>
						          						</td>
			          								</c:if>	
			          								<c:if test="${ item.order_state==9 }">
			          									<td>订单取消</td>
			          									<td>
						          							<a class="blue" href="${root}/details/querryOrderDetail?id=${item.id}" target="_blank">查看详情</a><br>
						          							<a class="blue delete_order" order_id="${item.id }" href="javascript:void(0)">删除订单</a>
						          						</td>
			          								</c:if>	
			          							</c:if>

			          					</tr>
			          				</tbody>
			          				</c:forEach>
								</table>
								</c:if>
								<c:if test="${empty list}">
									<div class="order-actions">
									你目前没有订单.
									</div>
								</c:if>
			    			</div>
						</div>
					</div>
					<div class="setting_aside">
						<ul class="aside_inner">
							<li >
								<a href="${root}/sales/toOrderManage?state=0&date-filter=${times}">所有订单<i class="icon-arrow aside_inner_arrow"></i></a>
							</li>
							<li>
								<a href="${root}/sales/toOrderManage?state=1&date-filter=${times}">待付款的订单<i class="icon-arrow aside_inner_arrow"></i></a>
							</li>
							<li>
								<a href="${root}/sales/toOrderManage?state=2&date-filter=${times}">平台处理中订单<i class="icon-arrow aside_inner_arrow"></i></a>
							</li>
							<li>
								<a href="${root}/sales/toOrderManage?state=3&date-filter=${times}">已完成的订单<i class="icon-arrow aside_inner_arrow"></i></a>
							</li>
							<li>
								<a href="${root}/sales/toOrderManage?state=4&date-filter=${times}">已取消的订单<i class="icon-arrow aside_inner_arrow"></i></a>
							</li>
						</ul>
					</div>
					<!--end-->
				</div>
			</div>
		</div>
		</div>
		</div>
	  	<script type="text/javascript" charset="utf-8">
			$(function(){
			  $.ajaxSetup({
				data: {csrfmiddlewaretoken: 'oF0Z83AWina7gdj34qVGpM8IKOyQNS2U' },
			  });
			 // $(".delete_order").click(function(event){
				//event.preventDefault();
				$(".delete_order").click(function(){
				if (confirm("确定要删除这个订单吗？")){
				  var pk = parseInt($(this).attr("order_id"));
				  $.ajax({
					url: "${root}/sales/delOrder?order_id=" + pk ,
					type: "POST",
					success: function(data){
					var data=eval('('+data+')');
					  if(data.message){
					  location.reload();
					  }
					},
					error: function(data){
					  alert("删除订单失败，请刷新页面后重试");
					  location.reload();
					},
				  })
				}
			  });
			  $(".cancel_order").click(function(){
				//event.preventDefault();
				if (confirm("确定要取消这个订单吗？")){
				  var pk = parseInt($(this).attr("order_id"));
				  $.ajax({
					url: "${root}/sales/cancleOrder?order_id=" + pk,
					type: "POST",
					success: function(data){		
					  location.reload();
					},
					error: function(data){
					  alert("取消订单失败，请刷新页面后重试");
					  location.reload();
					},
				  })
				}
			  });
			})
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
		   
		   function getSelected(){
			   var aa=${types};
			   var bb=${times};
			  // $("ul.aside_'inner").children("li")[2].addClass("selected"); 
			   $(".aside_inner").children('li').eq(aa).addClass('selected');
			  // $("#date-filter").
			    var obj = document.getElementById('date-filter');
			    if(obj!=null){
				    for(var i = 0; i < obj.options.length; i++){
				        var tmp = obj.options[i].value;
				        if(tmp == bb){
				            obj.options[i].selected="selected";
				        }
				    }
			   }
			 /*   $.each(ch,function(index,value){
				   if(value.val()==bb){
					   value.selected="selected";
				   }
			   }) */
			   
		   }
			   /*    window.onload=function(){
			  ct_name = document.body.getAttribute("class");

			  if (ct_name != "") {
			  current_tab = document.getElementById(ct_name);
			  current_tab.className += "active";
			  }
			  }*/
</script>		
</body>
</html>
<jsp:include page="/views/common/footer.jsp" />
