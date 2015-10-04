package com.keji50.zhucexia.dao.po;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class CustomerPo extends BasePo {

	private int id;

	// 手机号
	private String mobile;

	// 邮箱
	private String email;

}
