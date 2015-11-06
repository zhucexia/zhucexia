<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<jsp:include page="/views/common/header.jsp" />
<jsp:include page="/views/common/top.jsp" />
<html lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>助策侠网络科技有限公司 订单管理</title>
<link type="text/css" rel="stylesheet"
	href="${root }/static/css/plugins/bootstrap.css">
<link type="text/css" rel="stylesheet"
	href="${root }/static/css/user/ucenter.css">
<link rel="stylesheet"
	href="${root }/static/css/plugins/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${root }/static/css/plugins/facebox.css">
<link 
	rel="stylesheet" href="${root }/static/css/plugins/jquery-ui.min.css">
<link rel="stylesheet" type="text/css"
		href="${root }/static/css/common/skin.css" media="all">
<script 
	src="${root }/static/js/common/jquery-1.10.2.min.js"></script>
<script 
	src="${root }/static/js/plugins/jquery-ui-1.10.3.min.js"></script>
<script 
	src="${root }/static/js/plugins/jquery.ui.datepicker-zh-CN.js"></script>
<script 
	src="${root }/static/js/plugins/bootstrap-alert.js"></script>
<script 
	src="${root }/static/js/plugins/bootstrap-dropdown.js"></script>
<script type="text/javascript"
	src="${root }/static/js/plugins/bootstrap-modal_2_3.js"></script>
<script type="text/javascript"
	src="${root }/static/js/plugins/bootstrap-timepicker.js"></script>
<script 
	src="${root }/static/js/plugins/plupload.full.min.js"></script>
<script 
	src="${root }/static/js/plugins/facebox.js"></script>
<script src="${root }/static/js/order/base.min.js"></script>
<script type="text/javascript"
	src="${root }/static/js/order/address_all.js"></script>
<script type="text/javascript"
	src="${root }/static/js/order/checkout.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${root }/static/css/order/base.css" />
<script type="text/javascript"
	src="${root }/static/js/order/jquery_cart.js"></script>
<script 
	src="${root }/static/js/common/da.js"></script>
<link rel="stylesheet" type="text/css"
	href="${root }/static/css/order/checkOut.css" />
		<script type="text/javascript">
			var checkoutConfig = {
				addressMatch : 'common',
				addressMatchVarName : 'data',
				hasPresales : false,
				hasBigTv : false,
				hasAir : false,
				hasScales : false,
				hasGiftcard : false,
				totalPrice : 244.00,
				postage : 10,//运费
				postFree : true,//活动是否免邮了
				bcPrice : 150,//计算界值
				activityDiscountMoney : 0.00,//活动优惠
				showCouponBox : 0,
				invoice : {
					NA : "0",
					personal : "1",
					company : "2",
					electronic : "4"
				}
			};
			var miniCartDisable = true;
		</script>
      	<script type="text/javascript">
	       // 导航选卡
	       $(function(){
	           ch = $('.wisub').children();
	           $.each(ch, function(index, value){
	               if (value && (window.location.href ==value.href || window.location.pathname == value.href)) {
	                   $(value).addClass("selected");
	               }
	           });
	           $("#J_useNewAddr").hover(function(){
	        	   $(this).css("color","green");
	        	   
	           },
	           function(){
	        	   $(this).css("color","black");
	           }
	           )

	       })
					function isDefault(id){
						if (confirm("确定要设置为默认地址？")){
						  $.ajax({
							url: "${root}/address/setIsDefault?id="+id,
							type: "POST",
							success: function(data){
							var data=eval('('+data+')');
							  if(data.message){
							  location.reload();
							  }
							},
							error: function(data){
							  alert("设置默认地址失败，请刷新页面后重试");
							  location.reload();
							},
						  })
						}
	      		 }
				  function delId(id){
					//event.preventDefault();
					if (confirm("确定要删除当前地址吗？")){
					  $.ajax({
						url: "${root}/address/delAddr?id="+id,
						type: "POST",
						success: function(data){		
						  location.reload();
						},
						error: function(data){
						  alert("删除地址失败，请刷新页面后重试");
						  location.reload();
						},
					  })
					}
				  }
        </script>
        
		<script id="newAddrTemplate" type="text/x-dot-template">
        <dl class="item selected" data-isnew="true" data-consignee="{{=it.consignee}}" data-tel="{{=it.tel}}" data-province="{{=it.province}}" data-provincename="{{=it.provinceName}}" data-city="{{=it.city}}" data-cityname="{{=it.cityName}}" data-county="{{=it.county}}" data-countyname="{{=it.countyName}}" data-zipcode="{{=it.zipcode}}" data-street="{{=it.street}}" data-tag="{{=it.tag}}">
            <dt>
                <strong class="itemConsignee">{{=it.consignee}}</strong>
                {{? it.tag }}
                    <span  class="itemTag tag">{{=it.tag}}</span>
                {{?}}
            </dt>
            <dd>
                <p class="tel itemTel">{{=it.tel}}</p>
                <p class="itemRegion">{{=it.provinceName}} {{=it.cityName}} {{=it.countyName}}</p>
                <p class="itemStreet">{{=it.street}} ({{=it.zipcode}})</p>
                <span class="edit-btn J_editAddr">编辑</span>
            </dd>
			<dd style="display:none">
				 <input type="radio" name="Checkout[address]" class="addressId"  value="10140916720030323">
		   </dd>
        </dl>
	</script>
