package com.keji50.zhucexia.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.PaymentPoMapper;
import com.keji50.zhucexia.dao.po.PaymentPo;

@Service(value="paymentService")
public class PaymentService {
	@Resource(name="paymentPoMapper")
	private PaymentPoMapper paymentPoMapper;
	/*查询所有支付方式*/
	public List<PaymentPo> getPayMethod() {
		return paymentPoMapper.getPayMethod();
	}
	
	/*以id作为条件查询支付方式信息*/
	public PaymentPo getPayMethodById(String id){
		return paymentPoMapper.getPayMethodById(id);
	}

}
