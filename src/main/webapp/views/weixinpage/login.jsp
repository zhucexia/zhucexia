<%@page import="com.keji50.zhucexia.dao.po.CustomerPo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	// Set request data code convertion
	request.setCharacterEncoding("UTF-8");
	// Application common variables
	String root = request.getContextPath();
	request.setAttribute("root",root);
	int aim =Integer.parseInt((String)request.getAttribute("aim"));
	String sign=(String)request.getAttribute("sign");
	CustomerPo customer = (CustomerPo)request.getSession().getAttribute("customer");
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
	
	<link rel="stylesheet" type="text/css" href="${root}/static/css/weixin/weixin.css">
</head>
<body>
	<div class="divbody">
		<div class="logo">
			<div class="logo_img">
				<img src="${root}/static/images/header/logo.png">
			</div>
			<p>登录注册侠</p>
		</div>
		<div class="retina-1px-border-bottom" ></div>
		<div id="login">
			<ul class="form_box" >
				<li class="form_box_li" >
					<div class="form_box_ipt" >
						<input id="login_name" name="mobile" type="text" placeholder="手机号"  />
					</div>
				</li>
				<div class="retina-1px-border-bottom" ></div>
				<li class="form_box_li">
					<div class="form_box_ipt" >
						<input id="login_pwd" name="password" type="password" placeholder="密码" />
					</div>
				</li>
			</ul>
			<div class="retina-1px-border-bottom"></div>
			<div class="wid100Btn" style="padding-top:20px;">
				<input id="do_login" type="button" value="登录" />
			</div>
		</div>
		<div id="regist" style="display:none;">
			<ul class="form_box" >
				<input type="hidden" name="mark" id="mark"/>
				<li class="form_box_li" >
					<div class="form_box_ipt" >
						<input id="reg_name" name="mobile" type="text" placeholder="手机号"/>
					</div>
				</li>
				<div class="retina-1px-border-bottom" ></div>
				<li class="form_box_li" > 
					<div class="form_box_ipt">
						<input style="width:65%;" id="code" name="code" type="text" placeholder="验证码"/>

						<div style="position:absolute;right:0;top:0;width:30%;padding-top:16px">
							<!-- <div style="position:absolute;width:1px;"></div> -->
							<a href="javascript:;" id="sentMess" style="text-decoration:blink;color:#477FFF;font-size:18px;" >获取验证码</a>
						</div>
					</div>	
				</li>
				<div class="retina-1px-border-bottom" ></div>
				<li class="form_box_li" >
					<div class="form_box_ipt" >
						<input id="reg_pwd" name="password" type="password" placeholder="密码"/>
					</div>
				</li>
				<div class="retina-1px-border-bottom" ></div>
				<li class="form_box_li" >
					<div class="form_box_ipt" >
						<input id="confirm_pwd" name="finalPwd" type="password" placeholder="确认密码"/>
					</div>
				</li>
			</ul>
			<div class="retina-1px-border-bottom" ></div>
			<div class="wid100Btn" style="padding-top:20px;" >
				<input type="button" value="提交" id="regist_btn"/>
			</div>
		</div>
		<div style="margin-top:20px;" id="reg_btn">
			<a href="javascript:lostPwdPage();" style="position:absolute;left:20px;text-decoration:blink;color:#5971A8;" >忘记密码？</a>
			<a href="javascript:regPage();"style="text-decoration:blink;color:#5971A8;position:absolute;right:20px;">注册</a>
		</div>
	</div>
	<script type="text/javascript">
		<%if(sign.equals("change")){%>
			lostPwdPage();
			$("#reg_name").attr("value","${customer.mobile}");
			$("#reg_name").attr("readonly","readonly");
		<%}%>
		function lostPwdPage(){
			$("#login").css("display","none");
			$("#regist").css("display","block");
			$("#reg_btn").css("display","none");
			$("#mark").val("lostPwd");
		}
		function regPage(){
			$("#login").css("display","none");
			$("#regist").css("display","block");
			$("#reg_btn").css("display","none");
			$("#mark").val("regist");
		}
		function regist(mobile,password,code){
			alert(password);
			$.ajax({
				url:"${root}/WXUser/regist",
				data:{"mobile":mobile,"code":code,"password":password},
				type:"post",
				success:function(data){
					if(data==-2){
						alert("验证码过期");
					}else if(data==-1){
						alert("验证码错误");
					}else if(data==1){
						alert("系统繁忙，请稍后再试");
					}else if(data==0){
						var aim = ${aim}
						if(aim==1){
							location.href="${root}/WXOrder/orderManage";
						}
						if(aim==2){
							
						}
						if(aim==3){
							location.href="${root}/WXUser/userCenter";
						}
					}
				}
			});
		}
		$("#do_login").click(function (){
			var mobile = $("#login_name").val();
			var password = $("#login_pwd").val();
			var reg1 = /^1[3578][0-9]{9}$/;
			var reg2 = /^[\w|_-]{6,20}$/;
			var flag = true;
			if(!reg1.test(mobile)){
				flag = false;
			}
			if(!reg2.test(password)){
				flag = false;
			}
			if(flag){
				$.ajax({
					url:"${root}/WXUser/login",
					type:"post",
					data:{"mobile":mobile,"password":password},
					success:function(data){
						if(data==0){
							var aim = ${aim};
							if(aim==1){
								location.href="${root}/WXOrder/orderManage";									
							}
							if(aim==2){
								location.href="${root}/"
							}
							if(aim==3){
								location.href="${root}/WXUser/userCenter"
							}
						}
						if(data==1){
							alert("手机号或密码错误！");
						}
					}
				});
			}else{
				alert("请输入正确的手机号和密码！");
			}
		});
		function lostPwd(mobile,password,code){
			$.ajax({
				url:"${root}/WXUser/lostPwd",
				data:{"mobile":mobile,"code":code,"password":password},
				type:"post",
				success:function(data){
					if(data==-2){
						alert("验证码过期");
					}else if(data==-1){
						alert("验证码错误");
					}else if(data==1){
						alert("系统繁忙，请稍后再试");
					}else if(data==0){
						var aim=${aim};
						if(aim==1){
							location.href="${root}/WXOrder/orderManage";
						}
						if(aim==2){
							location.href="${root}/"
						}
						if(aim==3){
							location.href="${root}/WXUser/userCenter"
						}
					}
				}
			});
		}
		function sentMess(mobile){
			$.ajax({
				url:"${root}/WXUser/mess",
				type:"post",
				data:{"mobile":mobile},
				success:function(data){
					var code = $("#sentMess");
					if(data==1){
						code.html("重新获取");
					}
					if(data==0){				
						var validCode = true;
						var time = 30;
				        var t = setInterval(function() {
				        	validCode = false;
				        	code.html(time + "秒");
				            time--;
				            if (time == 0) {
				                clearInterval(t);
				                code.html("重新获取");
				                validCode = true;
				            }
				            
				        }, 1000)
					}
				}
			});
		}

		$("#sentMess").click(function(){
			var mobile=$("#reg_name").val();
			var mark=$("#mark").val();
			reg=/^1[3578][0-9]{9}$/;
			if(reg.test(mobile)){
				$.ajax({
					url:"${root}/WXUser/validateMobile",
					type:"post",
					data:{"mobile":mobile},
					success:function(data){
						if((data==0&&mark=="lostPwd")||(data==1&&mark=="regist")){
							if($("#sentMess").html()=="获取验证码"||$("#sentMess").html()=="重新获取"){
								sentMess(mobile);
							}
						}else{
							alert("手机号不可用");
						}
					}
				});
			}else{
				alert("请输入正确的手机号");
			}
		});
		$("#regist_btn").click(function(){
			var mark=$("#mark").val();
			var mobile = $("#reg_name").val();
			var code = $("#code").val();
			var password = $("#reg_pwd").val();
			var confPwd = $("#confirm_pwd").val();
			reg_mobile=/^1[3578][0-9]{9}$/;
			reg_code=/^[0-9]{4}$/;
			reg_password=/^[\w-_]{6,20}$/;
			var flag=true;
			if(!reg_mobile.test(mobile)){
				flag=false;
			}
			if(!reg_code.test(code)){
				flag=false;
			}
			if(!reg_password.test(password)){
				flag=false;
			}
			if(password!=confPwd){
				flag=false;
			}
			if(flag){		
				if(mark=="lostPwd"){
					lostPwd(mobile,password,code);
				}
				if(mark=="regist"){
					regist(mobile,password,code);
				}
			}
		});
			
	</script>
</body>
</html>