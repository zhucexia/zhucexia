package com.keji50.zhucexia.web.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@ResponseBody
	public String AddAddre (HttpServletRequest request){	
		System.out.println("111111111111111111111111111111");
		/*添加收获地址----*/
		CustomerAddrPo customerAddrPo = new CustomerAddrPo();
		/*获取用户的id值*/
		CustomerPo customerPo= (CustomerPo) request.getSession().getAttribute("customer");
		customerAddrPo.setCustomer_id(customerPo.getId());
		/*地址，包括省份，和城市*/
		String addr=request.getParameter("newProvince")+" "+request.getParameter("newCity")+" ";
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
		customerAddrPo.setIs_default("1");
		/*省份，城市，区域id值*/
		String addressId=request.getParameter("addressId");
		customerAddrPo.setAddressId(addressId);
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
	/*个人中心，地址管理*/
	@RequestMapping("/addrManage")
	public String addrManage(HttpServletRequest request){
		/*当前用户的所有地址信息*/
		CustomerPo customer=(CustomerPo) request.getSession().getAttribute("customer");
		int id=customer.getId();
		List<CustomerAddrPo> list = customerAddrService.queryList(id);
		request.setAttribute("list", list);
		return "addressManage";
	}
	
	/*被选中的收货地址的详细信息*/
	@RequestMapping("queryAddre")
	@ResponseBody
	public String queryAddr(HttpServletRequest request){
		String id=request.getParameter("id");
		CustomerAddrPo customerAddr=customerAddrService.getAddr(Integer.parseInt(id));
		String[] strAddress=customerAddr.getAddress().split(" ");
		String[] ids=customerAddr.getAddressId().split(",");
		String str="{'id':'"+customerAddr.getId()+"','customer_id':'"+customerAddr.getCustomer_id()+"','name':'"+customerAddr.getName()+"',"
				+ "'phone_number':'"+customerAddr.getPhoneNumber()+"','province':'"+strAddress[0]+"','citys':'"+strAddress[1]+"',"
						+ "'zipcode':'"+customerAddr.getZip_code()+"','remark':'"+customerAddr.getRemark()+"',"
								+ "'street':'"+customerAddr.getStreet()+"','areaRegion':'"+customerAddr.getAreaRegion()+"',"
										+ "'telephone':'"+customerAddr.getTelephone()+"','provinceId':'"+ids[0]+"',"
												+ "'cityId':'"+ids[1]+"','areaId':'"+ids[2]+"'}";
/*		String str="{customer_id:"+customerAddr.getCustomer_id()+",name:"+customerAddr.getName()+","
				+ "phone_number:"+customerAddr.getPhoneNumber()+",province:"+strAddress[0]+",citys:"+strAddress[1]+","
						+ "zip_code:"+customerAddr.getZip_code()+",remark:"+customerAddr.getRemark()+","
								+ "street:"+customerAddr.getStreet()+",areaRegion:"+customerAddr.getAreaRegion()+","
										+ "telephone:"+customerAddr.getTelephone()+",provinceId:"+ids[0]+","
												+ "cityId:"+ids[1]+",areaId:"+ids[2]+"}";*/
	    System.out.println("进入了queryAddr方法--"+str);
		return str;
		
	}
	
	@RequestMapping("/updateAddre")
	@ResponseBody
	public String updateAddre (HttpServletRequest request){	
		System.out.println("111111111111111111111111111111");
		/*添加收获地址----*/
		CustomerAddrPo customerAddrPo = new CustomerAddrPo();
		/*获取用户的id值*/
		CustomerPo customerPo= (CustomerPo) request.getSession().getAttribute("customer");
		customerAddrPo.setCustomer_id(customerPo.getId());
		/*地址，包括省份，和城市*/
		String addr=request.getParameter("newProvince")+" "+request.getParameter("newCity")+" ";
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
		/*省份，城市，区域id值*/
		String addressId=request.getParameter("addressId");
		customerAddrPo.setAddressId(addressId);
		/*id值*/
		String ids=request.getParameter("id");
		customerAddrPo.setId(Integer.parseInt(ids));
		System.out.println(customerAddrPo.toString());
		int flag=customerAddrService.update(customerAddrPo);
		System.out.println(customerAddrPo.toString());
		/*添加收货地址结束------*/
		if(flag>0){
			return "{message:"+flag+"}";
		}
		else{
			return "{message:false}";
		}
	}
	
	/*设置为默认地址*/
	@RequestMapping("setIsDefault")
	@ResponseBody
	public String setIsDefault(HttpServletRequest request){
		String id=request.getParameter("id");
		int flag=customerAddrService.setIsDefault(id);
		if(flag>0){
			return "{message:true}";
		}
		else{
			return "{message:false}";
		}
	}
	/*删除地址信息*/
	@RequestMapping("/delAddr")
	@ResponseBody
	public String delAddr(HttpServletRequest request){
		String id=request.getParameter("id");
		int flag=customerAddrService.delAddr(id);
		/*添加收货地址结束------*/
		if(flag>0){
			return "{message:true}";
		}
		else{
			return "{message:true}";
		}
	}
}
