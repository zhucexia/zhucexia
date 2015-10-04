package com.keji50.zhucexia.dao.mapper;

import org.apache.ibatis.annotations.Param;

import com.keji50.zhucexia.dao.po.CustomerSmsPo;

public interface CustomerSmsPoMapper {

	int insert(CustomerSmsPo sms);

	CustomerSmsPo selectById(@Param("id") int id, @Param("mobile") String mobile);
}
