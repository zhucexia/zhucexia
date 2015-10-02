package com.keji50.zhucexia.dao.po;

import java.util.Date;

import com.keji50.zhucexia.service.out.sms.SmsTemplate;

import lombok.Data;

@Data
public class SmsPo extends BasePo {

	public SmsPo(String mobile, String type, String content) {
		this.mobile = mobile;
		this.type = type;
		this.content = content;
	}
	
	private int id;

	// 手机号
	private String mobile;

	// 短信内容
	private String content;

	// 短信类型, 1: 手机绑定短信
	private String type;

	// 客户IP地址
	private String ip;
	
	private Date validationExpire;
	
	private String smsId;
	
	public String getSmsContent() {
		return String.format(SmsTemplate.getTemplate(type), content);
	}

}
