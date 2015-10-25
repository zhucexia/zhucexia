package com.keji50.zhucexia.web.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.keji50.zhucexia.dao.po.CustomerAddrPo;
import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.service.CustomerAddressService;

@Controller
@RequestMapping("/address")
public class CustomerAddrController {
	@Resource(name="customerAddressService")
	private CustomerAddressService customerAddrService; 
	/*添加一个收货地址*/
	@RequestMapping("/addAddre")
	public String AddAddre (HttpServletRequest request){	
		System.out.println("111111111111111111111111111111");
		/*添加收获地址----*/
		CustomerAddrPo customerAddrPo = new CustomerAddrPo();
		/*获取用户的id值*/
		CustomerPo customerPo= (CustomerPo) request.getSession().getAttribute("customer");
		customerAddrPo.setCustomer_id(customerPo.getId());
		/*地址，包括省份，和城市*/
		String addr=request.getParameter("newProvince")+request.getParameter("newCity]");
		customerAddrPo.setAddress(addr);
		/*地址地区*/
		String area=request.getParameter("newCountry");
		customerAddrPo.setAreaRegion(area);
		/*街道*/
		String street=request.getParameter("newStreet");
		customerAddrPo.setStreet(street);
		/*邮政编码*/
		String zip_code = request.getParameter("newZipCode");
		customerAddrPo.setZip_code(zip_code);
		/*电话号*/
		String mobile=request.getParameter("newtel");
		customerAddrPo.setTelephone(mobile);
		/*收货人*/
		String names=request.getParameter("newConsignee");
		customerAddrPo.setName(names);
		/*备注说明*/
		String remark=request.getParameter("newTag");
		customerAddrPo.setRemark(remark);
		int flag=customerAddrService.insert(customerAddrPo);
		System.out.println(customerAddrPo.toString());
		/*添加收货地址结束------*/
		if(flag>0){
			return "{message:"+flag+"}";
		}
		else{
			return "{message:false}";
		}
	}
}
