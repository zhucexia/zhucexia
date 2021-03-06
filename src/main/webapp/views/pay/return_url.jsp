<%
/* *
 功能：支付宝页面跳转同步通知页面
 版本：3.2

 //***********页面功能说明***********
 该页面可在本机电脑测试
 可放入HTML等美化页面的代码、商户业务逻辑程序代码
 TRADE_FINISHED(表示交易已经成功结束，并不能再对该交易做后续操作);
 TRADE_SUCCESS(表示交易已经成功结束，可以对该交易做后续操作，如：分润、退款等);
 //********************************
 * */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.keji50.zhucexia.service.out.alipay.util.*"%>
<%@ page import="com.keji50.zhucexia.service.out.alipay.config.AlipayConfig"%>
<%@ page import="com.keji50.zhucexia.service.SaleOrderService"%>
<%@ page import="com.keji50.zhucexia.common.utils.ApplicationContextHolder"%>
<%	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();
	request.setAttribute("root",root);%>
<html>
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="${root }/static/js/common/jquery-1.10.2.min.js"></script>
		<title>支付宝页面跳转同步通知页面</title>
  </head>
  <body style="margin:0;">
<%
	//获取支付宝GET过来反馈信息
	Map<String,String> params = new HashMap<String,String>();
	Map requestParams = request.getParameterMap();
	Boolean result = false;
	for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
		String name = (String) iter.next();
		String[] values = (String[]) requestParams.get(name);
		String valueStr = "";
		for (int i = 0; i < values.length; i++) {
			valueStr = (i == values.length - 1) ? valueStr + values[i]
					: valueStr + values[i] + ",";
		}
		//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
		valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		System.out.println(name+"_________"+valueStr);
		params.put(name, valueStr);
	}
	
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
	//商户订单号
	String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

	//支付宝交易号
	String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

	//交易状态
	String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
  
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
	//String addr = new String(request.getParameter("WID_AddrId").getBytes("ISO-8859-1"),"UTF-8");
	//String method = new String(request.getParameter("WID_Method").getBytes("ISO-8859-1"),"UTF-8");
	//计算得出通知验证结果
	boolean verify_result = AlipayNotify.verify(params);
	//获取网站传递的参数
	if(verify_result){//验证成功
		//////////////////////////////////////////////////////////////////////////////////////////
		//请在这里加上商户的业务逻辑程序代码

		//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
		if(trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")){
			//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
				//获取地址信息id

				String payMethod=params.get("payment_type");
				SaleOrderService saleOrderService=ApplicationContextHolder.getBean("saleOrderService");
				String bool=saleOrderService.update(out_trade_no, payMethod, trade_no);
				if(bool.equals("success")){
					//out.println("你的订单号为："+out_trade_no+",已验证成功<br />");
					result = true;
				}
		}
		
		//该页面可做页面美工编辑
		//out.println("验证成功<br />");
		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

		//////////////////////////////////////////////////////////////////////////////////////////
	}else{
		//该页面可做页面美工编辑
		//out.println("验证失败");
	}
%>
	<div style="width:100%;height:54px;margin-bottom:60px;background:#1d2087">
		<div style="height:52px;position:relative;margin:0 auto;width:1000px;">
			<div style="top:15px;left:0;position:absolute;z-index:99">
				<img src="${root }/static/images/header/logo.png">	
			</div>
		</div>		
	</div>
	<div style="width:1000px;height:348px;position:relative;margin:0 auto;border:1px #CBCBCB solid;">
		<div style="height:30px;padding-left:30px;background-color:#F4F4F4;border:1px #EDEEF2 solid">
			<p style="margin:6px 0 0 0;"><strong>订单支付成功</strong></p>
		</div>
		<div style="height:318px;">
			<div style="width:100px;height:100px;position:absolute;left:300px;top:120px;">
				<img id="prompt_pic" width="100px;">				
			</div>
			<div style="position:absolute;left:420px;top:145px;">
				<span id="prompt1"><strong></strong></span><br/><br/>
				<span id="prompt2"><strong></strong></span>
			</div>
			<script type="text/javascript">
				if(<%=result%>){
					$("#prompt_pic").attr("src","${root}/static/images/common/true.jpg")
					$("#prompt1 strong").html("您的订单已支付成功");
					$("#prompt2 strong").html("订单号为：<%=out_trade_no%>");
				}else{
					$("#prompt_pic").attr("src","${root}/static/images/common/false.png")
					$("#prompt1 strong").html("订单支付失败，请重新支付");
					$("#prompt2 strong").hide();
				}
			</script>
			<div style="position:absolute;left:380px;top:255px">
				<a href="${root}/">返回首页</a>
			</div>
		</div>
	</div>	
  </body>
</html>
