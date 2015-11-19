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
		//System.out.println("11111111111");
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		//System.out.println("22222222222222");
		
	}

	/*在业务处理器请求之前被调用*/
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		/*判断用户是否登录*/
		//System.out.println("33333333333333");
		HttpSession session = request.getSession(true);
		//System.out.println("111111111111111");
	//	System.out.println("interceptor----"+session.getAttribute("customer"));
		if(session.getAttribute("customer")==null){
		//	System.out.println("wwwwwww");
			String paths =request.getServletPath();
			paths=paths.substring(0,paths.lastIndexOf("/"));
			//request.getRequestDispatcher("/zhucexia/index/show").forward(request, response);;
			response.sendRedirect("/zhucexia/index/show");
			return false;
		}
		else{
			return true;
		}
	}

}
