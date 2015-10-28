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
<body class="">
   	<div class="WB_miniblog">
   		<div class="topNavWrap-pindao" style="background-color:">
   			<div class="grhead">
   				<div class="grinfo">
				</div>
			</div>
		</div>
		<div class="second_newmenu">
			<div class="navboxSecond">
				<div class="subNav" id="widget-subnav">
					<span class="clt"></span>
					<span class="crt"></span>
					<span class="clb"></span>
					<span class="crb"></span>
					<div class="navLt wisub" style="display:none;">
					</div>
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
        							<li>
        								<a href="http://www.zhucexia.com/orders/">订单管理</a>
        							</li>
        							<li>
        								<a href="http://www.zhucexia.com/unreview/items/">评价管理</a>
        							</li>
        							<li>
        								<a href="http://www.zhucexia.com/favorites/">收藏管理</a>
        							</li>
        							<li class="selected">
        								<a href="./助策侠网络科技有限公司 地址列表_files/助策侠网络科技有限公司 地址列表.html">收货地址管理</a>
        							</li>
        						</ul>
        					</div>
        				</div>
        			</div>
        			<!-- contant -->
        			<div class="setting_wrap clearfix">
        				<div class="innerallbox">
        					<div class="clearfix">
        						<a href="http://www.zhucexia.com/address/add/" class="btn btn-success pull-right">新增收货地址</a>
        					</div>
        					<table class="table table-striped" width="100%">
        						<thead>
        							<tr>
        								<th>联系人名称</th>
        								<th>手机</th>
        								<th>电话</th>
        								<th>地址</th>
        								<th>操作</th>
        							</tr>
        						</thead>
        						<tbody>
        							<tr>
        								<td>
                    						你暂时没有收货联系人：）
                  					</td>
                  				</tr>
                  				</tbody>
                  		    </table>
                  	    </div>
                    </div>
                </div>
            </div>
        </div> 
    </div> 	
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

        </script>
   </body>
<jsp:include page="/views/common/footer.jsp" />
</html>

