package com.keji50.zhucexia.dao.mapper;

import com.keji50.zhucexia.dao.po.CustomerPo;

public interface CustomerPoMapper {
	CustomerPo login(CustomerPo c);

	CustomerPo validate(CustomerPo c);

	CustomerPo validatephone(CustomerPo c);

	int insertreg(CustomerPo cust);
	
}
