package com.keji50.zhucexia.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.keji50.zhucexia.dao.po.PaymentPo;
import com.keji50.zhucexia.dao.po.SalaOrderPo;
import com.keji50.zhucexia.service.PaymentService;
import com.keji50.zhucexia.service.SaleOrderService;

@Controller
@RequestMapping(value = "/payment")
public class PaymentController {
    @Resource(name="paymentService")
    private   PaymentService  paymentService;
	@Resource(name="saleOrderService")
	private SaleOrderService saleOrderService;
	
	@RequestMapping(value = "/pay", method = RequestMethod.POST)
	public String pay(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		String orderId = request.getParameter("orderId");
        //根据orderid获取订单信息
         SalaOrderPo saleOrder = saleOrderService.getOrder(Integer.parseInt(orderId));
         System.out.println("orderId===="+orderId+"order_no---"+saleOrder.getOrder_no());
		// 检查订单是否是未支付状态， 是否过期
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String payment_state=saleOrder.getPaymentstate();
		//订单创建时间
		Date date=saleOrder.getCreateTime();
		//date.setMinutes(-30);
		// 更新订单的支付信息
		String paymentCode=saleOrder.getPaymentcode();
		//判断总价格，是否为0，如果为0，直接更改订单各种信息
		Float totalPrice=saleOrder.getOrdermoney();
		if((totalPrice-0)>0.00000001){
			switch(paymentCode){
			case "alipay":
				request.setAttribute("WIDout_trade_no", saleOrder.getOrder_no()); // 订单号
				request.setAttribute("WIDsubject", "测试订单");                           // 订单名称
				request.setAttribute("WIDtotal_fee", totalPrice.toString());                            // 订单金额
				request.setAttribute("WIDbody", "测试订单描述");                           // 订单描述
				request.setAttribute("WIDshow_url", "http://test/zhucexia/order/3");   // 订单地址
			    url= "pay/alipayapi";
			    break;
			case "cash_to_delivery":
				url="";
				break;
			default: break;
		}
		}
		else{
			url="";
		}
		/*if ("alipay".equalsIgnoreCase(paymentCode)) {
			// 数据库中查询获取订单详情， 拼装支付宝支付所需参数
			request.setAttribute("WIDout_trade_no", String.valueOf(System.currentTimeMillis())); // 订单号
			request.setAttribute("WIDsubject", "测试订单");                           // 订单名称
			request.setAttribute("WIDtotal_fee", "0.01");                            // 订单金额
			request.setAttribute("WIDbody", "测试订单描述");                           // 订单描述
			request.setAttribute("WIDshow_url", "http://test/zhucexia/order/3");   // 订单地址
			
			return "pay/alipayapi";
		} else {
		// 货到付款	
			return "";
		}*/
		return url;
	}
	
	/*查询所有的支付方式*/
	public String getPayMethod(){
		List<PaymentPo> list=paymentService.getPayMethod();
		return "";
	}
	
}
