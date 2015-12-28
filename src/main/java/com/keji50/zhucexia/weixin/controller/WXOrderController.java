package com.keji50.zhucexia.weixin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.service.weixin.WXOrderService;

@Controller
@RequestMapping("/WXOrder")
public class WXOrderController {
	
	@Resource(name="WXOrderService")
	private WXOrderService orderService;
	
	@RequestMapping("/orderManage")
	public String totalOrder(HttpServletRequest request,HttpServletResponse response){
		CustomerPo customer = (CustomerPo)request.getSession().getAttribute("customer");
		int customerId=customer.getId();
		String types = request.getParameter("state");
		if(types==null){
			types="0";
		}
		Map<String,Object> maps=new HashMap<String,Object>();
		maps.put("types",types);
		maps.put("customerid", customerId);
		List<HashMap<String,Object>> list=orderService.querryOrders(maps);
		request.setAttribute("list", list);
		request.setAttribute("types", types);
		return "weixinpage/order";
	}
}
