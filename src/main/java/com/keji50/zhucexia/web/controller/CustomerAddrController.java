package com.keji50.zhucexia.web.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.keji50.zhucexia.dao.po.CustomerAddrPo;
import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.service.CustomerAddressService;

@Controller
@RequestMapping("/user")
public class CustomerAddrController {
	@Resource(name="customerAddressService")
	private CustomerAddressService customerAddrService; 
	/*添加一个收货地址*/
	@RequestMapping("/AddAddre")
	public String AddAddre (HttpServletRequest request){	
		/*添加收获地址----*/
		CustomerAddrPo customerAddrPo = new CustomerAddrPo();
		/*获取用户的id值*/
		CustomerPo customerPo= (CustomerPo) request.getSession().getAttribute("customer");
		customerAddrPo.setCustomer_id(customerPo.getId());
		/*地址，包括省份，和城市*/
		String addr=request.getParameter("newAddress[province]")+request.getParameter("newAddress[city]");
		customerAddrPo.setAddress(addr);
		/*地址地区*/
		String area=request.getParameter("newAddress[district]");
		customerAddrPo.setAreaRegion(area);
		/*街道*/
		String street=request.getParameter("newAddress[address]");
		customerAddrPo.setStreet(street);
		/*邮政编码*/
		String zip_code = request.getParameter("newAddress[zipcode]");
		customerAddrPo.setZip_code(zip_code);
		/*电话号*/
		String mobile=request.getParameter("newAddress[tel]");
		customerAddrPo.setTelephone(mobile);
		/*收货人*/
		String names=request.getParameter("newAddress[consignee]");
		customerAddrPo.setName(names);
		/*备注说明*/
		String remark=request.getParameter("newAddress[tag_name]");
		customerAddrPo.setRemark(remark);
		int flag=customerAddrService.insert(customerAddrPo);
		/*添加收货地址结束------*/
		return "/user/addAdress";	
	}
}
