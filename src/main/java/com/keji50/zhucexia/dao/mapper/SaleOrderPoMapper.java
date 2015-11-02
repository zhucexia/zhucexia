package com.keji50.zhucexia.dao.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.keji50.zhucexia.dao.po.SalaOrderPo;

public interface SaleOrderPoMapper {

	
	public int bulidOrder(SalaOrderPo saleOrder);

	public SalaOrderPo getOrder(int id);

	public int addOrder(SalaOrderPo saleOrder);

	public SalaOrderPo getOrderByno(String order_no);

	public int update(SalaOrderPo saleOrder);

	public int updateAddr(SalaOrderPo saleOrder);

	public List<HashMap<String, Object>> querryOrders(Map<String, Object> maps);

	public int delOrder(String id);
	public int cancleOrder(String id);
 
}
