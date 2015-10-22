package com.keji50.zhucexia.common.utils;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class ApplicationContextHolder implements ApplicationContextAware {

	private static ApplicationContext applicationContext;

	@Override
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		ApplicationContextHolder.applicationContext = applicationContext;
	}

	@SuppressWarnings("unchecked")
	public static <E> E getBean(String name) {
		return (E) applicationContext.getBean(name);
	}

}
