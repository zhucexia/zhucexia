package com.keji50.zhucexia.service.weixin;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.CustomerPoMapper;
import com.keji50.zhucexia.dao.po.CustomerPo;

@Service("WXUserService")
public class WXUserService {
	
	@Resource(name="customerPoMapper")
	private CustomerPoMapper customerPoMapper;
	
	public CustomerPo loginResult(String mobile,String password){
		int i = 0;
		CustomerPo cust = new CustomerPo();
		cust.setMobile(mobile);
		cust.setPassword(password);
		return customerPoMapper.login(cust);
	}
	
	public CustomerPo validatephone(CustomerPo c){
		CustomerPo customer=customerPoMapper.validatephone(c);
		return customer;
	}
	
	public int insertreg(CustomerPo cust) {
		return customerPoMapper.insertreg(cust);
	}
	
	public int updatepass(CustomerPo c) {
		return customerPoMapper.updatepass(c);
	}
}
