package com.keji50.zhucexia.service.weixin;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.CustomerAddrPoMapper;
import com.keji50.zhucexia.dao.po.CustomerAddrPo;


@Service("WXAddrService")
public class WXAddrService {
	
	@Resource(name="customerAddrPoMapper")
	private CustomerAddrPoMapper customerAddrPoMapper;
	
   public List<CustomerAddrPo> getAddrs(int id){	
	   return (List<CustomerAddrPo>) customerAddrPoMapper.queryList(id);
   }
}
