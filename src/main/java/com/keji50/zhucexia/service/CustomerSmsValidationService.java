package com.keji50.zhucexia.service;

import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.SmsPoMapper;
import com.keji50.zhucexia.dao.po.CustomerSmsPo;
import com.keji50.zhucexia.service.out.sms.SmsGatewayPo;
import com.keji50.zhucexia.service.out.sms.SmsGatewayService;
import com.keji50.zhucexia.service.out.sms.SmsTemplate;

@Service(value = "customerSmsValidationService")
public class CustomerSmsValidationService {

	@Resource(name = "smsGatewayService")
	private SmsGatewayService smsGatewayService;

	@Resource(name = "smsPoMapper")
	private SmsPoMapper smsPoMapper;

	/**
	 * 发送验证短信
	 * 
	 * @param mobile
	 *            手机号
	 * @param ip
	 *            ip地址
	 * @return 短信对象， 包括当前短信id
	 */
	public CustomerSmsPo sendValidationSms(String mobile, String ip) {
		CustomerSmsPo sms = new CustomerSmsPo(mobile, SmsTemplate.VALIDATION_TEMPLATE.getType(), getRandomValidationCode());
		// 调用短信网关发送验证短信
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
	 * 验证短信验证码是否正确
	 * 
	 * @param id
	 *            当前短信验证码id
	 * @param mobile
	 *            手机号
	 * @param validationCode
	 *            验证码内容
	 * @return 验证是否成功 0成功 -1验证码不正确 -2验证码已过期
	 */
	public int validateSms(int id, String mobile, String validationCode) {
		CustomerSmsPo sms = smsPoMapper.selectById(id, mobile);
		// 短信验证是否存在
		if (sms == null) {
			return -1;
		}
		// 短信验证码是否过期
		if (new Date().compareTo(sms.getValidationExpire()) > 0) {
			return -2;
		}
		// 短信验证码是否正确
		if (!StringUtils.equals(sms.getValidationCode(), validationCode)) {
			return -1;
		}

		return 0;
	}

	/**
	 * 获取4位随机数字验证码
	 */
	private String getRandomValidationCode() {
		int random = (int) Math.random() * 9999;
		return StringUtils.leftPad(String.valueOf(random), 4, '0');
	}

	/**
	 * 短信验证有效时间， 默认三分钟
	 */
	private Date getValidationExpire() {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MINUTE, 3); // expire in 3 minutes
		return calendar.getTime();
	}
}
