package com.keji50.zhucexia.weixin.controller;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jdom.JDOMException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.keji50.zhucexia.dao.po.CustomerAddrPo;
import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.dao.po.SalaOrderPo;
import com.keji50.zhucexia.service.out.weixin.config.Configure;
import com.keji50.zhucexia.service.out.weixin.util.httpClient.RequestHandler;
import com.keji50.zhucexia.service.out.weixin.util.httpClient.Sha1Util;
import com.keji50.zhucexia.service.out.weixin.util.httpClient.Utils;
import com.keji50.zhucexia.service.out.weixin.util.httpClient.XMLUtil;
import com.keji50.zhucexia.service.weixin.WXGoodService;
import com.keji50.zhucexia.service.weixin.WXOrderService;


@Controller
@RequestMapping("/WXOrder")
public class WXOrderController {
	
	@Resource(name="WXOrderService")
	private WXOrderService orderService;
	@Resource(name="WXGoodService")
	private WXGoodService wxgoodService;
	/*订单生成页*/
	@RequestMapping("/toBookOrders")
	public String toBookOrders(String ids,HttpServletRequest request){
		/*获取被选中的套餐的id*/
		Integer id=Integer.parseInt(ids);
		/*查询被选择的套餐的内容*/
		GoodPo goodPo=wxgoodService.getOnes(id);
		request.setAttribute("goodPo", goodPo);
		request.setAttribute("ids", id);
		return "weixinpage/bookOrders";
	}
	/*生成订单*/
	@RequestMapping("/buildOrders")
	public String buildOrders(HttpServletRequest request){
		//获取当前登录用户信息
		CustomerPo customer=new CustomerPo();
		customer=(CustomerPo) request.getSession().getAttribute("customer");
		/*获取传递的数据*/
		//省，城，区
		String area =request.getParameter("area");
		String proCity=area.split(" ")[0]+" "+area.split(" ")[0];
		String areas=area.split(" ")[2];
		//省，城，区的id值
		String areaId=request.getParameter("areaId");
		//街道地址
		String address=request.getParameter("address");
		//收货人姓名
		String consignor=request.getParameter("consignor");
		//收货人联系电话
		String telephone=request.getParameter("telephone");
		//邮编
		String zipcode=request.getParameter("zipcode");
		//产品id
		String goodId=request.getParameter("goodId");
		//商品总价格
		String order_money=request.getParameter("order_money");
		//实例化一个地址实例，
		CustomerAddrPo addrPo = new CustomerAddrPo();
		addrPo.setAddress(proCity);
		addrPo.setAreaRegion(areas);
		addrPo.setStreet(address);
		addrPo.setCustomer_id(customer.getId());
		addrPo.setZip_code(zipcode);
		addrPo.setTelephone(telephone);
		addrPo.setIs_default("1");
		addrPo.setAddressId(areaId);
		addrPo.setName(consignor);
		/*添加订单信息*/
		SalaOrderPo saleOrder=new SalaOrderPo();
		saleOrder.setCustomerid(customer.getId());
		saleOrder.setOrdermoney(Float.parseFloat(order_money));
		saleOrder.setTelephone(telephone);
		saleOrder.setZipcode(zipcode);
		Timestamp times=new Timestamp(System.currentTimeMillis());
		saleOrder.setOrderstatetime(times);
		int flag=orderService.buildOrders(saleOrder, addrPo, goodId);

		request.setAttribute("id", flag);
		/*判断是否数据插入成功*/
		return "weixinpage/success";		

	}
	/*订单管理中心*/
	@RequestMapping("/orderManage")
	public String totalOrder(HttpServletRequest request,HttpServletResponse response){
		CustomerPo customer = (CustomerPo)request.getSession().getAttribute("customer");
		int customerId=customer.getId();
		String types = request.getParameter("state");
		if(types==null){
			types="0";
		}
		Map<String,Object> maps=new HashMap<String,Object>();
		maps.put("types",types);
		maps.put("customerid", customerId);
		List<HashMap<String,Object>> list=orderService.querryOrders(maps);
		request.setAttribute("list", list);
		request.setAttribute("types", types);
		return "weixinpage/order";
	}
	/*确认付款，，，*/
	@RequestMapping("/makeSurePrice")
	public String makeSurePrice(HttpServletRequest request,HttpServletResponse response) throws IOException, JDOMException{
		
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		System.out.println("code-======"+code+"===========state======"+state);
		/*查询订单信息*/
		SalaOrderPo orderPo=orderService.getOrderPo(Integer.parseInt(state));
		double order_price=orderPo.getOrdermoney()*100;
		String noncestr = Sha1Util.getNonceStr();//生成随机字符串
		String timestamp = Sha1Util.getTimeStamp();//生成1970年到现在的秒数.
		String out_trade_no = orderPo.getOrder_no();//订单号
		//获取jsapi_ticket.此参数是为了生成 js api  加载时候的签名用.必须.jsapi_ticket只会存在7200秒.并且有时间限制,(好像一年还只能调用两万次.所以一定要缓存.)这是第三坑.
		//可以在java中模拟url请求.就能获取access_token 然后根据access_token 取得 jsapi_ticket,但一定要缓存起来..这个代码.我只提供获取.缓存你们自己处理.
		//SendGET方法我会在后面放出
		String tokenParam = "grant_type=client_credential&appid="+Configure.APPID+"&secret="+Configure.APPSECRET;
		String tokenJsonStr = Utils.SendGET("https://api.weixin.qq.com/cgi-bin/token", tokenParam);
		Map tokenMap = JSON.parseObject(tokenJsonStr);
		//获取access_token
		String access_token = (String)tokenMap.get("access_token");
		String ticketParam = "access_token="+access_token+"&type=jsapi";
		String ticketJsonStr = Utils.SendGET("https://api.weixin.qq.com/cgi-bin/ticket/getticket", ticketParam);
		Map ticketMap = JSON.parseObject(ticketJsonStr);
		//获取jsapi_ticket
		String ticket = (String)ticketMap.get("ticket");
		 //下面就到了获取openid,这个代表用户id.
		//获取openID
		String openParam = "appid="+Configure.APPID+"&secret="+Configure.APPSECRET+"&code="+code+"&grant_type=authorization_code";
		String openJsonStr = Utils.SendGET("https://api.weixin.qq.com/sns/oauth2/access_token", openParam);
		Map openMap = JSON.parseObject(openJsonStr);
		String openid = (String) openMap.get("openid");
		RequestHandler reqHandler = new RequestHandler(request, response);
		 //初始化     RequestHandler  类可以在微信的文档中找到.还有相关工具类    
		reqHandler.init();
		reqHandler.init(Configure.APPID, Configure.APPSECRET, Configure.KEY, "");
		//执行统一下单接口 获得预支付id
		reqHandler.setParameter("appid",Configure.APPID);
		reqHandler.setParameter("mch_id", Configure.MCHID);                //商户号
		reqHandler.setParameter("nonce_str", noncestr);            //随机字符串
		reqHandler.setParameter("body", orderPo.getRemark());                        //商品描述(必填.如果不填.也会提示系统升级.正在维护我艹.)
		reqHandler.setParameter("out_trade_no", out_trade_no);        //商家订单号
		reqHandler.setParameter("total_fee", Double.toString(order_price));                    //商品金额,以分为单位
		reqHandler.setParameter("spbill_create_ip",request.getRemoteAddr());   //用户的公网ip  IpAddressUtil.getIpAddr(request)
		//下面的notify_url是用户支付成功后为微信调用的action  异步回调.
		reqHandler.setParameter("notify_url", Configure.NOTIFY_URL);
		reqHandler.setParameter("trade_type", "JSAPI");
		//------------需要进行用户授权获取用户openid-------------
		reqHandler.setParameter("openid", openid);   //这个必填.
		//这里只是在组装数据.还没到执行到统一下单接口.因为统一下单接口的数据传递格式是xml的.所以才需要组装.
		String requestUrl = reqHandler.getRequestURL();
		                               // requestUrl 例子:
		 /*
		<xml><appid>wx2421b1c4370ec43b</appid><attach>支付测试</attach><body>JSAPI支付测试</body><mch_id>10000100</mch_id><nonce_str>1add1a30ac87aa2db72f57a2375d8fec</nonce_str><notify_url>http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php</notify_url><openid>oUpF8uMuAJO_M2pxb1Q9zNjWeS6o</openid><out_trade_no>1415659990</out_trade_no><spbill_create_ip>14.23.150.211</spbill_create_ip><total_fee>1</total_fee><trade_type>JSAPI</trade_type><sign>0CB01533B8C1EF103065174F50BCA001</sign></xml>
		*/
		                                 
		System.out.println("requestUrl==================="+requestUrl);
		//统一下单接口提交  xml格式
		URL orderUrl = new URL("https://api.mch.weixin.qq.com/pay/unifiedorder");
		HttpURLConnection conn = (HttpURLConnection) orderUrl.openConnection();
		conn.setConnectTimeout(30000); // 设置连接主机超时（单位：毫秒)
		conn.setReadTimeout(30000); // 设置从主机读取数据超时（单位：毫秒)
		conn.setDoOutput(true); // post请求参数要放在http正文内，顾设置成true，默认是false
		conn.setDoInput(true); // 设置是否从httpUrlConnection读入，默认情况下是true
		conn.setUseCaches(false); // Post 请求不能使用缓存
		// 设定传送的内容类型是可序列化的java对象(如果不设此项,在传送序列化对象时,当WEB服务默认的不是这种类型时可能抛java.io.EOFException)
		conn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
		conn.setRequestMethod("POST");// 设定请求的方法为"POST"，默认是GET
		conn.setRequestProperty("Content-Length",requestUrl.length()+"");
		String encode = "utf-8";
		OutputStreamWriter out = new OutputStreamWriter(conn.getOutputStream(), encode);
		out.write(requestUrl.toString());
		out.flush();
		out.close();
		String result = Utils.getOut(conn);
		System.out.println("result=========返回的xml============="+result);
		Map<String, String> orderMap = XMLUtil.doXMLParse(result);
		System.out.println("orderMap==========================="+orderMap);
		//得到的预支付id
		String prepay_id = orderMap.get("prepay_id");
		SortedMap<String,String> params = new TreeMap<String,String>();
		params.put("appId", Configure.APPID);
		params.put("timeStamp",timestamp);
		params.put("nonceStr", noncestr);
		params.put("package", "prepay_id="+prepay_id);
		params.put("signType", "MD5");
		         
		//生成支付签名,这个签名 给 微信支付的调用使用
		String paySign =  reqHandler.createSign(params);        
		request.setAttribute("paySign", paySign);
		request.setAttribute("appId", Configure.APPID);
		request.setAttribute("timeStamp", timestamp);        //时间戳
		request.setAttribute("nonceStr", noncestr);            //随机字符串
		request.setAttribute("signType", "MD5");        //加密格式
		request.setAttribute("out_trade_no", out_trade_no);          //订单号
		request.setAttribute("package", "prepay_id="+prepay_id);//预支付id ,就这样的格式.
		String url = "http://xxxxxxxxxx/control/wxPayment";
		String signValue = "jsapi_ticket="+ticket+"&noncestr="+noncestr+"&timestamp="+timestamp+"&url="+url;
		System.out.println("url====="+signValue);
		//这个签名.主要是给加载微信js使用.别和上面的搞混了.
		String signature = Sha1Util.getSha1((signValue));
		request.setAttribute("signature", signature);
		return "weixinpage/success";
}
	@RequestMapping("/orderDetail")
	public String orderDetail(HttpServletRequest request,HttpServletResponse response){
		int id=Integer.parseInt(request.getParameter("id"));
		Map<String,Object> order = orderService.getOrderById(id);
		request.setAttribute("order", order);
		return "weixinpage/orderDetail";
	}
	
	@RequestMapping("/delOrder")
	@ResponseBody
	public int delOrder(HttpServletRequest request,HttpServletResponse response){
		int i;
		String id=request.getParameter("order_id");
		int flag=orderService.delOrder(id);
		if(flag>0){
			return i=0;
		}else{
			return i=1;
		}
	}
	
	@RequestMapping("/cancleOrder")
	@ResponseBody
	public int cancleOrder(HttpServletRequest request,HttpServletResponse response){
		int i;
		String id=request.getParameter("order_id");
		int flag=orderService.cancleOrder(id);
		if(flag>0){
			return i=0;
		}else{
			return i=1;
		}
	}
	
	@RequestMapping("/completeOrder")
	@ResponseBody
	public int completeOrder(HttpServletRequest request,HttpServletResponse response){
		int i;
		String id=request.getParameter("id");
		int flag=orderService.completeOrder(id);
		if(flag>0){
			return i=0;
		}else{
			return i=1;
		}

	}
}
