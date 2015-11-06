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
	private String phoneNumber;
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
	//省份，城市，区域的id值,以逗号分隔
	private String addressId;
	//删除标志，1，标示正常，0 表示删除
	private String isDelete;

}
