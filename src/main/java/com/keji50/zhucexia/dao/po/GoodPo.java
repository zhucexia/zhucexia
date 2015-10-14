package com.keji50.zhucexia.dao.po;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class GoodPo extends BasePo {
	// 主键值
	private int id;
	//商品编号
	private String code;
	//商品名称
	private String name;
	//商品类别id
	private Integer good_type_id;
	// 商品类别名称
	private String good_type_name;
	//价格范围
    private String price_range;
    //市场价
    private String price_market;
    //图片id
    private String pic_id;
    //商品图片
    private String pic;
    //注册时长
    private String register_cost;
    //申请条件
    private String apply_condition;
    //商品详细内容,富文本
    private String detail_content;
    //上架时间
    private Date begin_sale_time;
    //下架时间
    private Date end_sale_time;
    //总销量
    private Integer total_sales;
    // 日销量
    private Integer daily_sales;
    //是否在首页显示，0，不显示，1，显示
    private String index_show;
    //'数据状态 c:草稿 s;审核 d:下架'
    private String state;
    //期初初始数量
    private Integer initialNum;
    //商品备注
    private String remark;
    //商品点击数
    private Integer click_count;
    //商品的评论数
    private Integer comment_count;
    //商品排序
    private Integer sort;
    

}
