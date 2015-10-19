<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:include page="/views/common/header.jsp" />
<link rel="stylesheet" href="${root }/static/css/cart/cart.css">
<jsp:include page="/views/common/top.jsp" />
<script type="text/javascript" src="${root }/static/js/cart/address_all.js"></script>
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
					<th width="400" style="text-align: left;">所选订单</th>
					<th width="115">订单费用</th>
					<th width="207">订单状态</th>
					<th>操作</th>
				</thead>	
				<tbody>
					<tr>
						<td><input type="checkbox" name="checkbox" id=""></td>
						<td><img src="${root }/static/images/cart/product.png" alt="">
							<span class="product-text">市区vip定制套餐</span></td>
						<td><span class="price">1001.0</span>元</td>
						<td>尚未提供公司资料</td>
						<td><a href="javascript:;" style="color:red;font-weight:bold;">删除</a></br></br><a href="${root }/views/queryorder.jsp" style="color:green;font-weight:bold;" >查看详情</a></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="checkbox" id=""></td>
						<td><img src="${root }/static/images/cart/product.png" alt="">
							<span class="product-text">市区vip定制套餐</span></td>
						<td><span class="price">1002.0</span>元</td>
						<td>尚未提供公司资料</td>
						<td><a href="javascript:;" style="color:red;font-weight:bold;">删除</a></br></br><a href="javascript:;" style="color:green;font-weight:bold;" >查看详情</a></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="checkbox" id=""></td>
						<td><img src="${root }/static/images/cart/product.png" alt="">
							<span class="product-text">市区vip定制套餐</span></td>
						<td><span class="price">1003.0</span>元</td>
						<td>尚未提供公司资料</td>
						<td><a href="javascript:;" style="color:red;font-weight:bold;">删除</a></br></br><a href="javascript:;" style="color:green;font-weight:bold;" >查看详情</a></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" class="tal">&emsp;<input type="checkbox" id="checkall"  onclick="checkAll()">
							全选 <input type="checkbox" id="checkother" onclick="checkOther()">
							反选&emsp;&emsp;<a href="javascript:;" id="removeselected">删除所选订单</a>&emsp;&emsp;已选择<span id="selectedTotal">0</span>个订单
						</td>
						<td><span id="priceTotal">0.00</span>元</td>
						<td><a href="javascript:;" >&nbsp;</a> <a
							href="javascript:;" >&nbsp;</a></td>
					</tr>
				</tfoot>
			</table>
		</div>
				<script language="javascript">
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
					var removed=document.getElementsByName("remove");					
					for(var i=0;i<tr.length;i++){
						removed[i].onclick=function(){
							var conf=confirm("确定删除此商品吗？");
							if(conf){
								this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode);
							}
							getTotal();
						}
					
					} 
				
					//删除所选产品
					document.getElementById("removeselected").onclick=function(){
						var dos=document.getElementsByName("checkbox");
						for(var i=0;i<tr.length;i++){
							if(dos[i].checked){
								tr[i].parentNode.removeChild(tr[i]);
								i--;
							}
							getTotal();
						}
					}
					//点击提交材料按钮
					document.getElementById("editaddr").onclick=function(){
						document.getElementById("J_editAddrBox").style.display="block";
					}
					//点击取消隐藏材料提交页面
					function editcancel(){
						document.getElementById("J_editAddrBox").style.display="none";
					}
				</script> 
		<!--  <div class="xm-edit-addr-box" id="J_editAddrBox" style="display:none;">
        	<div class="bd">
	            <div class="item">
	                <label>收货人姓名<span>*</span></label> 
	                <input type="text" name="userAddress[consignee]" id="Consignee" class="input" placeholder="收货人姓名" maxlength="15" autocomplete='off'>
	                <p class="tip-msg tipMsg"></p>	
	            </div>
	            <div class="item">
	                <label>联系电话<span>*</span></label> 
	                <input type="text" name="userAddress[tel]" class="input" id="Telephone" placeholder="11位手机号" autocomplete='off'>
	                <p class="tel-modify-tip" id="telModifyTip"></p>
	                <p class="tip-msg tipMsg"></p>
	            </div>
	            <div class="item">
	                <label>地址<span>*</span></label>
	                <select name="userAddress[province]" id="Provinces" class="select-1">
	                    <option>省份/自治区</option>
	                </select>
	                <select name="userAddress[city]"  id="Citys" class="select-2" disabled>
	                    <option>城市/地区/自治州</option>
	                </select>
	                <select name="userAddress[county]"  id="Countys" class="select-3" disabled>
	                    <option>区/县</option>
	                </select>
	                <textarea   name="userAddress[street]" class="input-area" id="Street" placeholder="路名或街道地址，门牌号"></textarea>
	                <p class="tip-msg tipMsg"></p>
	            </div>
	            <div class="item">
	                <label>邮政编码<span>*</span></label> 
	                <input type="text" name="userAddress[zipcode]" id="Zipcode" class="input" placeholder="邮政编码"  autocomplete='off'>
	                <p class="zipcode-tip" id="zipcodeTip"></p>
	                <p class="tip-msg tipMsg"></p>
	            </div>
	            <div class="item">
	                <label>地址标签<span>*</span></label> 
	                <input type="text" name="userAddress[tag]" id="Tag" class="input" placeholder='地址标签：如"家"、"公司"。限5个字内'  >
	                <p class="tip-msg tipMsg"></p>
	            </div>
        	</div>
	        <div class="ft clearfix">
	            <button  type="button"  class="btn btn-lineDake btn-small " id="J_editAddrCancel" onclick="editcancel()">取消</button>
	             <button type="button" class="btn btn-primary  btn-small " id="J_editAddrOk">保存</button>
	        </div>
    	</div> -->
		<div class="cart-box">
			<div class="cart-title">
				<h3 class="fake-red">
					后续服务<i class="cart-arrow"></i>
				</h3>
			</div>
			<ul class="cart-list clearfix">
				<li><img src="${root }/static/images/cart/kaihu.png" alt=""><br> <b>银行开户</b><br>
					<span>在线免费预约开户</span><br> <b class="cash">￥888</b><br> <a
					href="" class="pay-btn">立即申购</a></li>
				<li><img src="${root }/static/images/cart/calcu.png" alt=""><br> <b>代理记账</b><br>
					<span>在线免费预约开户</span><br> <b class="cash">￥888</b><br> <a
					href="" class="pay-btn">立即申购</a></li>
				<li><img src="${root }/static/images/cart/payer.png" alt=""><br> <b>约见投资人</b><br>
					<span>在线免费预约开户</span><br> <b class="cash">￥888</b><br> <a
					href="" class="pay-btn">立即申购</a></li>
				<li><img src="${root }/static/images/cart/cash.png" alt=""><br> <b>入驻孵化器</b><br>
					<span>在线免费预约开户</span><br> <b class="cash">￥888</b><br> <a
					href="" class="pay-btn">立即申购</a></li>
				<li><img src="${root }/static/images/cart/livein.png" alt=""><br> <b>免租办公室</b><br>
					<span>在线免费预约开户</span><br> <b class="cash">￥888</b><br> <a
					href="" class="pay-btn">立即申购</a></li>
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
<jsp:include page="/views/common/footer.jsp" />