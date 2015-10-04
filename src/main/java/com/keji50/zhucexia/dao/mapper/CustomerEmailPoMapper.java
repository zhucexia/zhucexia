package com.keji50.zhucexia.dao.mapper;

import com.keji50.zhucexia.dao.po.CustomerEmailPo;
import org.apache.ibatis.annotations.Param;

public interface CustomerEmailPoMapper {

	int insert(CustomerEmailPo email);

	CustomerEmailPo selectById(@Param("id") int id, @Param("type") String type);
}
