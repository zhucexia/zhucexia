package com.keji50.zhucexia.service;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.SaleOrderDetailPoMapper;
import com.keji50.zhucexia.dao.po.SaleOrderDetailPo;

@Service(value="saleOrderDetailService")
public class SaleOrderDetailService {
	@Resource(name="saleOrderDetailPoMapper")
	private SaleOrderDetailPoMapper saleOrderDetailPoMapper;
	public List<Map<String, Object>> querryDetails(int id) {
		return saleOrderDetailPoMapper.querryDetails( id);
	}
	
	public SaleOrderDetailPo getOrderDetail(int id){
		return saleOrderDetailPoMapper.getOrderDetail(id);
	}
	
}
