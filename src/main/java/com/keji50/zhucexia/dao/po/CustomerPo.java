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
	
	private String username;
	
	private String password;
	
	private String qq;	
	
	private String ispinlessmobile;
	
	private String ispinlessemail;
	
	private String type;//'0: 普通会员    1:企业会员',
	
	private String pic;
	
	private String pic_id;
	
	private String nickName;
}
