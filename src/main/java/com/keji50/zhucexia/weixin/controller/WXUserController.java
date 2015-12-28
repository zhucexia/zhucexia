package com.keji50.zhucexia.weixin.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.service.CustomerService;
import com.keji50.zhucexia.service.weixin.WXUserService;

@Controller
@RequestMapping("/WXUser")
public class WXUserController {
	
	@Resource(name="WXUserService")
	private WXUserService userService;
	
	@RequestMapping("/toLogin")
	public String toLogin(HttpServletRequest request,HttpServletResponse response){
		String aim =request.getParameter("aim");
		request.setAttribute("aim", aim);
		return "weixinpage/login";
	}
	
	@RequestMapping("/login")
	@ResponseBody
	public int login(HttpServletRequest request,HttpServletResponse response){
		String mobile = request.getParameter("mobile");
		String password = request.getParameter("password");
		int i = 0;
		CustomerPo cust = userService.loginResult(mobile, password);
		if(cust==null){
			i=1;
		}else{
			request.getSession().setAttribute("customer", cust);
		}
		return i;
	}
	
	@RequestMapping("/userCenter")
	public String userCenter(HttpServletRequest request,HttpServletResponse response){
		return "weixinpage/userCenter";
	}
}
