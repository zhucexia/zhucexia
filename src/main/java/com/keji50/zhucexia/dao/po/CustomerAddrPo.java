package com.keji50.zhucexia.dao.po;

import lombok.Data;

@Data
public class CustomerAddrPo {
	//地址id
	private Integer id;
	//客户id
	private Integer customer_id;
	//用户名
	private String name;
	//电话号码
	private String phone_number;
	//地址
	private String address;
	//邮编号
	private String zip_code;
	//默认地址
	private String is_default;
	//备注
	private String remark;
	//街道
	private String street;
	//区域
	private String areaRegion;
	//手机号
	private String telephone;

}
