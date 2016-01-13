<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<link rel="stylesheet" type="text/css" href="${root}/static/css/weixin/weixin.css">
		<link rel="stylesheet" type="text/css" href="${root}/static/css/weixin/icono.min.css"/>
		<link rel="stylesheet" type="text/css" href="${root}/static/css/weixin/order.css"/>
		<link rel="stylesheet" type="text/css" href="${root}/static/css/weixin/address.css"/>
		<script type="text/javascript" src="${root}/static/js/order/address_all.js">
				</script>
		<script type="text/javascript" src="${root}/static/js/common/jquery-1.7.1.min.js">
				</script>
		<script type="text/javascript">
			function createProvince(){
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
						prov.style.font="bold 30px/30px arial,sans-serif";
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
								prov.style.font="bold 30px/30px arial,sans-serif";
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
										var zipCode=this.name;
										var address=ProvinceName+" "+CityName+" "+AreaName;
										var areaId=ProvinceId+","+CityId+","+AreaId;
										$("#area").attr("value",address);
										$("#areaId").attr("value",areaId);
										$("#zipcode").attr("value",zipCode);
										document.getElementById("div1").style.display="none";
										document.getElementById("bg").style.display="block";
										
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
			
			function returnsBook(){
				document.getElementById("div1").style.display="none";
				document.getElementById("bg").style.display="block";
			}
			/*提交定单信息*/
			function bookOrders(){
				var area=$("#area").val();
				var areaId=$("#areaId").val();
				var goodId=${goodPo.id};
				var order_money=${goodPo.price_market};
				var address=$("#address").val();
				var consignor=$("#consignor").val();
				var telephone=$("#telephone").val();
				var zipcode=$("#zipcode").val()
				var flag=true;
				if(area==null){
					flag=false;
				}
				if(address==null){
					flag=false;
				}
				if(consignor==null){
					flag=false;
				}
				if(telephone==null){
					flag=false;
				}
				if(flag){
					$.ajax({
						url:"${root}/WXOrder/buildOrders",
						data:{"area":area,"areaId":areaId,"address":address,"consignor":consignor,"telephone":telephone,
							"zipcode":zipcode,"goodId":goodId,"order_money":order_money},
						type:"post",
						success:function(){
							location.href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx7eb46e5ce64de326&redirect_uri=http%3A%2F%2Fwww.zhucexia.com%2FWXOrder%2FmakeSurePrice&response_type=code&scope=snsapi_base&state="+goodId+"#wechat_redirect";
						}
					});
				}
				
			}
		</script>		
	</head>
	<body>
		<div class="bg" id="bg">
			<div class="headerClass">
				<div class="a">1.确认订单</div>
				<div class="b">2.支付</div>
				<div class="clear"></div>
			</div>
			<div class="hrs"></div>
			<ul class="goodsName">
				<li>
					<span>购买产品</span>
					<span class="rights">${goodPo.name}</span>
				</li>
				<li>
					<span>产品类型</span>
					<span class="rights" >${goodPo.good_type_name}</span>
				</li>
				<li>
					<span>产品价格</span>
					<span class="rights" style="color:#ff9102;font-weight:bold;">${goodPo.price_market}元</span>
				</li>
			</ul>
			<div class="address">填写地址信息</div>
			<div>
				<ul class="addr">			
					<li>
						<input type="text" placeholder="地区" onclick="createProvince();" id="area" name="area"/>
						<input type="hidden" id="areaId" name="areaId"/>
						<input type="hidden" name="goodId" value="${goodPo.id}">
						<input type="hidden" name="order_money" value="${goodPo.price_market }">
					</li>
					<li>
						<input  type="text" placeholder="街道地址" id="address" name="address"/>
					</li>
					<li>
						<input type="text" placeholder="姓名" id="consignor" name="consignor" />
					</li>
					<li>
						<input type="text" placeholder="联系电话"id="telephone" name="telephone"/>
					</li>
					<li>
						<input type="text" placeholder="邮编" id="zipcode" readonly="readonly" name="zipcode">
						<div class="clear"></div>
					</li>
				</ul>
				
			</div>
			<div class="next">
				<a href="#" style="width:100%;padding-top:8px;padding-bottom:8px;text-align:center;margin:0px;
					background-color:#2294ff;color:#fff;text-decoration:none;display:block;border-radius:4px;
					-webkit-border-radius:4px;-moz-border-radius:4px;"onclick="bookOrders();">下一步，支付</a>
		    </div>
		</div>
		<div id="div1" class="div1">
			<div id="return" style="border-bottom:1px solid rgb(203, 203, 203);margin:6px 0px;padding-bottom:0px;padding-left:12px;">
			<a style="display:block;color:black;" href="javascript:void(0);" onclick="returnsBook();">
			     <font size='14px;' style="float:left;margin:0px;padding:0px;"><</font>  
			     <p style="float:left;padding:0;margin-top:18px;margin-left:20px">收货地址管理</p>
				 <div style="clear:both;"></div>
			</a>
			</div>
			<ul id="citys">
			</ul>
			<ul	id="city" style="display:none;">
			</ul>
			<ul id="areaRegion" style="display:none;">
			</ul>
		</div>
<jsp:include page="/views/weixinpage/foot.jsp"></jsp:include>
