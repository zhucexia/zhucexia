package com.keji50.zhucexia.dao.mapper;

import java.util.List;

import com.keji50.zhucexia.dao.po.CustomerAddrPo;

public interface CustomerAddrPoMapper {
	
	int insert (CustomerAddrPo customerAddr);

	public CustomerAddrPo query(int i);

	public CustomerAddrPo getAddr(int addrId);


	public int updateDefaultAddr();

	public List<CustomerAddrPo> queryList(int id);

	public int update(CustomerAddrPo customerAddrPo);

	public int isDefaultById(String id);

	public int delAddr(String id);
	



}
