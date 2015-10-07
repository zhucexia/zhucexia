<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
			<table class="cart-table">
				<thead>
					<th width="44"></th>
					<th width="400" style="text-align: left;">所选产品</th>
					<th width="115">项目费用</th>
					<th width="207">订单状态</th>
					<th>操作</th>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" name="" id=""></td>
						<td class="tal"><img src="${root }/static/images/cart/product.png" alt="">
							<span class="product-text">市区vip定制套餐</span></td>
						<td>1000.0元</td>
						<td>尚未提供公司资料</td>
						<td><a href="javascript:;" class="cart-btn">删除</a></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="" id=""></td>
						<td class="tal"><img src="${root }/static/images/cart/product.png" alt="">
							<span class="product-text">市区vip定制套餐</span></td>
						<td>1000.0元</td>
						<td>尚未提供公司资料</td>
						<td><a href="javascript:;" class="cart-btn">删除</a></td>
					</tr>
					<tr>
						<td><input type="checkbox" name="" id=""></td>
						<td class="tal"><img src="${root }/static/images/cart/product.png" alt="">
							<span class="product-text">市区vip定制套餐</span></td>
						<td>1000.0元</td>
						<td>尚未提供公司资料</td>
						<td><a href="javascript:;" class="cart-btn">删除</a></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" class="tal">&emsp;<input type="checkbox">
							全选 <input type="checkbox">
							反选&emsp;&emsp;删除所选产品&emsp;&emsp;已选择1件商品
						</td>
						<td>1000.00元</td>
						<td><a href="javascript:;" class="cart-btn">提交材料</a> <a
							href="javascript:;" class="cart-btn">付款</a></td>
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