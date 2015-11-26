<%@ page language="java" import="java.util.*,com.keji50.zhucexia.dao.po.CustomerPo" pageEncoding="UTF-8"%>
<% CustomerPo customer=(CustomerPo)request.getSession().getAttribute("customer"); %>
<div id="top" class="top">
    <div class="container">
        <div class="logo">
            <h1><a title="" href="${root }/index/show"><img src="${root }/static/images/header/logo.png" alt=""></a></h1></div>
        <div class="top-tool"><img src="${root }/static/images/header/c1.jpg">4009207898
            <img src="${root }/static/images/header/c2.jpg">
           <% 
           		if(customer!=null){
           			%><span id="qq">
           				<%-- <a href="javascript:;"><span id="logins"><%=customer.getUsername() %></span></a> |
               	         <a href="javascript:clearsession();" ><span id="turnback">注销</span></a> &nbsp; --%>
               	         <span class="bb"> |
	           	           <a href="javascript:clearsession();" ><span id="turnback">注销</span></a>
	           	             &nbsp;
	           	         </span>
	           	         <span class="aa">
		           			  <!-- <a href="javascript:;" > -->
				           		  <span id="logins" class="mm">
					           		 	<li class="xf"> <%=customer.getUsername() %></li>
					           		 	<li class="cc"><span style="color:orange;">▷ &nbsp;</span><a href="${root }/sales/userManager">个人中心</a></li>
					           		 	<li class="cc"><span style="color:orange;">▷ &nbsp;</span><a href="${root }/sales/toShopCart">购物车&nbsp;&nbsp;&nbsp;</a></li>
				           		  </span>
			           		<!-- </a> -->
		           		 </span> 
               	       </span>
               	      <span id="ww" style="display:none;">
               	      		 <a href="javascript:" class="J_dialog mm" data="log" id="pp"><span id="logina">登录</span></a> |  
               	             <a href="javascript:ee();" class="J_dialog mm" data="reg"><span id="turnbacka">注册</span></a> &nbsp; 
               	       </span>
           	             <% 
           		}else{
           		  %><span id="hc"><a href="javascript:;" class="J_dialog mm" data="log" id="a1"><span id="a11" style="height:auto">登录</span></a> |
           	            <a href="javascript:regist()" class="J_dialog mm" data="reg" id="b1"><span id="b11">注册</span></a>  &nbsp;</span>
           	            
           	        <span id="hc1" style="display:none;">
           	        	<span class="bb"> |
	           	           <a href="javascript:sele()" class="mm" id="b2" ><span id="a21">注册</span></a>
	           	             &nbsp;
	           	         </span>
	           	         <span class="aa">
		           			  <!-- <a href="javascript:;" > -->
				           		  <span id="a11" class="mm" id="a2">
					           		 	<li class="xf">13916247927</li>
					           		 	<li class="cc"><span style="color:orange;">▷ &nbsp;</span><a href="${root }/sales/userManager">个人中心</a></li>
					           		 	<li class="cc"><span style="color:orange;">▷ &nbsp;</span><a href="${root }/sales/toShopCart">购物车&nbsp;&nbsp;&nbsp;</a></li>
				           		  </span>
			           		<!-- </a> -->
		           		 </span>
		           	</span>
           	            <% 
           		}
           %>
        </div>
        <div id="nav">
            <ul id="menu" class="navigation">
                <li id="index" class="nav-lilink"><a href="${root }/index/show" class="nav-alink" title="网站首页"> 网站首页</a>
                    <div class="exnav">
                        <ul class="children level-0"></ul>
                    </div>
                </li>
                <li id="about" class="nav-lilink"><a href="${root }/views/about.jsp" class="nav-alink" title="关于我们"> 关于我们</a>
                    <div class="exnav">
                        <ul class="children level-0"></ul>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<style>
#cs_box {width:120px; height:220px; color:#FFF; background:#1D2087; position:fixed; right:10px; top:100px; border-radius:10px; z-index:1000}
#cs_box span {height:20px; line-height:20px;display:block;}
.cs_close {color:#FFF; position:absolute; right:10px; top:8px; cursor:pointer; font-size:20px;font-family:Verdana, Geneva, sans-serif}
.cs_title {font-size:14px; margin:10px; font-weight:bold;}
.cs_img {width:100px; height:100px; background:#FFF; margin:10px;background-image:url(/zhucexia/static/images/common/kefu.jpg) }
.cs_info {font-size:12px; margin:0px 10px; overflow:hidden; text-align:center;}
.cs_btn {width:100px; height:25px; background:#333; margin:5px 10px; border-radius:5px; font-size:12px; line-height:25px; color:#FFF; text-align:center; cursor:pointer;}
</style>
<div id='cs_box'>
	<span class='cs_title'>在线咨询</span>
	<span class='cs_close'>x</span>
	<div class='cs_img'></div>
	<span class='cs_info'>有什么可以帮到你</span>
	<div class='cs_btn'>点击咨询</div>
</div>
<script src="http://www.lanrenzhijia.com/ajaxjs/lanrenzhijia.js"></script>
<script>
	myEvent(window,'load',function(){
		cs_box.set({
			img_path : 'http://demo.lanrenzhijia.com/2014/service1119/images/lanrenzhijia.jpg',	//设置图片路径
			qq : '343382252',	//设置QQ号码'19276507'
		});
	});
</script>
<script type="text/javascript">
	function clearsession(){ 
		$.ajax({
			url : "${root}/customer/clearsession",
			type : 'POST',
			success : function(data) {
				var data=eval("(" + data + ")");
				if(data.message=="清除缓存"){
					location.href="${root}/index/show";
					$("#qq").hide();
					$("#ww").show();
					$("#logina").html("登录");
				}else{
					$("#mess").html("输入的用户名/手机号 或密码有误");
				}
	
			},
			error:function(data) {
				var data=eval("(" + data + ")");
				$("#mess").html("输入的用户名/手机号 或密码有误");
			}
		});
	}
	function ee(){
		if($("#turnbacka").html()=="注销"){
			$.ajax({
				url : "${root}/customer/clearsession",
				type : 'POST',
				success : function(data) {
					var data=eval("(" + data + ")");
					if(data.message=="清除缓存"){
						$(".xf").html("登录");
						$("#reg").hide();
						$("#turnbacka").html("注册");
					}else{
						$("#mess").html("输入的用户名/手机号 或密码有误");
					}
		
				},
				error:function(data) {
					var data=eval("(" + data + ")");
					$("#mess").html("输入的用户名/手机号 或密码有误");
				}
			});
		}else if($("#turnbacka").html()=="注册"){
			/* $("#qq").show();
			$("#logins").html("");
			$("#ww").hide(); */
			/* $(".xf").html("登录");
			$("#turnbacka").html("注销"); */
		}
	}
	function sele(){
		$("#hc1").hide();
		$("#hc").show();
		$.ajax({
			url : "${root}/customer/clearsession",
			type : 'POST',
			success : function(data) {
				var data=eval("(" + data + ")");
				if(data.message=="清除缓存"){
				}else{
					$("#mess").html("输入的用户名/手机号 或密码有误");
				}
	
			},
			error:function(data) {
				var data=eval("(" + data + ")");
				$("#mess").html("输入的用户名/手机号 或密码有误");
			}
		});
	}
	
</script >
<jsp:include page="/views/common/loginRe.jsp" />