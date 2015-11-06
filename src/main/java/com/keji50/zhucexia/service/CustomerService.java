package com.keji50.zhucexia.service;


import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;









import com.keji50.zhucexia.dao.mapper.CustomerEmailPoMapper;
import com.keji50.zhucexia.dao.mapper.CustomerPoMapper;
import com.keji50.zhucexia.dao.po.CustomerEmailPo;
import com.keji50.zhucexia.dao.po.CustomerPo;

@Service(value = "customerService")
public class CustomerService {
	
	@Resource(name = "customerPoMapper")
	private CustomerPoMapper customerPoMapper;
	@Resource(name = "customerEmailPoMapper")
	private CustomerEmailPoMapper customerEmailPoMapper;

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
	
	public int setBaseDate(CustomerPo customerPo){
		
		return customerPoMapper.setBaseDate(customerPo);
	}
	
	public String getPwdByUserName(String userName){
		String password = customerPoMapper.getPwdByUserName(userName);
		return password;
	}
	
	public int updatePwd(CustomerPo customerPo){
		return customerPoMapper.updatePwd(customerPo);
	}
	
	public int bindMobile(CustomerPo customerPo){
		return customerPoMapper.bingdMobile(customerPo);
	}
	
	public int bindEmail(String email, int id){
		return customerPoMapper.bindEmail(email,id);
	}
	
	public int delEmail(int id){
		return customerPoMapper.delEmail(id);
	}
	
	public CustomerPo selectById(int id){
		return customerPoMapper.selectById(id);
	}
	
	public Boolean selectByEmail(String email){
		Boolean flag=customerPoMapper.selectByEmail(email)==null;
		return flag;
	}
}
