<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();
	request.setAttribute("root",root);%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>邮箱验证</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body style="margin:0">
	<div style="width:100%;height:54px;margin-bottom:60px;background:#1d2087">
		<div style="height:52px;position:relative;margin:0 auto;width:1000px;">
			<div style="top:15px;left:0;position:absolute;z-index:99">
				<img src="${root }/static/images/header/logo.png">	
			</div>
		</div>		
	</div>
	<div style="width:1000px;height:348px;position:relative;margin:0 auto;border:1px #CBCBCB solid;">
		<div style="height:30px;padding-left:30px;background-color:#F4F4F4;border:1px #EDEEF2 solid">
			<p style="margin:6px 0 0 0;"><strong>邮箱验证</strong></p>
		</div>
		<div style="height:318px;">
			<div style="width:100px;height:100px;position:absolute;left:300px;top:120px;">
				<img src="${root }/static/images/common/false.png" width="100px;">				
			</div>
			<div style="position:absolute;left:420px;top:145px;">
				<span><strong>对不起！您的验证邮件已过期，验证失败！</strong><span><br>
			</div>
			<div style="position:absolute;left:380px;top:255px">
				<a href="${root}/">前往首页</a>
			</div>
		</div>
	</div>	
</body>
</html>