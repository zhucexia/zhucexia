<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 	<meta name="viewport" id="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"/>
  	<meta name="apple-mobile-web-app-capable" content="yes"/>
  	<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
	<title>注册侠</title>
	<link rel="stylesheet" type="text/css" href="./weixin.css">
	<script language="javascript" src="./jquery.min.js"></script>
	<script src="./hammer.min.js"></script>
	<script src="./jquery.hammer.js"></script>
	<script language="javascript" src="./dialog-h5-min.js"></script>
</head>
<body>
	<div class="divbody">
		<div class="backbtn">
			<a href="">← 确认支付</a>
		</div>
		<div class="addr">
			<a href="">
				<div class="icon">@</div>
				<div class="name">单红杰</div>
				<div class="mobile">15503460968</div>
				<div class="address">上海市嘉定区沪宜公路1188号南翔智地3号楼智能硬件产业基地206</div>
			</a>
		</div>
		<div class="cut_off"></div>
		<div class="payment">
			<a href="">
				<div class="payment_cld">微信支付</div>
			</a>
			<div class="retina-1px-border-bottom"></div>
			<a href="">
				<div class="payment_cld">支付宝支付</div>
			</a>
		</div>
		<div class="cut_off"></div>
	</div>
	<style type="text/css">
		.backbtn{width:100%;height:50px;background-color:#529BFF;}
		.backbtn a{display:inline-block;width:100%;text-decoration:none;color:#555;padding:15px;color:#fff;}
		.addr{position:relative;width:100%;height:70px;}
		.addr a{width:100%;display:inline-block;}
		.addr .icon{position:absolute;left:0;top:0;width:15%;height:66px;text-align:center;}
		.addr .name{position:absolute;left:15%;top:5px;color:#111;}
		.addr .mobile{position:absolute;left:35%;top:5px;color:#111;}
		.addr .address{position:absolute;left:15%;top:30px;color:#555;}
		.payment{width:100%;position:relative;height:100px;}
		.payment_cld{width:100%;position:relative;padding:16px 0;margin:0 30px;}
		.payment a{text-decoration:none;color:#000;display:inline-block;width:100%;}
		.cut_off{height:3px;width:100%;background-color:#529BFF;}
	</style>
</body>
</html>