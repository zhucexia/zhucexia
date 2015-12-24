<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	// Set request data code convertion
	request.setCharacterEncoding("UTF-8");
	// Application common variables
	String root = request.getContextPath();
	request.setAttribute("root",root);
	int aim =Integer.parseInt((String)request.getAttribute("aim"));
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
	<div class="divbody">
		<div class="logo">
			<div class="logo_img">
				<img src="${root}static/images/header/logo.png">
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
				<li class="form_box_li" >
					<div class="form_box_ipt" >
						<input name="mobile" type="text" placeholder="手机号"/>
					</div>
				</li>
				<div class="retina-1px-border-bottom" ></div>
				<li class="form_box_li" > 
					<div class="form_box_ipt">
						<input style="width:65%;" name="code" type="text" placeholder="验证码"/>

						<div style="position:absolute;right:0;top:0;width:30%;padding-top:16px">
							<!-- <div style="position:absolute;width:1px;"></div> -->
							<a href="javascript:;" style="text-decoration:blink;color:#477FFF;font-size:18px;" >获取验证码</a>
						</div>
					</div>	
				</li>
				<div class="retina-1px-border-bottom" ></div>
				<li class="form_box_li" >
					<div class="form_box_ipt" >
						<input name="password" type="password" placeholder="密码"/>
					</div>
				</li>
				<div class="retina-1px-border-bottom" ></div>
				<li class="form_box_li" >
					<div class="form_box_ipt" >
						<input name="finalPwd" type="password" placeholder="确认密码"/>
					</div>
				</li>
			</ul>
			<div class="retina-1px-border-bottom" ></div>
			<div class="wid100Btn" style="padding-top:20px;" >
				<input type="button" value="提交"/>
			</div>
		</div>
		<div style="margin-top:20px;">
			<a href="javascript:regpage();" style="position:absolute;left:20px;text-decoration:blink;color:#5971A8;" >忘记密码？</a>
			<a href="javascript:;"style="text-decoration:blink;color:#5971A8;position:absolute;right:20px;">注册</a>
		</div>
	</div>
<!-- 	<style type="text/css">
		body{padding: 0;margin: 0;background-color: #F5F5F9;max-width: 1024px;}
		.divbody{padding-bottom: 58px;}
		.logo{padding: 32px 0;}
		.logo_img{width: 200px;height: 100px;margin: 0 auto;padding-right: 8px;}
		.logo_img img{width: 100%;}
		.form_box{padding: 0 10px;margin: 0;background-color: #fff;}
		.form_box_li{height: 50px;position:relative;}
		.form_box_li .form_box_ipt{width: 100%;height: 100%;}
		.form_box_li .form_box_ipt input{border:none;padding: 0;width: 100%;height: 100%;font-size: 15px;}
		.retina-1px-border-bottom{height:1px; position:relative;background-color:#DCDCDC}
		.wid100Btn{padding: 0 10px;}
		.wid100Btn input{border:none;border-radius: 3px;width: 100%;height: 45px;background-color: #2294ff;color: #fff;font-size:16px;}
		p{font-size: 16px;padding-top:15px;color:#555;margin: 0;text-align: center;}
	</style> -->
	<script type="text/javascript">
		function regpage(){
			$("#login").css("display","none");
			$("#regist").css("display","block");
		}
		function login(){
			var mobile = $("#login_name").val();
			var password = $("#login_pwd").val();
			var reg1 = /^1[3578][0-9]{9}$/;
			var reg2 = /^[\w|_-]{6,20}$/;
			var flag = true;
			$("#do_login").click(function (){
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
									location.href="${root}/";									
								}
								if(aim==2){
									location.href="${root}/"
								}
								if(aim==2){
									location.href="${root}/WXUser/userCenter"
								}
							}
							if(data==1){
								alert("手机号或密码错误！")
							}
						}
					});
				}else{
					alert("请输入正确的手机号和密码！")
				}
			});
		}
	</script>
</body>
</html>