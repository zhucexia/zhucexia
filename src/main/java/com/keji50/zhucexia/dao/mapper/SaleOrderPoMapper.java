package com.keji50.zhucexia.dao.mapper;

import java.util.Map;

import com.keji50.zhucexia.dao.po.SalaOrderPo;

public interface SaleOrderPoMapper {

	
	public int bulidOrder(SalaOrderPo saleOrder);

	public SalaOrderPo getOrder(int id);
 
}
