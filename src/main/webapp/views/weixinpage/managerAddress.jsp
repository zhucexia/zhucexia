<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
		<link rel="styleSheet" type="text/css" href="icono.min.css"/>
		<title>
			地址管理
		</title>
		<style>
			.personal{
				max-width:1024px;
				margin:0px;
				padding:0px 0px;
				
			}
			.manageHeader{
				width:100%;
				font-size:1.2em;
				border-bottom:1px solid black;
				padding-top:10px;
				padding-bottom:0px;
				position:fixed;
				top:0px;
			}
			li{
				margin-left:12px;
				font-size:1.2em;
				border-bottom:1px solid rgb(249, 249, 249);
				/*border-bottom:1px solid black;*/
				padding-bottom:6px;
			}
		    li a:hover{
				background-color:rgb(224, 249, 71);
			}
			a{
				text-decoration:none;
				color:black;
				display:block;
			}
			i.is{
				float:right;
				text-align:center;
				margin-top:60px;
			}
			input[type=button]{
				width:100%;
				text-align:center;
				background-color:red;
				padding:5px;
				font-size:18px;
				color:white;
				outline-color:red;	
			}
		</style>
		<script type="text/javascript" src="jquery-2.1.1.min.js" ></script>
		<script type="text/javascript">
			function addAddr(){
				location.href="${root}/WXAddr/toAddAddr";
			}
		</script>
	</head>	
	<body >
		<div class="personal">
			<div class="manageHeader">
				<a href="${root}/WXUser/userCenter">
					<i class="icono-caretLeft"></i>收货地址管理	
				</a>
			</div>
			<div style="width:100%;margin-top:46px">
				<ul style="list-style-type:none;margin:0px;padding:0;">
				<c:if test="${!empty list }">
				<c:forEach var="item" items="${list}">
					<li>
						<a href="${root }/WXAddr/toUpdateAddr?id=${item.id}">
							<div style="background:rgb(231, 231, 231);padding-left: 4px;">
								<div style="float:left;width:90%">
									<p>
										<span>${item.name }</span>
										<span style="float:right;">${item.telephone }</span>
									</p>
									<p>
										${item.address}${item.areaRegion}${item.street}
									</p>
								</div>		
								<i class="icono-caretRight is" ></i>
								<div style="clear:both;"></div>
							</div>
						</a>
					</li>
				</c:forEach>
				 </c:if>					
				</ul>
			</div>
			<div style="width:100%;">
				<input type="button" value="新增收货地址" onclick="addAddr();">
			</div>
		</div>
	</body>
</html>