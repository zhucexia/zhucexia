package com.keji50.zhucexia.web.controller;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.keji50.zhucexia.dao.po.CustomerAddrPo;
import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.dao.po.PaymentPo;
import com.keji50.zhucexia.dao.po.SalaOrderPo;
import com.keji50.zhucexia.service.CustomerAddressService;
import com.keji50.zhucexia.service.GoodService;
import com.keji50.zhucexia.service.PaymentService;
import com.keji50.zhucexia.service.SaleOrderDetailService;
import com.keji50.zhucexia.service.SaleOrderService;

/**
 * 
 * @author hc
 *
 */

@Controller
@RequestMapping(value = "/details")
public class SaleOrderDetailController {
	@Resource(name="saleOrderDetailService")
	private SaleOrderDetailService saleOrderDetailService;
	@Resource(name="saleOrderService")
	private SaleOrderService saleOrderService;
	@Resource(name="customerAddressService")
	private CustomerAddressService customerAddressService;
	@Resource(name="paymentService")
	private PaymentService paymentService;
	
	/*查询订单详情*/
	@RequestMapping("/querryOrderDetail")
	public String querryOrderDetail(HttpServletRequest request){
		/*获取当前登录用户的信息*/
		CustomerPo customer=(CustomerPo) request.getSession().getAttribute("customer");
		String id=request.getParameter("id");
		/*由id查询订单信息*/
		SalaOrderPo saleOrder=saleOrderService.getOrder(Integer.parseInt(id));
		/*查询用户的收货地址的信息*/
		String addressId=saleOrder.getAddress();
		/*判断地址是否为空
		 *1.不为空则以addressId为条件查询地址信息
		 *2.为空则查询该用户是否存在默认地址
		 * */
		CustomerAddrPo customerAddr=null;
		if(addressId!=null){
		 customerAddr=customerAddressService.getAddr(Integer.parseInt(saleOrder.getAddress()));
		}
		else{
			customerAddr=customerAddressService.query(customer.getId());
		}
		/*查询订单详情*/
		Map<String,Object> maps= new HashMap<String,Object>();
		List<Map<String,Object>> list=saleOrderDetailService.querryDetails(Integer.parseInt(id));
		for(int i=0;i<list.size();i++){
			Map<String,Object> map=new HashMap<String,Object>();
			map=list.get(i);
			maps.put(map.get("id").toString(), map);
			
		}
		/*查询已存在的支付方式*/
		List<PaymentPo> lists=paymentService.getPayMethod();
		/*返回数据到页面*/
		request.setAttribute("list", lists);
		request.setAttribute("chooseGood", maps);
		request.setAttribute("customerAddr", customerAddr);
		request.setAttribute("saleOrder", saleOrder);
		return "orderDetail";
	}

}
