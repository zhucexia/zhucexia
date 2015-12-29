<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	// Set request data code convertion
	request.setCharacterEncoding("UTF-8");
	// Application common variables
	String root = request.getContextPath();
	request.setAttribute("root",root);	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" id="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"/>
		<meta name="apple-mobile-web-app-capable" content="yes"/>
		<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
		<link rel="styleSheet" type="text/css" href="${root}/static/css/weixin/icono.min.css"/>
		<title>
			地址添加
		</title>
		<style>
			.personal{
				max-width:1024px;
				margin:0px;
				padding:0px 0px;
				
			}
			.personal1{
				width:100%;
				font-size:2em;
				text-align:center;
				border-bottom:1px solid black;
				padding-top:10px;
				padding-bottom:10px;
			}
			li{
				margin-top:12px;
				margin-bottom:12px;
				font-size:1.2em;
				border-bottom:1px solid rgb(249, 249, 249);
				padding-bottom:6px;
			}
			a{
				text-decoration:none;
				color:black;
			
			}
		</style>
		<script type="text/javascript" src="${root}/static/js/common/jquery-2.1.1.min.js">
				</script>		
		
	</head>	
	<body >
		<div class="personal">
			<div class="personal1">
				个人中心
			</div>
			<div style="width:100%;">
				<ul style="list-style-type:none;">
					<li>
						<a href="${root }/WXAddr/toManageAddr" >
							收货地址<i class="icono-caretRight" style="float:right;" ></i>
						</a>
						</li>
					<li>
						修改密码<i class="icono-caretRight" style="float:right"></i></li>
				</ul>
			</div>
		</div>
	</body>
</html>