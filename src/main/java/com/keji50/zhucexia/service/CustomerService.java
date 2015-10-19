package com.keji50.zhucexia.service;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;






import com.keji50.zhucexia.dao.mapper.CustomerPoMapper;
import com.keji50.zhucexia.dao.po.CustomerPo;

@Service(value = "customerService")
public class CustomerService {
	
	@Resource(name = "customerPoMapper")
	private CustomerPoMapper customerPoMapper;

	/*public CustomerPo login(String username, String password) {
		// TODO Auto-generated method stub
		Map<String,Object> hash=new HashMap<String,Object>();
		hash.put("username", username);
		hash.put("password", password);	
		System.out.println(hash);
		CustomerPo customer=customerPoMapper.login(hash);
		return customer;
	}*/

	public CustomerPo login(CustomerPo c) {
		// TODO Auto-generated method stub
		CustomerPo customer=customerPoMapper.login(c);
		return customer;
	}

	public CustomerPo validate(CustomerPo c) {
		// TODO Auto-generated method stub
		CustomerPo customer=customerPoMapper.validate(c);
		return customer;
	}

	public CustomerPo validatephone(CustomerPo c) {
		// TODO Auto-generated method stub
		CustomerPo customer=customerPoMapper.validatephone(c);
		return customer;
	}

	public int insertreg(CustomerPo cust) {
		// TODO Auto-generated method stub
		int result=customerPoMapper.insertreg(cust);
		return result;
	}

	public CustomerPo validatelost(CustomerPo c) {
		// TODO Auto-generated method stub
		CustomerPo customer=customerPoMapper.validatelost(c);
		return customer;
	}

	public int updatepass(CustomerPo c) {
		// TODO Auto-generated method stub
		return customerPoMapper.updatepass(c);
	}
	



}
