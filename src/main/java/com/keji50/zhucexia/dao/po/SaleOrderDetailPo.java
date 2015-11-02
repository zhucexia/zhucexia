package com.keji50.zhucexia.dao.po;

import java.util.List;

import com.keji50.zhucexia.dao.mapper.CustomerAddrPoMapper;

import lombok.Data;

@Data
public class SaleOrderDetailPo extends BasePo{
	private int id;
	
	private int good_id;
	
	private String good_name;
	
	private int good_price_id;
	
	private float good_price;
	
	private int good_num;
	
	private float total_price;
	
	private int order_id;
	
	/*订单号*/
	private String order_no;
	private GoodPo goods;
}
