<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();
	request.setAttribute("root",root);%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>支付结果</title>
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
			<p style="margin:6px 0 0 0;"><strong>订单支付成功</strong></p>
		</div>
		<div style="height:318px;">
			<div style="width:100px;height:100px;position:absolute;left:300px;top:120px;">
				<img src="${root }/static/images/common/true.jpg" width="100px;">				
			</div>
			<div style="position:absolute;left:420px;top:145px;">
				<span><strong>您的订单已提交成功</strong><span><br>
				<span><strong>订单号为：${order_no}</strong></span>
			</div>
			<div style="position:absolute;left:380px;top:255px">
				<a href="${root}/">返回首页</a>
			</div>
		</div>
	</div>	
</body>
</html>