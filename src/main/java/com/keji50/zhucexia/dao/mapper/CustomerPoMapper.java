package com.keji50.zhucexia.dao.mapper;

import com.keji50.zhucexia.dao.po.CustomerPo;

public interface CustomerPoMapper {
	CustomerPo login(CustomerPo c);

	CustomerPo validate(CustomerPo c);

	CustomerPo validatephone(CustomerPo c);

	int insertreg(CustomerPo cust);

	CustomerPo validatelost(CustomerPo c);

	int updatepass(CustomerPo c);
	
	int setBaseDate(CustomerPo customerPo);
	
	String getPwdByUserName(String userName);
	
	int updatePwd(CustomerPo customerPo);
	
	int bingdMobile(CustomerPo customerPo);
}	
