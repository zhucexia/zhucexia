package com.keji50.zhucexia.service.weixin;

import java.util.List;

import javax.annotation.Resource;
import javax.management.RuntimeErrorException;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.CustomerAddrPoMapper;
import com.keji50.zhucexia.dao.po.CustomerAddrPo;


@Service("WXAddrService")
public class WXAddrService {
	
	@Resource(name="customerAddrPoMapper")
	private CustomerAddrPoMapper customerAddrPoMapper;
	
	/*查询所有地址信息，以当前登录用的id作为参数*/
   public List<CustomerAddrPo> getAddrs(int id){	
	   return (List<CustomerAddrPo>) customerAddrPoMapper.queryList(id);
   }
   /*到达修改地址信息页面，查询选择地址的所有信息
    * param:id ,地址id
    * */
   public CustomerAddrPo toUpdateAddrs(int id){
	   CustomerAddrPo addrPo=customerAddrPoMapper.getAddr(id);
	   return addrPo;
   }
   /*修改地址信息，*/
   public List<CustomerAddrPo> updateAddr(CustomerAddrPo addrPo,int id) throws DataAccessException{
	   int flag=customerAddrPoMapper.update(addrPo);
	   if(flag>0){
		   return (List<CustomerAddrPo>) customerAddrPoMapper.queryList(id);
	   }
	   else{
		   throw new RuntimeException();
	   }
	   
   }
   /*
    * param pareseInt,用户的id
    * param id 地址id
    * */
public List<CustomerAddrPo> delAddr(int parseInt, String id) throws DataAccessException {
	int flag=customerAddrPoMapper.delAddr(id);
	 if(flag>0){
		   return (List<CustomerAddrPo>) customerAddrPoMapper.queryList(parseInt);
	   }
	   else{
		   throw new RuntimeException();
	   }
}
/*添加地址信息，把当前新添加的地址设置为默认地址*/
public List<CustomerAddrPo> addAddr(CustomerAddrPo addrPo) throws DataAccessException{
	/*设置其他的地址为非默认地址*/
	int flag=customerAddrPoMapper.updateDefaultAddr();
	if(flag>0){
		int flags=customerAddrPoMapper.insert(addrPo);
		if(flags>0){
			int ids=addrPo.getCustomer_id();
			return (List<CustomerAddrPo>) customerAddrPoMapper.queryList(ids);
		}
		else{
			throw new RuntimeException();
		}
	}
	else{
		throw new RuntimeException();
	}
}
}
