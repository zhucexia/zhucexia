package com.keji50.zhucexia.dao.po;
import java.util.Date;
import lombok.Data;

@Data
public class PaymentPo extends BasePo {
	// 主键值
	private int id;
	//支付方式代码
	private String code;
	//支付方式名称
	private String name;
	//优惠费率
	private float payment_fee;
	//备注
	private String remark;
	//状态
	private String state;

}
