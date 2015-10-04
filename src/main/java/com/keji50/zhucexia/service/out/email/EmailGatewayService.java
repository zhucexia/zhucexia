package com.keji50.zhucexia.service.out.email;

import com.keji50.zhucexia.dao.po.CustomerEmailPo;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;

public class EmailGatewayService implements DisposableBean {

	private static final Logger log = LoggerFactory.getLogger(EmailGatewayService.class);

	@Setter
	private String mailFrom;

	@Setter
	private String baseValidationUrl;

	@Setter
	private JavaMailSenderImpl mailSender;

	// 处理线程池， 邮件网关异步发送验证邮件
	private ExecutorService pool = Executors.newFixedThreadPool(10);

	public void sendEmail(final CustomerEmailPo email) {
		pool.execute(new Runnable() {
			@Override
			public void run() {
				SimpleMailMessage message = new SimpleMailMessage();
				message.setFrom(mailFrom);
				message.setTo(email.getEmail());
				message.setSubject("注册侠-验证邮件");
				message.setText(email.getEmailContent(baseValidationUrl));
				try {
					mailSender.send(message);
				} catch (Exception e) {
					log.error("failed to send email", e);
				}
			}
		});
	}

	@Override
	public void destroy() throws Exception {
		if (pool != null) {
			pool.shutdown();
		}
	}
}
