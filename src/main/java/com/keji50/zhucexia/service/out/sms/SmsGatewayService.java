package com.keji50.zhucexia.service.out.sms;

import com.keji50.zhucexia.dao.po.CustomerSmsPo;
import com.keji50.zhucexia.service.out.http.HttpClientService;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;

/**
 * 短信网关服务，  异步发送短信验证码
 * @author chao.li
 *
 */
public class SmsGatewayService implements DisposableBean {

	private static final Logger log = LoggerFactory.getLogger(SmsGatewayService.class);

	@Setter @Getter
	private String smsUrl;

	@Setter @Getter
	private String account;

	@Setter @Getter
	private String password;

	@Setter @Getter
	private HttpClientService httpClientService;
	
	// 处理线程池， 短信网关异步发送短信
	private ExecutorService pool = Executors.newCachedThreadPool();

	/**
	 * 异步发送短信验证码
	 * @param sms
	 */
	public void sendSms(final CustomerSmsPo sms) {
		pool.execute(new Runnable() {
			@Override
			public void run() {
				Map<String, String> params = new HashMap<String, String>();
				params.put("account", getAccount());
				params.put("password", getPassword());
				params.put("mobile", sms.getMobile());
				params.put("content", sms.getSmsContent());

				try {
					getHttpClientService().post(getSmsUrl(), params);
				} catch (Exception e) {
					log.error("fail to send sms", e);
				}
			}
		});
		
	}

//	private SmsGatewayPo toBean(String xml) throws DocumentException {
//		Document doc = DocumentHelper.parseText(xml);
//		Element root = doc.getRootElement();
//
//		SmsGatewayPo po = new SmsGatewayPo();
//		if (root.element("code") != null) {
//			po.setCode(root.elementText("code"));
//		}
//		if (root.element("msg") != null) {
//			po.setMsg(root.elementText("msg"));
//		}
//		if (root.element("smsid") != null) {
//			po.setSmsid(root.elementText("smsid"));
//		}
//		return po;
//	}

	@Override
	public void destroy() throws Exception {
		if (pool != null) {
			pool.shutdown();
		}
	}
}
