package com.keji50.zhucexia.dao.po;

import lombok.Data;

@Data
public class GoodAttrPo extends BasePo {
	
	private int id;
	
	private int goodid;
	
	private String code;
	private String names;
	
	private int sort;
	
	private String remark;
	
	private String state;
	
	private String optionvalue;
}
