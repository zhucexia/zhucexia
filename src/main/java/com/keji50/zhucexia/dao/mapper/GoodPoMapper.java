package com.keji50.zhucexia.dao.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.keji50.zhucexia.dao.po.GoodPo;

public interface GoodPoMapper {
	
	List<GoodPo> showindexgood();

	List<GoodPo> showindexserver();

	List<GoodPo> showdetailgood();

	List<GoodPo> showdetailserver();

	List<HashMap<String, Object>> goodsdetail(int id);

	public Map<String, Object> getGood(String id);

	public List<Map<String, Object>> getRelationGood(String id);

	public List<Map<String, Object>> getRelations();
	
}
