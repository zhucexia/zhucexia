package com.keji50.zhucexia.service;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public List<GoodPo> newdetailgood(){
		return goodPoMapper.newdetailgood();
	}

	public List<HashMap<String, Object>> goodsdetail(int id) {
		// TODO Auto-generated method stub
		return goodPoMapper.goodsdetail(id);
	}
    
	/*获取单个商品信息*/
	public Map<String, Object> getGood(String id) {
		return goodPoMapper.getGood(id);
	}
   /*获取单个商品的配置的商品的信息*/
	public List<Map<String, Object>> getRelationGood(String id) {
		return goodPoMapper.getRelationGood(id);
	}
  /*获取所有商品的配置关系*/
	public List<Map<String,Object>> getRelations(){
		return goodPoMapper.getRelations();
	}
	
	


}
