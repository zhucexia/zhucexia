package com.keji50.zhucexia.dao.mapper;

import com.keji50.zhucexia.dao.po.CustomerSmsPo;

public interface SmsPoMapper {
	
	int insert(CustomerSmsPo sms);
	
	CustomerSmsPo selectById(int id, String mobile);
}
