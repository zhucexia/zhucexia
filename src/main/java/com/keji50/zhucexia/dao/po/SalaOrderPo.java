package com.keji50.zhucexia.dao.po;

import java.util.Date;

import lombok.Data;

@Data
public class SalaOrderPo extends BasePo{
	private int id;
	
	private String type;
	
	private int customerid;
	
	private String customername;
	
	private float ordermoney;
	
	private String address;
	
	private String mobile;
	
	private String telephone;
	
	private String email;
	
	private String zipcode;
	
	private int paymentid;
	
	private String paymentcode;
	
	private String paymentname;
	
	private int deliveryid;
	
	private String deliverycode;
	
	private String deliveryname;
	
	private String orderstate;
	
	private String paymentstate;
	
	private String deliverystate;
	
	private String remark;
	
	private String alipaytradeno;
	
	private String deliverytradeno;
	
	private Date orderstatetime;
	
	private Date paymenttime;
	
	private Date deliverytime;
	
	private Date canceltime;
	
}