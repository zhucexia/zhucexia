package com.keji50.zhucexia.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.CustomerAddrPoMapper;
import com.keji50.zhucexia.dao.po.CustomerAddrPo;

@Service(value = "customerAddressService")
public class CustomerAddressService {
	@Resource(name="customerAddrPoMapper")
	private CustomerAddrPoMapper customerAddrPoMapper;
	public CustomerAddrPo query(int i) {
		return customerAddrPoMapper.query(i);
	}
	public int insert(CustomerAddrPo customerAddrPo) throws RuntimeException{
		//修改已有的其他的地址为非默认地址
		int updateFlag=customerAddrPoMapper.updateDefaultAddr();
		System.out.println("updateFlag-----"+updateFlag);
		if(updateFlag>=0){
			int flag=customerAddrPoMapper.insert(customerAddrPo);
			if(flag>0){
				return customerAddrPo.getId();
			}
			else{
				throw new RuntimeException();
			}
	    }
		else{
			throw new RuntimeException();
		}
	}
  public CustomerAddrPo getAddr(Integer id){
	  return customerAddrPoMapper.getAddr(id);
  }
public List<CustomerAddrPo> queryList(int id) {
	return customerAddrPoMapper.queryList(id);
}
public int update(CustomerAddrPo customerAddrPo) {
	int flag=customerAddrPoMapper.update(customerAddrPo);
	if(flag>0){
		return customerAddrPo.getId();
	}
	else{
		throw new RuntimeException();
	}
}
public int setIsDefault(String id) throws RuntimeException {
	/*取消之前的默认地址*/
	//修改已有的其他的地址为非默认地址
	int updateFlag=customerAddrPoMapper.updateDefaultAddr();
	System.out.println("updateFlag-----"+updateFlag);
	if(updateFlag>=0){
		int flag=customerAddrPoMapper.isDefaultById(id);
		if(flag>0){
			return flag ;
		}
		else{
			throw new RuntimeException();
		}
    }
	else{
		throw new RuntimeException();
	}	
}
public int delAddr(String id) throws RuntimeException {
	/*添加收货地址结束------*/
	int flag=customerAddrPoMapper.delAddr(id);
	if(flag>0){
		return flag ;
	}
	else{
		throw new RuntimeException();
	}
}

}
