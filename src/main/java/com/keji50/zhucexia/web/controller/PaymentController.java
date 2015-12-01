package com.keji50.zhucexia.web.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.keji50.zhucexia.dao.po.CustomerAddrPo;
import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.dao.po.PaymentPo;
import com.keji50.zhucexia.dao.po.SalaOrderPo;
import com.keji50.zhucexia.service.CustomerAddressService;
import com.keji50.zhucexia.service.PaymentService;
import com.keji50.zhucexia.service.SaleOrderService;

@Controller
@RequestMapping(value = "/payment")
public class PaymentController {
    @Resource(name="paymentService")
    private   PaymentService  paymentService;
	@Resource(name="saleOrderService")
	private SaleOrderService saleOrderService;
	@Resource(name="customerAddressService")
	private CustomerAddressService customerAddresService;
	
	@RequestMapping(value = "/pay", method = RequestMethod.POST)
	public String pay(HttpServletRequest request, HttpServletResponse response) throws DataAccessException, ParseException {
	     /*获取地址id值*/
		String addrId=request.getParameter("addrId");
		String url="";
		String orderId = request.getParameter("orderId");
         //根据orderid获取订单信息
         SalaOrderPo saleOrder = saleOrderService.getOrder(Integer.parseInt(orderId));
        //地址id设置
         saleOrder.setAddress(addrId);
		// 检查订单是否是未支付状态， 是否过期(一个月未期限)
		String payment_state=saleOrder.getPaymentstate();
		Date date=new Date();
		//订单创建时间
		Date dateBulid=saleOrder.getOrderstatetime();
		dateBulid.setMonth(dateBulid.getMonth()+1);
		/*订单状态为未支付，并且没有超过一月的失效期*/
		if(payment_state.equals("0")&&date.compareTo(dateBulid)<0){
			// 更新订单的支付信息
			String paymentCode=request.getParameter("Checkout[pay_id]");
			/*通难过*支付方式编号，查询支付方式的id值*/
			PaymentPo paymentPo=paymentService.queryByCode(paymentCode);
			/*更新订单地址信息*/
				//根据订单id，查询地址信息
				CustomerAddrPo customerAddrPo = customerAddresService.getAddr(Integer.parseInt(addrId));
				//设置订单的地址id，设置订单的联系电话，订单的邮政编码,更新订单地址信息
				saleOrder.setTelephone(customerAddrPo.getTelephone());
				saleOrder.setZipcode(customerAddrPo.getZip_code());
				saleOrder.setPaymentcode(paymentCode);
				saleOrder.setPaymentid(paymentPo.getId());
				saleOrder.setPaymentname(paymentPo.getName());
				saleOrderService.updateAddr(saleOrder);
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
				case "cash_on_delivery":
					saleOrderService.update(saleOrder.getOrder_no(), "1", null);
					request.setAttribute("order_no", saleOrder.getOrder_no());
					url="success1";
					break;
				default: break;
			}
			}
			else{
				saleOrderService.update(saleOrder.getOrder_no(), "0.00", null);
				request.setAttribute("order_no", saleOrder.getOrder_no());
				url="success";
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
		}
		return url;
	}
	
	/*查询所有的支付方式*/
	public String getPayMethod(){
		List<PaymentPo> list=paymentService.getPayMethod();
		return "";
	}
	
	/*支付宝返回结果*/
	@RequestMapping("/return")
	public void returnUrl(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		RequestDispatcher rd = request.getRequestDispatcher("../views/pay/return_url.jsp");
		rd.forward(request, response);
	}
	
	@RequestMapping("/notify")
	public void notifyUrl(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		RequestDispatcher rd = request.getRequestDispatcher("../views/pay/notify_url.jsp");
		rd.forward(request, response);
	}
	
}
