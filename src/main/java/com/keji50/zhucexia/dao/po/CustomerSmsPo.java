package com.keji50.zhucexia.dao.po;

import java.util.Date;

import com.keji50.zhucexia.service.out.sms.SmsTemplate;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CustomerSmsPo extends BasePo {

	public CustomerSmsPo() {

	}
	
	public CustomerSmsPo(String mobile, String type, String validationCode) {
		this.mobile = mobile;
		this.type = type;
		this.validationCode = validationCode;
	}

	private int id;

	// 短信类型, 0: 手机绑定短信
	private String type;

	// 手机号
	private String mobile;

	// 验证码
	private String validationCode;

	// 有效时间
	private Date validationExpire;

	// 客户IP地址
	private String ip;

	private String smsId;

	public String getSmsContent() {
		return String.format(SmsTemplate.getTemplate(type), validationCode);
	}

}
