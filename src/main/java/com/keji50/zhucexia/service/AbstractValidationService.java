package com.keji50.zhucexia.service;

import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

public abstract class AbstractValidationService {
		
	/**
	 * 获取4位随机数字验证码
	 */
	protected String getRandomValidationCode() {
		int random = (int) (Math.random() * 9999);
		return StringUtils.leftPad(String.valueOf(random), 4, '0');
	}

	/**
	 * 获取验证码有效时间
	 */
	protected Date getValidationExpire(int field, int amount) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(field, amount);
		return calendar.getTime();
	}
}
