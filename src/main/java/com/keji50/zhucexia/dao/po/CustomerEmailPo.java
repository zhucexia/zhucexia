package com.keji50.zhucexia.dao.po;

import com.keji50.zhucexia.common.utils.MD5Utils;
import com.keji50.zhucexia.service.out.email.EmailTemplate;
import java.util.Date;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class CustomerEmailPo extends BasePo {

	public CustomerEmailPo() {

	}

	public CustomerEmailPo(int customerId, String email, String type) {
		this.customerId = customerId;
		this.email = email;
		this.type = type;
	}

	private int id;

	// 邮件类型, 0: 邮箱绑定验证 1:重置密码
	private String type;
	
	// 客户id
	private int customerId;

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

	public String getEmailContent(String baseValidationUrl) {
		StringBuilder validationUrl = new StringBuilder(baseValidationUrl);
		validationUrl.append("?id=").append(id).append("&type=").append(type).append("&validationCode=").append(toMD5ValidationString());

		return String.format(EmailTemplate.getTemplate(type), validationUrl);
	}

	/**
	 * 返回md5密文， 用作密文验证
	 */
	public String toMD5ValidationString() {
		return MD5Utils.md5(validationCode + "keji50");
	}
}
