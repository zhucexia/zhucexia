<%@ page language="java" import="java.util.*,com.keji50.zhucexia.dao.po.CustomerPo" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	// Set request data code convertion
	request.setCharacterEncoding("UTF-8");
	// Application common variables
	String root = request.getContextPath();
	request.setAttribute("root",root);
%>
<% CustomerPo customer=(CustomerPo)request.getSession().getAttribute("customer"); %>
<jsp:include page="/views/common/header.jsp" />
<jsp:include page="/views/common/top.jsp" />
<html lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>助策侠网络科技有限公司 我的账户</title>
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
<script type="text/javascript"
	src="${root }/static/js/common/da.js"></script>
<script type="text/javascript" src="${root }/static/js/plugins/ui.js"></script>
<script type="text/javascript" src="${root }/static/js/plugins/qiniu.min.js"></script>
<script type="text/javascript" src="${root }/static/js/customer/cutomer.js"></script>
</head>
<body class="medium">
	<div class="WB_miniblog">
		<div class="topNavWrap-pindao" style="background-color:">
			<div class="grhead">
				<div class="grlogo ll">
				</div>
				<div class="grinfo">
					<div class="site-nav">
						<ul class="site-nav-bd-r">
							<!--<li class='dark user-menu'><a href="/">返回</a></li>-->
							<li class="dark user-menu" style="margin-left: 5px;">
							</li>
						</ul>
					</div>
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
					<div class="navLt wisub" style="display: none;">
					</div>
					<div class="navRt wisub">
						<a href="${root }/static/助策侠网络科技有限公司 我的账户.html" class="selected">我的账户 </a> | 
						<a href="http://www.zhucexia.com/orders/"> 我的交易 </a> |
					</div>
				</div>
			</div>
		</div>
		<div class="second_newmenu-fix">
		</div>
		<div class="grbg">
			<div class="s_main clearfix">
				<!--左侧 开始-->
				<div class="wrap_left_none">
					<div class="border_gray clearfix">
						<!-- tabs -->
						<div class="pc_tabs pc_tabs-full margin_b20 clearfix">
							<div class="tabGray">
								<div class="tabBox leftTab">
									<ul class="tabLinks">
										<li class="selected">
											<a	href="${root }/static/助策侠网络科技有限公司 我的账户.html">账户总览</a>
										</li>
										<!--            <li><a href="/bind">我的预约</a></li><li><a href="/sncode/">我的活动</a></li><li><a href="/">我的留言</a></li>-->
									</ul>
								</div>
							</div>
						</div>
						<!-- tabs -->
						<!-- 内容 -->
						<div class="accountCenter_wrap">
							<div class="accountView clearfix">
								<div class="accountView_left">
									<div class="pc_personInfo">
										<div class="pc_personInfobox clearfix">
											<div class="fl himg">
												<img src="${root }/static/images/user/usercenter_head.jpg"
													width="60" height="60"
													onerror="this.src=&#39;/site_media/static/division/user/imgs/nophoto.gif&#39;">
											</div>
											<div class="pc_personInfo_body mb5">
												<div>
													<span class="userName"> 昵称：13501635413 
													<span class="black9"></span>
													<!--<a style=" margin-left:5px; font-size:12px;" class="blue" href="/profiles/edit/">修改资料</a>--></span>
												</div>
												<div>角色：默认</div>
												<div>用户名:13501635413</div>
											</div>
										</div>
										<div class="jygl clearfix">
											<div class="hd">交易管理</div>
											<div class="mod_cutLine"></div>
											<div class="bd">
												<dl>
													<dt>
														<a href="http://www.zhucexia.com/orders/">
														<img src="${root }/static/images/user/purchasemanagement.png"></a>
													</dt>
													<dd>
														<a href="http://www.zhucexia.com/orders/">订单管理</a>
													</dd>
												</dl>
												<dl>
													<dt>
														<a href="http://www.zhucexia.com/unreview/items/">
															<img src="${root }/static/images/user/remarkmanagement.png">
														</a>
													</dt>
													<dd>
														<a href="http://www.zhucexia.com/unreview/items/">评价管理</a>
													</dd>
												</dl>
												<dl>
													<dt>
														<a href="http://www.zhucexia.com/favorites/">
															<img src="${root }/static/images/user/myfavorites.png"></a>
													</dt>
													<dd>
														<a href="http://www.zhucexia.com/favorites/">我的收藏</a>
													</dd>
												</dl>
												<dl>
													<dt>
														<a href="http://www.zhucexia.com/addressbook/">
														<img src="${root }/static/images/user/procurementlist.png"></a>
													</dt>
													<dd>
														<a href="http://www.zhucexia.com/addressbook/">收货地址管理</a>
													</dd>
												</dl>
											</div>
										</div>
										<div class="jygl clearfix">
											<div class="hd">账号设置</div>
											<div class="mod_cutLine"></div>
											<div class="bd">										
												<div class="account-links">
													<div class="span4">
														<div class="box-quick-link blue-background">
																<a href="javascript:void(0)"
																	rel="facebox" id="baseDate">
																	<div class="link-header">
																		<i class="fa fa-edit fa-2x"></i>
																	</div>
																	<div class="content-title">基本信息</div>
																</a>
														</div>
													</div>
													<div class="span4">
														<div class="box-quick-link grass-green-background">
															<a	href="javascrit:void(0);"
																rel="facebox" id="changePwd">
																<div class="link-header">
																	<i class="fa fa-lock fa-2x"></i>
																</div>
																<div class="content-title">修改密码</div>
															</a>
														</div>
													</div>
													<div class="span4">
														<div class="box-quick-link muted-background">
															<a href="javascript:void(0);"
																rel="facebox" id="bingdMobile">
																<div class="link-header">
																	<i class="fa fa-mobile-phone fa-2x"></i>
																</div>
																<div class="content-title">绑定手机</div>
														    </a>
														</div>
													</div>
													<div class="span4">
														<div class="box-quick-link green-background">
															<a href="http://www.zhucexia.com/review_info_iframe/"
																rel="facebox">
																<div class="link-header">
																	<i class="fa fa-table fa-2x"></i>
																</div>
																<div class="content-title">完善信息</div>
															</a>
														</div>
													</div>
												</div>
											
											</div>
										    </div>
										<i class="fa fa-angellist"></i>
										<!--挂件foot-->
									   </div>
									</div>
									<div class="accountView_right">
										<h2 class="f14 mb20 mainColor">账户安全与通知</h2>
										<!-- 安全条 -->
										<div class="safeScroll">
											<p class="moren"></p>
											<p class="qiang">
												<span class="wenzi">强</span>
											</p>
										</div>
										<!-- 交易通知 -->
										<div class="">
											<!-- 在原图标样式名基础上追加 -none即为灰色图标 -->
											<!--邮箱开始 -->
											<div class="mb20 clearfix">
												<div class="icon-accountMail icon-accountMail-none fl mr15"></div>
												<div class="mainColor mt3 fl">
													<p>
														<i class="listStyle-dot"></i>
														<span class="mr10">邮箱验证：未验证</span>
														<a rel="facebox" target="_blank" class="blue"
															href="http://www.zhucexia.com/account/email/">验证</a>
													</p>
													<p>
														<i class="listStyle-dot"></i>
														<span class="mr10">邮箱通知：未开通</span>
													</p>
												</div>
											</div>
											<!--邮箱结束 -->
											<!--手机开始 -->
											<div class="mb20 clearfix">
												<div class="icon-accountMobile icon-accountMobile fl mr15">
												</div>
												<div class="mainColor mt3 fl">
													<p>
														<i class="listStyle-dot"></i>
														<span class="mr10">手机验证：已验证13501635413</span>
													</p>
													<p>
														<i class="listStyle-dot"></i>
														<span class="mr10">短信通知：已开通</span>
													</p>
												</div>
											</div>
										</div>
									</div>
								</div>
						    </div>
					    </div>
					</div>
					<div class="wrap_right" style="display: none;">
						<div class="self_right">
							<!-- 个人信息 开始 -->
							<div class="box_right padding_t20" id="j-userbox">
								<div class="pc_personInfo clearfix">
									<div class="pc_personInfo_body">
										<h3>
											<div class="clearfix" style="height: 18px">
												<span class="userName">用户名:13501635413</span>
											</div>
											<span class="userName">手机:13501635413</span>
										</h3>
										
									</div>
								</div>
							</div>
							<!-- 个人信息 结束 -->
							<!--VIP热销榜 开始-->
							<div class="box_right">
								<div class="title_common clearfix">
									<h3>
										<a href="http://www.zhucexia.com/news.html">公司动态</a>
									</h3>
									<a class="more" href="http://www.zhucexia.com/news.html"
										title="更多">更多<span></span></a>
								</div>
								<!--top10 开始-->
								<ul class="top10_list clearfix"></ul>
							</div>
							<!--VIP热销榜 结束-->
						</div>
					</div>
				</div>
			</div>
	</div>
	<div id="facebox" style="top:60.7px;left:688.5px;display:none;" class="facebox">
		<div class="popup">
			<div class="content">
				<div class="face-block">
				  <form class="form-horizontal" id="baseDateForm" method="post"  ENCTYPE="multipart/form-data">
					<input type="hidden" name="csrfmiddlewaretoken" value="fyj4uLeBQqYtVsIoywdp6S4L3JlSdAqw">
					<div id="div_id_username" class="clearfix control-group">
					  <label for="id_username" class="control-label ">
						用户名
					  </label>
					  <div class="controls">
						<input class="textinput textInput" id="id_username" name="username" type="text" 
						value="123123<%-- <%=customer.getUsername() %> --%>" readonly="true">
					  </div>
					</div>
					<div  class="clearfix control-group">		
						<label for="id_nickname" class="control-label ">昵称</label>
						<div class="controls">               
							<input class="textinput textInput" id="id_nickname" name="nickname" type="text">    
						</div>        
					</div>
					<input id="id_avatar" name="avatar" type="hidden">
					<div id="div_id_nickname" class="clearfix control-group">
						<label class="control-label ">
							头像
						</label>
						<div class="controls">
							<img id="avatar" src="../static/images/user/usercenter_head.jpg" 
							width="100" height="100">
							<div id="container">
								<!-- <a class="btn btn-default btn-lg " id="pickfiles" href="javascript:void(0);" 
									style="position: relative; z-index: 1;">
									<i class="glyphicon glyphicon-plus"></i>
									<sapn>选择文件</sapn>
								</a> -->
								<input type="file" value="上传" name="image">
							</div>
						</div>
					</div>
					<div class="form-actions">
					  <input class="btn btn-primary" type="button" name="action" value="确定" onclick="aa()">
					</div>
				  </form>
			</div>
			</div>
			<a href="#" class="close">
				<img src="${root }/static/images/user/closelabel.png" class="close_image" title="close">
			</a>
		</div>
	</div>
	<div id="facebox1" style="top: 66.3px; left: 688.5px; display:none;" class="facebox">
	    <div class="popup">         
	        <div class="content">       
	            <div class="face-block">
	                <div class="zh-r-tit"><b>修改密码</b><span class="black9">(*必填写项)</span></div>
	                <div class="zh-r-change">
	                    <form method="POST" action="" class="form-horizontal" id="changePwd">
	                        <input type="hidden" name="csrfmiddlewaretoken" value="fyj4uLeBQqYtVsIoywdp6S4L3JlSdAqw">
	                            <fieldset class="inlineLabels">
		                           <div id="div_id_oldpassword" class="clearfix control-group">
			                          <label for="id_oldpassword" class="control-label requiredField">
			                          	当前密码：<span class="asteriskField">*</span>
				                      </label>
	                                    <div class="controls">
	                                        <input class="textinput textInput" id="id_oldpassword" name="oldpassword" type="password">
	                                        <div id="warning_1"><span></span></div>   
	                                    </div>
		                           </div>
		                           <div id="div_id_password1" class="clearfix control-group">		
	    			                 <label for="id_password1" class="control-label requiredField">
	    				                	新的密码：<span class="asteriskField">*</span>
	       			                 </label>
	                                <div class="controls">               
	                                        <input class="textinput textInput" id="id_password1" name="password1" type="password">
	                                        <div id="warning_2"><span></span></div>    
	                                    </div>       
		                            </div>
		                            <div id="div_id_password2" class="clearfix control-group">		
				                     <label for="id_password2" class="control-label requiredField">
					                    	新密码（再输入一次）：<span class="asteriskField">*</span>
				                     </label>
	                                    <div class="controls">              
	                                        <input class="textinput textInput" id="id_password2" name="password2" type="password">
	                                        <div id="warning_3"><span></span></div>
	                                    </div>
	                                </div>
	                            </fieldset>
	                            <div class="form-actions">
	                                <input class="btn" type="button" name="action" value="确定" onclick="bb()">
	                            </div>
	                    </form>
	                </div>
	            </div>           
	        </div>         
	        <a href="javascript:void(0);" class="close">
	            <img src="${root }/static/images/user/closelabel.png" class="close_image" title="close">
	        </a>       
	    </div>     
	</div>
