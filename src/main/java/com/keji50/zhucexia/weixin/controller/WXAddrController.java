package com.keji50.zhucexia.weixin.controller;



import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	/*修改地址信息页面*/
	@RequestMapping("/toUpdateAddr")
	public String toUpdateAddr(HttpServletRequest request){
		String id=request.getParameter("id");
		CustomerAddrPo addrPo=WXAddr.toUpdateAddrs(Integer.parseInt(id));
		request.setAttribute("addrPo", addrPo);
		request.setAttribute("flag", "1");
		return "weixinpage/updateAddr";	
	}
	/*修改地址信息,修改成功后返回到地址管理页面*/
	@RequestMapping("/updateAddr")
	public String updateAddr(HttpServletRequest request,CustomerAddrPo addrPo){
		/*省，城，区，都存在address字段中，要把字段分隔，把区存入到areaRegion中*/
		String address=addrPo.getAddress();
		String areaRegion =address.split(" ")[2];
		String addr=address.split(" ")[0]+" "+address.split(" ")[1];
		addrPo.setAddress(addr);
		addrPo.setAreaRegion(areaRegion);
		/*获取当前的用户信息*/
		CustomerPo customer=(CustomerPo) request.getSession().getAttribute("customer");
		List<CustomerAddrPo> list=WXAddr.updateAddr(addrPo,customer.getId());
		request.setAttribute("list", list);
		return "weixinpage/managerAddress";
	}
	/*删除地址信息，逻辑删除*/
	@RequestMapping("/delAddr")
	public String delAddr(HttpServletRequest request,String id){
		/*获取当前的用户信息*/
		CustomerPo customer=(CustomerPo) request.getSession().getAttribute("customer");
		List<CustomerAddrPo> list=WXAddr.delAddr(customer.getId(),id);
		request.setAttribute("list", list);
		return "weixinpage/managerAddress";
	}
	/*到达添加收货地址页面*/
	@RequestMapping("toAddAddr")
	public String toAddAddr(HttpServletRequest request){
		request.setAttribute("flag", "1");
		return "weixinpage/addAddr";
	}
	/*添加地址信息，*/
	@RequestMapping("/addAddr")
	public String addAddr(HttpServletRequest request,CustomerAddrPo addrPo){
		/*获取当前用户信息*/
		CustomerPo customer=(CustomerPo) request.getSession().getAttribute("customer");
		addrPo.setCustomer_id(customer.getId());
		addrPo.setIs_default("1");
		List<CustomerAddrPo> list=WXAddr.addAddr(addrPo);
		if(list!=null){
			request.setAttribute("list", list);
			return "weixinpage/managerAddress";
		}
		else{
			return "";
		}
		
	}
}
