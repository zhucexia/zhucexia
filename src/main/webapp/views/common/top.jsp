<%@ page language="java" import="java.util.*,com.keji50.zhucexia.dao.po.CustomerPo" pageEncoding="UTF-8"%>
<% CustomerPo customer=(CustomerPo)request.getSession().getAttribute("customer"); %>
<div id="top" class="top">
    <div class="container">
        <div class="logo">
            <h1><a title="" href="index.html"><img src="${root }/static/images/header/logo.png" alt=""></a></h1></div>
        <div class="top-tool"><img src="${root }/static/images/header/c1.jpg">4009207898
            <img src="${root }/static/images/header/c2.jpg">
           <% 
           		if(customer!=null){
           			%><span id="qq"><a href="javascript:;"><span id="logins"><%=customer.getUsername() %></span></a> |
               	            <a href="javascript:clearsession();" ><span id="turnback">注销</span></a> &nbsp;</span>
               	      <span id="ww" style="display:none;"><a href="javascript:;" class="J_dialog mm" data="log"><span id="logina">登录</span></a> |
               	            <a href="javascript:ee();" class="J_dialog mm" data="reg"><span id="turnbacka">注册</span></a> &nbsp;</span>
               	            
               	       <span id="rr" style="display:none;"><a href="javascript:;" class="mm" id="a2a"><span id="a21a">登录</span></a> |
           	            <a href="javascript:sele()" class="mm" id="b2a"><span id="b21">注册</span></a>  &nbsp;</span>
           	             <% 
           		}else{
           		  %><span id="hc"><a href="javascript:;" class="J_dialog mm" data="log" id="a1"><span id="a11">登录</span></a> |
           	            <a href="javascript:" class="J_dialog mm" data="reg" id="b1"><span id="b11">注册</span></a>  &nbsp;</span>
           	            
           	        <span id="hc1" style="display:none;"><a href="javascript:;" class="mm" id="a2"><span id="a21">登录</span></a> |
           	            <a href="javascript:sele()" class="mm" id="b2"><span id="b21">注册</span></a>  &nbsp;</span>
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
<script type="text/javascript">
	function clearsession(){ 
		$.ajax({
			url : "${root}/customer/clearsession",
			type : 'POST',
			success : function(data) {
				var data=eval("(" + data + ")");
				if(data.message=="清除缓存"){
					$("#qq").hide();
					$("#ww").show();
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
						$("#logina").html("登录");
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
		}else if($("#turnbacka").html()=="登录"){
			$("#logina").html("登录");
			$("#turnbacka").html("注册");
		}
	}
	function sele(){
		alert("本页面");
		$("#hc1").hide();
		$("#hc").show();
		$.ajax({
			url : "${root}/customer/clearsession",
			type : 'POST',
			success : function(data) {
				var data=eval("(" + data + ")");
				if(data.message=="清除缓存"){
					alert(data.message);
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