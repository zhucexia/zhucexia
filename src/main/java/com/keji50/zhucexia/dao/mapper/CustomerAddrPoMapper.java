package com.keji50.zhucexia.dao.mapper;

import com.keji50.zhucexia.dao.po.CustomerAddrPo;

public interface CustomerAddrPoMapper {
	
	int insert (CustomerAddrPo customerAddr);

	public CustomerAddrPo query(int i);

	public CustomerAddrPo getAddr(int addrId);

	public int updateDefaultAddr();


}
