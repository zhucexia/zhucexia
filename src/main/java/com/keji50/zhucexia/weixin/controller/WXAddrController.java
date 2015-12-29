package com.keji50.zhucexia.weixin.controller;



import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.keji50.zhucexia.dao.po.CustomerAddrPo;
import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.service.weixin.WXAddrService;

@Controller
@RequestMapping("/WXAddr")
public class WXAddrController {
	@Resource(name="WXAddrService")
	private WXAddrService WXAddr;
	
	/*查询所有的地址信息*/
	@RequestMapping("/toManageAddr")
	private String toManageAddr(HttpServletRequest request){
		/*获取当前用户的信息*/
		CustomerPo customer=(CustomerPo) request.getSession().getAttribute("customer");
		List<CustomerAddrPo> list =WXAddr.getAddrs(customer.getId());
		request.setAttribute("list", list);
		return "weixinpage/managerAddress";
	}
	
}
