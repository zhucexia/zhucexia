package com.keji50.zhucexia.service;



import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.GoodPoMapper;
import com.keji50.zhucexia.dao.po.GoodPo;

@Service(value = "goodService")
public class GoodService {
	
	@Resource(name = "goodPoMapper")
	private GoodPoMapper goodPoMapper;

	/*public CustomerPo login(String username, String password) {
		// TODO Auto-generated method stub
		Map<String,Object> hash=new HashMap<String,Object>();
		hash.put("username", username);
		hash.put("password", password);	
		System.out.println(hash);
		CustomerPo customer=customerPoMapper.login(hash);
		return customer;
	}*/

	public List<GoodPo> showindexgood() {
		// TODO Auto-generated method stub
		return goodPoMapper.showindexgood();
	}

	public List<GoodPo> showindexserver() {
		// TODO Auto-generated method stub
		return goodPoMapper.showindexserver();
	}

	public List<GoodPo> showdetailgood() {
		// TODO Auto-generated method stub
		return goodPoMapper.showdetailgood();
	}

	public List<GoodPo> showdetailserver() {
		// TODO Auto-generated method stub
		return goodPoMapper.showdetailserver();
	}

	public List<HashMap<String, Object>> goodsdetail(int id) {
		// TODO Auto-generated method stub
		return goodPoMapper.goodsdetail(id);
	}

}
