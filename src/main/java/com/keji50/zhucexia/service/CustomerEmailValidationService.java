package com.keji50.zhucexia.service;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.CustomerEmailPoMapper;
import com.keji50.zhucexia.dao.po.CustomerEmailPo;
import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.service.out.email.EmailGatewayService;
import com.keji50.zhucexia.service.out.email.EmailTemplate;

@Service(value = "customerEmailValidationService")
public class CustomerEmailValidationService extends AbstractValidationService {

	@Resource(name = "emailGatewayService")
	private EmailGatewayService emailGatewayService;

	@Resource(name = "customerEmailPoMapper")
	private CustomerEmailPoMapper customerEmailPoMapper;

	/**
	 * 发送验证邮件
	 * 
	 * @param customer
	 *            客户信息， id和email为必输项
	 * @param ip
	 *            客户ip信息
	 * @param template
	 *            邮件模板
	 * 
	 * @return 新增的邮件对象 包含当前邮件对象id
	 */
	public CustomerEmailPo sendEmail(CustomerPo customer, String ip, EmailTemplate template) {
		CustomerEmailPo email = new CustomerEmailPo(customer.getId(), customer.getEmail(), template.getType());
		email.setValidationCode(getRandomValidationCode());
		email.setValidationExpire(getValidationExpire(Calendar.HOUR, 48)); // 有效期48小时
		email.setIp(ip);

		// 插入 记录到数据库， 如插入成功， 调用邮件服务发送验证邮件
		int count = customerEmailPoMapper.insert(email);
		if (count > 0) {
			emailGatewayService.sendEmail(email);
		}

		return email;
	}
	
	/**
	 * 验证邮箱验证码是否正确
	 * 
	 * @param id
	 *            当前邮箱验证id
	 * @param type
	 *            邮箱验证类型 0 绑定邮箱 1重置密码
	 * @param validationCode
	 *            验证md5字符串
	 * @return map 
	 * 			resultCode 0成功 -1验证码不正确 -2验证码已过期 
	 * 			result 当前email对象， 里面包含邮箱、用户id等信息
	 */
	public Map<String, Object> validateEmail(int id, String type, String validationCode) {
		Map<String, Object> result = new HashMap<String, Object>();

		CustomerEmailPo email = customerEmailPoMapper.selectById(id, type);
		// 邮件验证是否存在
		if (email == null) {
			result.put("resultCode", -1);
			return result;
		}
		// 邮件验证码是否过期
		if (new Date().compareTo(email.getValidationExpire()) > 0) {
			result.put("resultCode", -2);
			return result;
		}
		// 邮件验证码是否正确
		if (!StringUtils.equals(email.toMD5ValidationString(), validationCode)) {
			result.put("resultCode", -1);
			return result;
		}

		result.put("resultCode", 0);
		result.put("result", email);
		return result;
	}
	
	public static void main(String[] args) {
		@SuppressWarnings("resource")
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
				"spring-context.xml");
		CustomerEmailValidationService service = (CustomerEmailValidationService) applicationContext.getBean("customerEmailValidationService");
		CustomerPo customer = new CustomerPo();
		customer.setId(1);
		customer.setEmail("1769702010@qq.com");
		service.sendEmail(customer, "192.168.1.1", EmailTemplate.VALIDATION_TEMPLATE);
	}

}
