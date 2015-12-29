<%@page import="com.keji50.zhucexia.dao.po.CustomerPo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	// Set request data code convertion
	request.setCharacterEncoding("UTF-8");
	// Application common variables
	String root = request.getContextPath();
	request.setAttribute("root",root);
	CustomerPo customer=(CustomerPo)request.getSession().getAttribute("customer");
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
				padding-top:10px;
				padding-bottom:10px;
			}
			li{
				position:relative;
				margin-left:40px;
				height:52px;
				font-size:1.2em;
				border-bottom:1px solid rgb(249, 249, 249);
			}
			a{
				position:absolute;
				width:100%;
				line-height:52px;
				text-decoration:none;
				color:black;
			}
			.retina-1px-border-bottom{height:1px; position:relative;background-color:#DCDCDC}
		</style>
		<script type="text/javascript" src="${root}/static/js/common/jquery-2.1.1.min.js">
				</script>		
		
	</head>	
	<body >
		<div class="personal">
			<div class="personal1">
				个人中心
			</div>
			<div style="width:100%;border-top:1px solid black;border-bottom:1px solid black;">
				<ul style="list-style-type:none;padding:0;margin:0px;">
					<li>
						<a href="javascript:;" >
							收货地址<i class="icono-caretRight" style="float:right;margin:16px;" ></i>
						</a>
					</li>
					<div class="retina-1px-border-bottom" ></div>
					<li style="border-bottom:1px solid #F9F9F9;">
						<a href="javascript:changePwd();">
							修改密码<i class="icono-caretRight" style="float:right;margin:16px;"></i>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</body>
	<script type="text/javascript">
		function changePwd(){
			location.href="${root}/WXUser/toChangePwd";
		}
	</script>
</html>