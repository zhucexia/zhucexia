package com.keji50.zhucexia.dao.mapper;

import java.util.List;
import java.util.Map;

import com.keji50.zhucexia.dao.po.SaleOrderDetailPo;

public interface SaleOrderDetailPoMapper {

	public int inserts(List<SaleOrderDetailPo> list);

	public SaleOrderDetailPo getOrderDetail(int id);

	public List<Map<String, Object>> querryDetails(int id);

}
