package com.keji50.zhucexia.dao.po;

import lombok.Data;

@Data
public class SmsPo extends BasePo {

	private int id;

	// 手机号
	private String phoneNumber;

	// 短信内容
	private String content;

	// 短信类型, 0: 手机绑定短信
	private String type;

	// 客户IP地址
	private String ip;

}
