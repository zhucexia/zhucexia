package com.keji50.zhucexia.dao.mapper;

import java.util.List;

import com.keji50.zhucexia.dao.po.PaymentPo;

public interface PaymentPoMapper {

	public List<PaymentPo> getPayMethod();

	public PaymentPo getPayMethodById(String id);
	
	public PaymentPo getPaymentById(String id);

	public PaymentPo queryByCode(String code);

}
