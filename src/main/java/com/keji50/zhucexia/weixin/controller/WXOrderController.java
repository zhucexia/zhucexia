package com.keji50.zhucexia.weixin.controller;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.keji50.zhucexia.dao.po.CustomerAddrPo;
import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.dao.po.SalaOrderPo;
import com.keji50.zhucexia.service.weixin.WXGoodService;
import com.keji50.zhucexia.service.weixin.WXOrderService;


@Controller
@RequestMapping("/WXOrder")
public class WXOrderController {
	
	@Resource(name="WXOrderService")
	private WXOrderService orderService;
	@Resource(name="WXGoodService")
	private WXGoodService wxgoodService;
	/*订单生成页*/
	@RequestMapping("/toBookOrders")
	public String toBookOrders(String ids,HttpServletRequest request){
		/*获取被选中的套餐的id*/
		Integer id=Integer.parseInt(ids);
		/*查询被选择的套餐的内容*/
		GoodPo goodPo=wxgoodService.getOnes(id);
		request.setAttribute("goodPo", goodPo);
		return "weixinpage/bookOrders";
	}
	/*生成订单*/
	@RequestMapping("/buildOrders")
	public String buildOrders(HttpServletRequest request){
		//获取当前登录用户信息
		CustomerPo customer=new CustomerPo();
		customer=(CustomerPo) request.getSession().getAttribute("customer");
		/*获取传递的数据*/
		//省，城，区
		String area =request.getParameter("area");
		String proCity=area.split(" ")[0]+" "+area.split(" ")[0];
		String areas=area.split(" ")[2];
		//省，城，区的id值
		String areaId=request.getParameter("areaId");
		//街道地址
		String address=request.getParameter("address");
		//收货人姓名
		String consignor=request.getParameter("consignor");
		//收货人联系电话
		String telephone=request.getParameter("telephone");
		//邮编
		String zipcode=request.getParameter("zipcode");
		//产品id
		String goodId=request.getParameter("goodId");
		//商品总价格
		String order_money=request.getParameter("order_money");
		//实例化一个地址实例，
		CustomerAddrPo addrPo = new CustomerAddrPo();
		addrPo.setAddress(proCity);
		addrPo.setAreaRegion(areas);
		addrPo.setStreet(address);
		addrPo.setCustomer_id(customer.getId());
		addrPo.setZip_code(zipcode);
		addrPo.setTelephone(telephone);
		addrPo.setIs_default("1");
		addrPo.setAddressId(areaId);
		addrPo.setName(consignor);
		/*添加订单信息*/
		SalaOrderPo saleOrder=new SalaOrderPo();
		saleOrder.setCustomerid(customer.getId());
		saleOrder.setOrdermoney(Float.parseFloat(order_money));
		saleOrder.setTelephone(telephone);
		saleOrder.setZipcode(zipcode);
		Timestamp times=new Timestamp(System.currentTimeMillis());
		saleOrder.setOrderstatetime(times);
		int flag=orderService.buildOrders(saleOrder, addrPo, goodId);
		/**/
		
		return "weixinpage/payStyle";
	}
	/*订单管理中心*/
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
