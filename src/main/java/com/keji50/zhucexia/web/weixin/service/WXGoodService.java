package com.keji50.zhucexia.web.weixin.service;
import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.GoodPoMapper;
import com.keji50.zhucexia.dao.po.GoodPo;

@Service(value = "wxgoodService")
public class WXGoodService {
	
	@Resource(name = "goodPoMapper")
	private GoodPoMapper goodPoMapper;

	/*某个套餐内容*/
	public  GoodPo getOnes(int id) {
		return goodPoMapper.getGoodById(id);
		
	}
}
