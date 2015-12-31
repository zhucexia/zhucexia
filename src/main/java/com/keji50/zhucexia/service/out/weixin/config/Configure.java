package com.keji50.zhucexia.service.out.weixin.config;

/**
 * User: rizenguo
 * Date: 2014/10/29
 * Time: 14:40
 * 这里放置各种配置数据
 */
public class Configure {
	public static String APPID = "wx7eb46e5ce64de326";
	//受理商ID，身份标识
	public static String MCHID = "1276828401";
	//商户支付密钥Key。审核通过后，在微信发送的邮件中查看
	public static String KEY = "xgXIpQLaiTTVLH6CAAdeIgAEPzCzB0u0";
	//JSAPI接口中获取openid，审核后在公众平台开启开发模式后可查看
	public static String APPSECRET = "ec77fc986a7e456798e1cf8ed040a11f";
	//重定向地址
	public static String REDIRECT_URL = "http://XXXXXXXXXXXXXXXXXXX/callWeiXinPay";
	//异步回调地址
	public static String NOTIFY_URL = "http://www.zhucexia/WXIndex/goodList";
	//web回调地址
	public static String WEB_NOTIFY_URL = "http://www.zhucexia/WXIndex/goodList";
}
