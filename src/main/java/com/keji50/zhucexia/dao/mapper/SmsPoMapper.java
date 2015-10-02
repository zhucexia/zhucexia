package com.keji50.zhucexia.dao.mapper;

import com.keji50.zhucexia.dao.po.SmsPo;

public interface SmsPoMapper {
	
	int insert(SmsPo sms);
	
	SmsPo selectById(int id, String mobile);
}
