package com.keji50.zhucexia.service;

import com.keji50.zhucexia.dao.mapper.CustomerSmsPoMapper;
import com.keji50.zhucexia.dao.po.CustomerSmsPo;
import com.keji50.zhucexia.service.out.sms.SmsGatewayService;
import com.keji50.zhucexia.service.out.sms.SmsTemplate;
import java.util.Calendar;
import java.util.Date;
import javax.annotation.Resource;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;



@Service(value = "customerSmsValidationService")
public class CustomerSmsValidationService {

	@Resource(name = "smsGatewayService")
	private SmsGatewayService smsGatewayService;

	@Resource(name = "customerSmsPoMapper")
	private CustomerSmsPoMapper customerSmsPoMapper;

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
		sms.setValidationExpire(getValidationExpire());
		sms.setIp(ip);

		int count = customerSmsPoMapper.insert(sms);
		if (count > 0) {
			// 异步发送验证短信
			smsGatewayService.sendSms(sms);
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
		CustomerSmsPo sms = customerSmsPoMapper.selectById(id, mobile);
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
		int random = (int) (Math.random() * 9999);
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
	
	public static void main(String[] args) {
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
				"spring-context.xml");
		CustomerSmsValidationService service = (CustomerSmsValidationService) applicationContext
				.getBean("customerSmsValidationService");

		System.out.println(service.sendValidationSms("13501635413", "192.168.1.1"));
		//System.out.println(service.validateSms(5, "13501635413", "3605"));
	}
}
