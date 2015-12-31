<%@page import="com.keji50.zhucexia.dao.po.CustomerPo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	// Set request data code convertion
	request.setCharacterEncoding("UTF-8");
	// Application common variables
	String root = request.getContextPath();
	request.setAttribute("root",root);
	CustomerPo customer=(CustomerPo)request.getSession().getAttribute("customer");
%>
<div class="bottom" >
	<ul class="bottom_nav" >
		<li class="bottom_nav_btn" >
			<a href="${root}/WXIndex/goodList">注册公司</a>
		</li>
		<li class="bottom_nav_btn" >
			<a href="javascript:myorder();">我的订单</a>
		</li>
		<li class="bottom_nav_btn" style="border:none;">
			<a href="javascript:userCenter();">个人中心</a>
		</li>
	</ul>
</div>
	<script type="text/javascript">
		function myorder(){
			<%if(customer==null){%>
				location.href="${root}/WXUser/toLogin?aim=1";
			<%}else{%>
				location.href="${root}/WXOrder/orderManage";
			<%}%>
		}
		function userCenter(){
			<%if(customer==null){%>
				location.href="${root}/WXUser/toLogin?aim=3";
			<%}else{%>
				location.href="${root}/WXUser/userCenter";
			<%}%>
		}
	</script>
</body>
</html>