</head>
<body>
   	<div class="WB_miniblog">
   		<div class="topNavWrap-pindao" style="background-color:">
   			<div class="grhead">
   				<div class="grinfo">
				</div>
			</div>
		</div>
		<div class="second_newmenu">
			<div class="navboxSecond">
				<div class="subNav" id="widget-subnav">
					<span class="clt"></span>
					<span class="crt"></span>
					<span class="clb"></span>
					<span class="crb"></span>
					<div class="navLt wisub" style="display:none;">
					</div>
					<div class="navRt wisub">
						<a href="${root}/sales/toOrderManage"> 我的账户 </a> |      
			            <a href="http://www.zhucexia.com/orders/"> 我的交易 </a> |
	              	</div>
              	</div>
            </div>
        </div>
        <div class="second_newmenu-fix"></div>
        <div class="grbg">
        	<div class="s_main">
        		<div class="border_gray clearfix">
        		<!-- tabs -->
        			<div class="pc_tabs pc_tabs-full mb20 clearfix">
        				<div class="tabGray">
        					<div class="tabBox leftTab">
        						<ul class="tabLinks">
        							<li>
        								<a href="http://www.zhucexia.com/orders/">订单管理</a>
        							</li>
        							<li>
        								<a href="http://www.zhucexia.com/unreview/items/">评价管理</a>
        							</li>
        							<li>
        								<a href="http://www.zhucexia.com/favorites/">收藏管理</a>
        							</li>
        							<li class="selected">
        								<a href="./助策侠网络科技有限公司 地址列表_files/助策侠网络科技有限公司 地址列表.html">收货地址管理</a>
        							</li>
        						</ul>
        					</div>
        				</div>
        			</div>
        			<!-- contant -->
        			<div class="setting_wrap clearfix">
        				<div class="innerallbox">
        					<div class="clearfix" >
        					<!-- class="edit-btn J_editAddr" -->
        						<!-- <a href="javascript:void(0)" id="J_useNewAddr" class="btn btn-success pull-right" >新增收货地址</a>
  -->        		<!--			<div align="right" ><a href="javascript:void(0)" id="J_useNewAddr" >新增收货地址</a>
                                 </div> -->
                             	<div class="item use-new-addr" id="J_useNewAddr" data-state="off" align="right">
												<span class="iconfont icon-add">
												<img src="${root }/static/images/cart/add_cart.png"  style="width:20px;heigh:20px"/></span> 新增收货地址
								</div>
									</div>
        					</div>
        					
        					<table class="table table-striped" width="100%">
        						<thead>
        							<tr>
        								<th>联系人名称</th>
        								<th>手机</th>
        								<th>地址</th>
        								<th>默认地址</th>
        								<th>操作</th>
        							</tr>
        						</thead>
        						
        						<tbody>
        							<c:if test="${ empty list}">
	        							<tr>
	        								<td>
	                    						你暂时没有收货联系人：）
	                  						</td>
	                  					</tr>
                  					</c:if>
                  					<c:if test="${ ! empty list}">
                  						<c:forEach items="${list}" var="item">
                  							<tr>
                  								<td>${ item.name}</td>
                  								<td>${ item.telephone}</td>
                  								<td>${item.address}&nbsp;${item.areaRegion}</td>
                  								<td>
                  									<c:if test="${item.is_default==1 }">
                  										是
                  									</c:if>
                  									<c:if test="${item.is_default==0 }">
                  										否
                  									</c:if>
                  								</td>
                  								<td id="${item.id }">
                  									<c:if test="${item.is_default==0 }">
                  										<a href="javascript:void(0)" onclick="isDefault(${item.id })">默认</a>
                  									</c:if>                  								
                   									<c:if test="${item.is_default==1 }">
                  										<a href="javascript:void(0)">&nbsp;&nbsp;--&nbsp;&nbsp;&nbsp;</a>
                  									</c:if>                   									
													<!-- <a href="/address/edit/1436/" class='btn btn-small'>编辑</a> -->
													<a  class="edit-btn J_editAddr">编辑</a>
													<a href="javascript:void(0)"  onclick="delId(${item.id })">删除</a>
												</td>
                  							</tr>
                  						</c:forEach>
                  					</c:if>
                  				</tbody>
                  		    </table>
                  	    </div>
                    </div>
                </div>
            </div>
        </div>   
        <!-- 地址状态 0：默认选择；1：新增地址；2：修改地址 -->
		<input type="hidden" name="Checkout[addressState]" id="addrState"
				value="0">
       	<div class="box-bd">
       	 
			<div class="clearfix xm-address-list" id="checkoutAddrList">
				<!-- <div  id="J_useNewAddr" data-state="off">
				<dl id="dl"></dl> -->
			</div>
		</div>      					

		    <input type="hidden" name="newAddress[type]" id="newType" value="common">
			<input type="hidden" name="newAddress[consignee]" id="newConsignee"> 
			<input type="hidden" name="newAddress[province]" id="newProvince">
			<input type="hidden" name="newAddress[city]" id="newCity">
			<input type="hidden" name="newAddress[district]" id="newCounty">
			<input type="hidden" name="newAddress[address]" id="newStreet">
			<input type="hidden" name="newAddress[zipcode]" id="newZipcode">
			<input type="hidden" name="newAddress[tel]" id="newTel">
			<input type="hidden" name="newAddress[tag_name]" id="newTag">
	<!--点击弹出新增/收货地址界面start-->
	<div class="xm-edit-addr-box" id="J_editAddrBox" style="height: 440px; display: none; width: 300px; top: 125px; left: 471px;" >
		<div class="bd">
			<div class="item">
				<label>收货人姓名<span>*</span></label> 
				<input type="text"
					name="userAddress[consignee]" id="Consignee" class="input"
					placeholder="收货人姓名" maxlength="15" autocomplete='off'>
				<p class="tip-msg tipMsg"></p>
			</div>
			<div class="item">
				<label>联系电话<span>*</span></label> 
				<input type="text"
						name="userAddress[tel]" class="input" id="Telephone"
						placeholder="11位手机号" autocomplete='off'>
				<p class="tel-modify-tip" id="telModifyTip"></p>
				<p class="tip-msg tipMsg"></p>
			</div>
			<div class="item">
				<label>地址<span>*</span></label> 
				<select name="userAddress[province]" id="Provinces" class="select-1">
					<option>省份/自治区</option>
				</select> 
				<select name="userAddress[city]" id="Citys" class="select-2" disabled>
					<option>城市/地区/自治州</option>
				</select>
				<select name="userAddress[county]" id="Countys" class="select-3" disabled>
					<option>区/县</option>
				</select>
				<br>
				<textarea name="userAddress[street]" class="input-area"
					id="Street" placeholder="路名或街道地址，门牌号"></textarea>
				<p class="tip-msg tipMsg"></p>
			</div>
			<div class="item">
				<label>邮政编码<span>*</span></label> 
				<input type="text"
					name="userAddress[zipcode]" id="Zipcode" class="input"
					placeholder="邮政编码" autocomplete='off'>
				<p class="zipcode-tip" id="zipcodeTip"></p>
				<p class="tip-msg tipMsg"></p>
			</div>
			<div class="item">
				<label>地址标签<span>*</span></label> 
				<input type="text"
					name="userAddress[tag]" id="Tag" class="input"
					placeholder='地址标签：如"家"、"公司"。限5个字内'>
				<p class="tip-msg tipMsg"></p>
				<input type="hidden" id="AddIds" name="AddrIds" >
			</div>
				
			<div class="ft clearfix" >
				<button type="button" class="btn btn-lineDake btn-small "
					id="J_editAddrCancel">取消</button>
				<button type="button" class="btn btn-primary  btn-small "
					id="J_editAddrOk">保存</button>
			</div>
		</div>
	</div>
    </div> 
    </div>	
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
    <!-- 选择在该页面为1 -->
    <input type="hidden" value="1" id="flag">				
   </body>
</html>
<jsp:include page="/views/common/footer.jsp" />
