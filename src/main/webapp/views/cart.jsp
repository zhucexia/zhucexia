<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="/views/common/header.jsp" />
<link rel="stylesheet" href="${root }/static/css/cart/cart.css">
<jsp:include page="/views/common/top.jsp" />
<div id="mainmain">
	<div class="main clearfix">
		<div class="cart-box">
			<div class="cart-title">
				<h3 class="dark-blue">
					我的订单<i class="cart-arrow"></i>
				</h3>
			</div>
			<table class="cart-table" id="cart-table">
				<thead>
					<th width="44"></th>
					<th width="400" style="text-align: left;">所选产品</th>
					<th width="115">项目费用</th>
					<th width="207">订单状态</th>
					<th>操作</th>
				</thead>
				<tbody>
					<c:if test="${! empty sessionScope.selectedGood}">
					<c:forEach items="${sessionScope.selectedGood}" var="item" varStatus="status">
					<tr id="${item.value.id}">
						<td><input type="checkbox" name="checkbox" value="${item.value.id}"></td>
						<td class="tal"><img width="150px" height="130px" src="${root }/static/images/${item.value.pic}" alt="">
							<span class="product-text">${item.value.name}</span></td>
						<td><span class="price">${item.value.price_market}</span>元</td>
						<td>尚未提供公司资料</td>
						<td>
						<a href="javascript:void(0);" class="cart-btn" onclick="removeOne(${status.index},${item.value.id});" name="remove">删除</a>
						</td>
					</tr>
					</c:forEach>
					</c:if>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" class="tal">&emsp;<input type="checkbox" id="checkall"  onclick="checkAll()">
							全选 <input type="checkbox" id="checkother" onclick="checkOther()">
							反选&emsp;&emsp;<a href="javascript:;" id="removeselected">删除所选产品</a>&emsp;&emsp;已选择<span id="selectedTotal">0</span>件商品
						</td>
						<td><span id="priceTotal">0.00</span>元</td>
						<td><a href="javascript:;" class="cart-btn">提交材料</a> <a
							href="javascript:;"  onclick="validateGood();" class="cart-btn">付款</a></td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="cart-box">
			<div class="cart-title">
				<h3 class="fake-red">
					后续服务<i class="cart-arrow"></i>
				</h3>
			</div>
			<ul class="cart-list clearfix">
			   <c:if test="${! empty sessionScope.unSelectedGood}">
					<c:forEach items="${sessionScope.unSelectedGood}" var="item">
						<li id="${item.value.id}"><img width="100px" height="100px" src="${root }/static/images/${item.value.pic}" alt=""><br> <b>银行开户</b><br>
						<span>${item.value.name}</span><br> <b class="cash">￥${item.value.price_market}</b><br> <a
						href="javascript:void(0)" onclick="addGood(${item.value.id})" class="pay-btn">立即申购</a></li>
			  		</c:forEach>
			   </c:if>
<%-- 				<li><img src="${root }/static/images/cart/kaihu.png" alt=""><br> <b>银行开户</b><br>
					<span>在线免费预约开户</span><br> <b class="cash">￥888</b><br> <a
					href="" class="pay-btn">立即申购</a></li>--%>
			</ul>
		</div>
		<div class="cart-box">
			<div class="cart-title">
				<h3 class="real-blue">
					注册流程<i class="cart-arrow"></i>
				</h3>
			</div>
			<img src="${root }/static/images/cart/progress.png" alt="">
		</div>
	</div>
</div>
<script type="text/javascript">
	var tr=document.getElementById("cart-table").children[1].rows;
	var selectedInputs=document.getElementsByName("checkbox");
    //点击选择框
	for(var i=0;i<selectedInputs.length;i++){
			selectedInputs[i].onclick=function(){
				if(!this.checked){
					document.getElementById("checkall").checked=false;
				}
					getTotal();
				}
	}
	//全选
	function checkAll(){
		var Object=document.getElementsByName("checkbox");
		var length=Object.length;
		var checked=document.getElementById("checkall").checked;
		for(var i=0;i<length;i++){
			Object[i].checked=checked;
			}
			document.getElementById("checkother").checked=false;
			getTotal();
		}
	//反选
	function checkOther(){
		var Object=document.getElementsByName("checkbox");
		var length=Object.length;
		for(var i=0;i<length;i++){
			if(Object[i].checked){
				Object[i].checked=false;
			}else{								
				Object[i].checked=true;
			}
		}
		document.getElementById("checkall").checked=false;
			getTotal();
		}
					
	//更新商品总数
   function getTotal(){
		var selected=0;
		var priceTotal=0;
		/* var Object=document.getElementsByName("checkbox"); */
		for(var i=0;i<tr.length;i++){
			if(document.getElementsByName("checkbox")[i].checked){
				selected+=1;
				priceTotal+=parseFloat(document.getElementsByClassName("price")[i].innerHTML);
			}
		}
		document.getElementById("selectedTotal").innerHTML=selected;
		document.getElementById("priceTotal").innerHTML=priceTotal.toFixed(2);
		}
		//删除商品
		function removeOne(trId,id){
			var trs=tr[trId];
			// alert(id);
			var conf=confirm("确定删除此商品吗？");
			 if(conf){
				trs.parentNode.removeChild(trs);
			}	
			getTotal();
			/*在页面删除商品后，在session里把其数据清空*/
			location.href="${root}/sales/clearSessionGood?ids="+id;
		} 		
		
	//删除所选产品
	document.getElementById("removeselected").onclick=function(){
		//获取被选择项id值
		var str="";
		var dos=document.getElementsByName("checkbox");
		for(var i=0;i<tr.length;i++){
			if(dos[i].checked){
			str+=tr[i].id+",";
			}
			getTotal();
		}
		location.href="${root}/sales/clearSessionGood?ids="+str;
	}
	//添加一个产品，从推送列表中
	function addGood(id){
		location.href="${root}/sales/addGood?id="+id;
		//alert(id);
		//获取当前对象
		//var good=document.getElementById(id);
		//alert(good);
		//删除当前对象
		//good.parentNode.removeChild(good);
		//获取已选商品对象列表，在末端追加一个商品对象
		//document.getElementById("cart-table").children[1].appendChild(good);
		//再次跳转到该页面	
	}
	//验证商品关系是否准确
	function validateGood(){
		$.ajax({
			url : "${root}/sales/buildOrder",
			type : 'POST',
			success : function(data){
				var dat=eval('('+data+')');
				if(dat.name!="true"){
					alert(dat.name+"未绑定基本套餐！");
				}
				else{
					/*判断选择了哪些产品，如果没有选择，要提示用户选择*/
					//拼接购买产品的id值
					var goodIds="";
					var dos=document.getElementsByName("checkbox");
					for(var i=0;i<tr.length;i++){
						if(dos[i].checked){
						goodIds+=dos[i].value+","
						}
					}
					if(goodIds!=""){
						location.href="${root}/sales/toOrderDetail?goodIds="+goodIds+"&priceTotal="+ $("#priceTotal").text();
					//计算总价格
					
					}
					else{
						alert("请选择要结算的产品！！");
					}
				}
				
			}
		});
		
	}
/* 	//点击提交材料按钮
	document.getElementById("editaddr").onclick=function(){
		document.getElementById("J_editAddrBox").style.display="block";
	}
	//点击取消隐藏材料提交页面
	function editcancel(){
		document.getElementById("J_editAddrBox").style.display="none";
	} */
</script> 
<jsp:include page="/views/common/footer.jsp" />