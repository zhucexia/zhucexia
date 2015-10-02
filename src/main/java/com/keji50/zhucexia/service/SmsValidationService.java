package com.keji50.zhucexia.service;

import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.SmsPoMapper;
import com.keji50.zhucexia.dao.po.SmsPo;
import com.keji50.zhucexia.service.out.sms.SmsGatewayPo;
import com.keji50.zhucexia.service.out.sms.SmsGatewayService;
import com.keji50.zhucexia.service.out.sms.SmsTemplate;

@Service(value = "smsValidationService")
public class SmsValidationService {

	@Resource(name = "smsGatewayService")
	private SmsGatewayService smsGatewayService;
	
	@Resource(name = "smsPoMapper")
	private SmsPoMapper smsPoMapper;
	
	/**
	 * 
	 * @param mobile
	 * @param ip
	 * @return
	 */
	public SmsPo sendValidationSms(String mobile, String ip) {
		SmsPo sms = new SmsPo(mobile, SmsTemplate.VALIDATION_TEMPLATE.getType(), getRandomSms());
		SmsGatewayPo smsGatewayPo = smsGatewayService.sendSms(sms);
		
		if (smsGatewayPo != null && smsGatewayPo.isSuccess()) {
			sms.setValidationExpire(getValidationExpire());
			sms.setIp(ip);
			sms.setSmsId(smsGatewayPo.getSmsid());
			
			int id = smsPoMapper.insert(sms);
			if (id > 0) {
				sms.setId(id);
			}
		}
		return sms;
	} 
	
	/**
	 * 
	 * @param id
	 * @param mobile
	 * @param content
	 * @return
	 */
	public int validateSms(int id, String mobile, String content) {
		SmsPo sms = smsPoMapper.selectById(id, mobile);
		if (sms == null) {
			return -1;
		}
		
		if (!sms.getContent().equals(content)) {
			return -1;
		}
		
		if (new Date().compareTo(sms.getValidationExpire()) > 0) {
			return -2;
		}
		
		return 0;
	}
	
	private String getRandomSms() {
		int random = (int) Math.random() * 9999;
		return String.valueOf(random);
	}
	
	private Date getValidationExpire() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MINUTE, 3); // expire in 3 minutes
		return calendar.getTime();
	}
}
