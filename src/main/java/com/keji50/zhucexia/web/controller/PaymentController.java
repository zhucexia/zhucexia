package com.keji50.zhucexia.web.controller;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/payment")
public class PaymentController {

	@RequestMapping(value = "/pay", method = RequestMethod.GET)
	public String pay(HttpServletRequest request, HttpServletResponse response) {
		String orderId = request.getParameter("orderId");
		String paymentCode = request.getParameter("paymentCode");
		
		// 检查订单是否是未支付状态， 是否过期
		
		// 更新订单的支付信息
		
		// 支付宝支付
		if ("alipay".equalsIgnoreCase(paymentCode)) {
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
		}
	}
	
}