<style>
	#facebox .content {
		width: auto !important;
	}
	
	.span4 .blue-background {
		background-color: #78C5F7 !important;
	}
	
	.span4 .orange-background {
		background-color: #F2E18B !important;
	}
	
	.span4 .grass-green-background {
		background-color: #A8E888 !important;
	}
	
	.span4 .muted-background {
		background-color: #BEBEBE !important;
	}
	
	.box-quick-link a .content-title {
		background: #fafafa !important;
		border-bottom: 1px solid #ddd !important;
	}
	.face-block {
		width: 500px;
	}
	
	.max, .mini {
		width: 150px;
		float: left;
	}
	
	.max img {
		width: 80px;
	}
	
	.mini img {
		width: 40px;
	}
	
	#id_choice li {
		width: 100px;
		float: left
	}
	
	#id_choice li img {
		width: 40px;
	}
	.box-quick-link {
		text-align: center;
		margin-bottom: 10px;
	}
	
	.fa {
		color: white;
	}
	
	.box-quick-link a:hover {
		font-size: 18px;
		color: white;
		opacity: 0.8;
	}
	
	.box-quick-link a {
		text-decoration: none;
	}
	
	.box-quick-link a .link-header {
		height: 60px;
		line-height: 60px;
		padding-bottom: 2px;
	}
	
	.box-quick-link a .content-title {
		text-transform: uppercase;
		font-size: 16px;
		white-space: nowrap;
		overflow: hidden;
		-ms-text-overflow: ellipsis;
		-o-text-overflow: ellipsis;
		text-overflow: ellipsis;
		color: #5b5b5b;
		background-color: #dbdbdb;
		border-bottom: 1px solid #cecece;
		padding: 5px;
	}
	
	.box-quick-link a .link-header [class^="icon-"], .box-quick-link a .link-header [class*=" icon-"]
		{
		color: white;
		font-size: 30px;
		vertical-align: middle;
	}
	
	.blue-background {
		background-color: #007ACF !important;
	}
	
	.orange-background {
		background-color: #f8a326 !important;
	}
	
	.purple-background {
		background-color: #9564e2 !important;
	}
	
	.green-background {
		background-color: #70bf79 !important;
	}
	
	.muted-background {
		background-color: #999999 !important;
	}
	
	.grass-green-background {
		background-color: #5daf2b !important;
	}
	
	.banana-background {
		background-color: #fcd052 !important;
	}
	
	.brown-background {
		background-color: #924e31 !important;
	}
	
	#facebox .close {
		opacity: 1;
	}
	
	
	
	#facebox1 .content {
        width: auto !important;
    }

    .span4 .blue-background {
        background-color: #78C5F7 !important;
    }
    .span4 .orange-background {
        background-color: #F2E18B !important;
    }
    .span4 .grass-green-background {
        background-color: #A8E888 !important;
    }
    .span4 .muted-background {background-color: #BEBEBE !important;}
    .box-quick-link a .content-title { background:#fafafa !important;border-bottom: 1px solid #ddd !important;}
</style>
	<div id="facebox3" style="top: 66.3px; left: 688.5px; display:none;" class="facebox">       
        <div class="popup">         
            <div class="content">
            	<div class="face-block">
            		<div class="zh-r-tit"><b>绑定手机号码</b><span class="black9">(*必填写项)</span></div>
                    <div class="zh-r-change">       
                        <form method="POST" action="" class="form-horizontal">
                            <input type="hidden" name="csrfmiddlewaretoken" value="fyj4uLeBQqYtVsIoywdp6S4L3JlSdAqw">
                            <fieldset class="inlineLabels">
                            	<div id="div_id_mobile" class="clearfix control-group">
                            		<label for="id_mobile" class="control-label requiredField">
                            			手机号<span class="asteriskField">*</span>
                            		</label>
                            		<div class="controls">
                            			<input class="textinput textInput" id="id_mobile" name="mobile" placeholder="手机号码" type="text">
                            			<span class="pts" ></span>
                            			<a class="btn btn-primary" id="send_token_btn" href="javascript:void(0);">发送验证码</a>
                            		</div>
                            	</div>
                            	<div id="div_id_token" class="clearfix control-group">
                            		<label for="id_token" class="control-label requiredField">
                            			验证码<span class="asteriskField">*</span>
                            		</label>
                            		<div class="controls">
                            			<input class="textinput textInput" id="id_token" name="token" placeholder="验证码" type="text"><span id="messcode"></span>
                                    </div>
                            	</div>
                            </fieldset>
                            <div class="form-actions">
                            	<input class="btn" type="button" name="action" value="确认绑定" onclick="cc()">
                            </div>
                        </form>        
                    </div>
                </div>
            </div>
            <a href="javascript:void(0);" class="close">
                <img src="${root }/static/images/use/closelabel.png" class="close_image" title="close">
            </a>
        </div>
    </div>
<!-- <script>
 	$(document).ready(
		function() {
			$("a[rel*='facebox']").facebox();
				}); 
</script> -->

<script type="text/javascript">
   // 导航选卡
   $(function(){
       ch = $('.wisub').children();
       $.each(ch, function(index, value){
           if (value && (window.location.href ==value.href || window.location.pathname == value.href)) {
               $(value).addClass("selected");
           }
       });
   });  
</script>
</body>
<jsp:include page="/views/common/footer.jsp" />
</html>

