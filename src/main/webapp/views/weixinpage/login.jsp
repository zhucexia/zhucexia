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
	<script language="javascript" src="${root}/static/js/weixin/login.js"></script>
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
				<input type="hidden" name="mark" id="mark"/>
				<li class="form_box_li" >
					<div class="form_box_ipt" >
						<input id="reg_name" name="mobile" type="text" placeholder="手机号"/>
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
				<input type="button" value="提交" id="regist"/>
			</div>
		</div>
		<div style="margin-top:20px;">
			<a href="javascript:lostPwdPage();" style="position:absolute;left:20px;text-decoration:blink;color:#5971A8;" >忘记密码？</a>
			<a href="javascript:regPage();"style="text-decoration:blink;color:#5971A8;position:absolute;right:20px;">注册</a>
		</div>
	</div>
	<script type="text/javascript">
		function lostPwdPage(){
			$("#login").css("display","none");
			$("#regist").css("display","block");
			$("#mark").val("lostPwd");
		}
		function regPage(){
			$("#login").css("#display","none");
			$("#regist").css("display","block");
			$("#mark").val("regist");
		}
			
	</script>
</body>
</html>