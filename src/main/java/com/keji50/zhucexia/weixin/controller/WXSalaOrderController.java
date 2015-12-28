package com.keji50.zhucexia.weixin.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.keji50.zhucexia.dao.po.CustomerAddrPo;
import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.dao.po.PaymentPo;
import com.keji50.zhucexia.dao.po.SalaOrderPo;
import com.keji50.zhucexia.dao.po.SaleOrderDetailPo;
import com.keji50.zhucexia.service.CustomerAddressService;
import com.keji50.zhucexia.service.GoodService;
import com.keji50.zhucexia.service.PaymentService;
import com.keji50.zhucexia.service.SaleOrderService;
import com.keji50.zhucexia.web.weixin.service.WXGoodService;
import com.keji50.zhucexia.web.weixin.service.WXSaleOrderService;

@Controller
@RequestMapping(value = "/wxsales")
public class WXSalaOrderController {
	@Resource(name="wxsaleOrderService")
	private WXSaleOrderService wxsaleOrderService;
	@Resource(name="wxgoodService")
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
}
