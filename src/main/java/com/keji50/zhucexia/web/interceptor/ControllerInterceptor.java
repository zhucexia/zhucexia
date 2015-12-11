package com.keji50.zhucexia.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


public class ControllerInterceptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		
	}

	/*在业务处理器请求之前被调用*/
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		/*判断用户是否登录*/
		HttpSession session = request.getSession(true);
		if(session.getAttribute("customer")==null){
			String paths =request.getServletPath();
			paths=paths.substring(0,paths.lastIndexOf("/"));
			response.sendRedirect("/");
			return false;
		}
		else{
			return true;
		}
	}

}
