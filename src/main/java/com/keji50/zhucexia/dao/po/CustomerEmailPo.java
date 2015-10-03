package com.keji50.zhucexia.dao.po;

import com.keji50.zhucexia.service.out.email.EmailTemplate;
import java.util.Date;
import lombok.Data;

@Data
public class CustomerEmailPo extends BasePo {

	public CustomerEmailPo(String email, String type, String validationCode) {
		this.email = email;
		this.type = type;
		this.validationCode = validationCode;
	}

	private int id;

	// 邮件类型, 0: 邮箱绑定验证 1:重置密码
	private String type;

	// 邮箱地址
	private String email;

	// 验证码
	private String validationCode;

	// 有效时间
	private Date validationExpire;

	// 客户ip
	private String ip;

	// 邮件状态 0：未验证 1：已验证
	private String state;

	public String getEmailContent(String callback) {
		return String.format(EmailTemplate.getTemplate(type), callback);
	}
}
