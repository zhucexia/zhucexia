package com.keji50.zhucexia.service.weixin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.SaleOrderPoMapper;

@Service("WXOrderService")
public class WXOrderService {
	
	@Resource(name="saleOrderPoMapper")
	private SaleOrderPoMapper saleOrderPoMapper;
	
	public List<HashMap<String,Object>> querryOrders(Map<String, Object> maps) {
		return saleOrderPoMapper.querryOrders(maps);
	}
}
