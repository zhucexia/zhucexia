<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
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
		<title>
			收货地址管理
		</title>
		<style>
			#div1 ul{
				width:100%;
				padding-left:12px;
			}
			#div1 li{
				list-style-type:none;
				font-size:16px;
				margin:6px 6px;
				padding:3px 3px;
				border-bottom:1px solid rgb(240, 240, 240);
				width:100%;
			}
			#div1 li:nth-child(odd){
				background-color:rgb(248, 248, 248);
			}
			.liprovince{
				font-size:36px;
				background-color:black;
			}
			.licity{
				font-size:24px;
				background-color:black;
			}
			#div1{
				max-width:1024px;
			
			}
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
				background-color:white;
			}
			a{
				text-decoration:none;
				color:black;
			}
			i.rights{
				float:right;
			}
			input[type=text]{
				border-width:0px;
				outline:none;
				margin-left:12px;
				margin-top:12px;
				margin-bottom:12px;
				width:83%;
				height:25px;
				font-size:18px
				
			}
			input[type=text]:focus{
				border:none;
				border-bottom:1px solid black;
			}
			#delete{
				float:left;
				background-color:red;
				padding:8px 24px;
			}
			input[type=button]{
				float:right;
				background-color:red;
				padding:8px 24px;
				margin-right:20px;
			}
			div.manageFoot{
				padding:6px;
				width:100%;
				position:fixed;
				bottom:0px;
				background-color:rgb(250, 250, 250);
			}
		</style>
		<link rel="styleSheet" type="text/css" href="${root}/static/css/weixin/icono.min.css"/>
		<script type="text/javascript" src="${root}/static/js/cart/address_all.js">
				</script>
		<script type="text/javascript" src="${root}/static/js/common/jquery-2.1.1.min.js">
				</script>		
		<script type="text/javascript">
			function createProvince(){
				/*用来判断，收货地址，返回按钮，是隐藏当前页面的元素还是返回上一个页面*/
				$("#flag").val("2");
				document.getElementById("div1").style.display="block";
				document.getElementById("bg").style.display="none";
				var ul=document.getElementById("citys");
				for(var i=0;i<data.length;i++){
					var b =document.createElement("li");
					/*for(var key in data[i]){
						b.innerHTML=data[i][key];
					}*/	
					b.innerHTML=data[i].name;
					b.onclick=function(){
						/*清除城市列表*/
						$("#city").empty();
						var ul=document.getElementById("citys");
						/*隐藏省份列表*/
						ul.style.display="none";
						var uls=document.getElementById("city");
						/*显示城市列表*/
						uls.style.display="block";
						var ids=this.id;
						var province=data[ids-2];
						/*创建省份元素*/
						var prov=document.createElement("li");
						prov.id=province.id;
						prov.innerHTML=province.name;
						prov.style.background="rgb(112, 112, 112)";
						prov.style.font="bold 36px/30px arial,sans-serif";
						/*prov.style.position="fixed";*/
						prov.style.margin="0px 6px";
						prov.style.top="45px";
						prov.style.width="100%";
						/*显示城市列表*/
						prov.onclick =function(){
							var ul=document.getElementById("citys");
						    /*隐藏省份列表*/
						    ul.style.display="block";
						    var uls=document.getElementById("city");
						    /*显示城市列表*/
						    uls.style.display="none";
								
						}
						uls.appendChild(prov);
						/*获取省份下，城市的列表*/
						var city=province.child;
						for(var d=0;d<city.length;d++){
							/*创建城市列表*/
							var cit=document.createElement("li");
							cit.id=city[d].id;
							cit.innerHTML=city[d].name;
							/*添加选取区县的事件*/
							cit.onclick=function(){
								/*隐藏城市列表*/
								var ul=document.getElementById("city");
								ul.style.display="none";
								/*显示县区*/
								var uls=document.getElementById("areaRegion");
								uls.style.display="block"
								/*获取省份的id*/
								//var provinceId=$("#city").children("li").get(0).attr('id');
								var provinceId=$("#div1").find("#city li:first-child").attr('id');
								var province=data[ids-2];
								/*获取当前城市的序号，在json中排列的值*/
								var cityIndex=$(this).index();
								$("#areaRegion").empty();
								/*创建省份元素*/
								var prov=document.createElement("li");
								prov.id=province.id;
								prov.innerHTML=province.name;
								prov.style.background="rgb(112, 112, 112)";
								prov.style.font="bold 36px/30px arial,sans-serif";
								/*prov.style.position="fixed";*/
								prov.style.margin="0px 6px";
								prov.style.top="45px";
								prov.style.width="100%";
								uls.appendChild(prov);
								/*创建城市元素*/
								var citye=province.child;
								var citys=citye[cityIndex-1];
								var city=document.createElement("li");
								city.id=citys.id;
								city.innerHTML=citys.name;
								city.style.background="rgb(213, 213, 213)";
						        city.style.font="bold 24px/30px arial,sans-serif";
								/*city.style.position="fixed";*/
								city.style.margin="0px 6px";
								city.style.top="81px";
								city.style.width="100%";
								/*添加返回上一层城市的函数*/
								city.onclick=function(){
							        var ul=document.getElementById("city");
						            /*隐藏省份列表*/
						            ul.style.display="block";
						            var uls=document.getElementById("areaRegion");
						            /*显示城市列表*/
						            uls.style.display="none";
							        	}
								uls.appendChild(city);
								/*获取县区元素，创建列表*/
								var areas=citys.child;
								for(var e=0;e<areas.length;e++){
									var area=document.createElement("li");
									area.id=areas[e].id;
									area.innerHTML=areas[e].name;
									area.name=areas[e].zipcode;
									/*选择区域添加一个单击事件*/
									area.onclick=function(){
										/*获取省份元素*/
										var Province=$("#areaRegion li").eq(0);
										var ProvinceId=Province.attr('id');
										var ProvinceName=Province.text();
										/*获取城市元素*/
										var City=$("#areaRegion li").eq(1);
										var CityId=City.attr('id');
										var CityName=City.text();
										/*获取当前被选中的县区元素*/
										var AreaId=this.id;
										var AreaName=this.innerHTML;
										var zipcode=this.name;
										var address=ProvinceName+" "+CityName+" "+AreaName;
										$("#area").attr("value",address);
										/*省，城，区的id值*/
										var addressId=ProvinceId+","+CityId+","+AreaId;
										$("#addressId").attr("value",addressId);
										/**/
										$("#zipCode").attr("value",zipcode);
										document.getElementById("div1").style.display="none";
										document.getElementById("bg").style.display="block";
										$("#flag").val("1");
									}
									uls.appendChild(area);
								
								}
							
							
							}
							uls.appendChild(cit);
						}
						
					}
					b.id=data[i].id;
					ul.appendChild(b);
			}
			}
		function submits(){	
			$("#form1").submit();	
		}
		function backs(){
			var flag=$("#flag").val();
			if(flag=="1"){
				location.href="${root }/WXAddr/toManageAddr";
			}
			else{
				document.getElementById("div1").style.display="none";
				document.getElementById("bg").style.display="block";
				$("#flag").val("1");
			}
		}
		function cancles(){
			location.href="${root }/WXAddr/toManageAddr";
		}
		</script>		
	</head>	
	<body >
		<div class="personal">
			<div class="manageHeader">
				<a href="javascript:backs();">
					<i class="icono-caretLeft"></i>收货地址管理
					<input type="hidden" id="flag" value="${flag}">
				</a>
			</div>
			<form action="${root }/WXAddr/addAddr" method="post" id="form1">
			<div style="margin-top:46px;" >
				<div id="bg">
					<input type="text" placeholder="所在地区" onclick="createProvince();" 
						id="area"  name="address"/>
					<i class="icono-caretRight rights"></i><br/>
					<input type="text" placeholder="详细地址" id="address"  name="street">
					<i class="icono-caretRight rights"></i><br/>
					<input type="text" placeholder="请选择收货人姓名" id="realname"  name="name">
					<i class="icono-caretRight rights"></i><br/>
					<input type="text" placeholder="请输入收货人联系电话" id="telephone"  name="telephone">
					<i class="icono-caretRight rights"></i><br/>
					<input type="text" placeholder="请输入邮编" id="zipCode"  name="zip_code">
					<i class="icono-caretRight rights"></i><br/>
					<input type="hidden"  name="id">
					<input type="hidden"  name="addressId" id="addressId">		
				</div>
				<div id="div1" style="display:none;">
					<ul id="citys">
					</ul>
					<ul	id="city" style="display:none;">
					</ul>
					<ul id="areaRegion" style="display:none;">
					</ul>
				</div>
			</div>
			<div class="manageFoot">
				<input id="delete" type="button" value="取消" onclick="cancles();">
				<input type="button" value="保存" onclick="submits();">
			</div>

			</form>
		</div>
	</body>
</html>