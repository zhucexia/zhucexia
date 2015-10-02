package com.keji50.zhucexia.service.out.sms;

import java.util.HashMap;
import java.util.Map;
import lombok.Getter;
import lombok.Setter;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.keji50.zhucexia.dao.po.SmsPo;
import com.keji50.zhucexia.service.out.http.HttpClientService;

public class SmsGatewayService {

	private static final Logger log = LoggerFactory.getLogger(SmsGatewayService.class);

	@Setter @Getter
	private String smsUrl;

	@Setter @Getter
	private String account;

	@Setter @Getter
	private String password;

	@Setter @Getter
	private HttpClientService httpClientService;

	public SmsGatewayPo sendSms(SmsPo sms) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("account", getAccount());
		params.put("password", getPassword());
		params.put("mobile", sms.getMobile());
		params.put("content", sms.getSmsContent());

		String smsResult = null;
		try {
			smsResult = getHttpClientService().post(getSmsUrl(), params);
			return toBean(smsResult);
		} catch (Exception e) {
			log.error("fail to send sms", e);
			return null;
		}
	}

	private SmsGatewayPo toBean(String xml) throws DocumentException {
		Document doc = DocumentHelper.parseText(xml);
		Element root = doc.getRootElement();

		SmsGatewayPo po = new SmsGatewayPo();
		if (root.element("code") != null) {
			po.setCode(root.elementText("code"));
		}
		if (root.element("msg") != null) {
			po.setMsg(root.elementText("msg"));
		}
		if (root.element("smsid") != null) {
			po.setSmsid(root.elementText("smsid"));
		}
		return po;
	}

	public static void main(String[] args) {
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
				"spring-context.xml");
		SmsGatewayService smsService = (SmsGatewayService) applicationContext
				.getBean("smsGatewayService");

		SmsPo sms = new SmsPo("13801769749", SmsTemplate.VALIDATION_TEMPLATE.getType(), "1234");
		System.out.println(smsService.sendSms(sms));
	}
}
