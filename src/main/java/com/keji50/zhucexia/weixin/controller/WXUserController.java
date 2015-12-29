package com.keji50.zhucexia.weixin.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.dao.po.CustomerSmsPo;
import com.keji50.zhucexia.service.CustomerEmailValidationService;
import com.keji50.zhucexia.service.CustomerService;
import com.keji50.zhucexia.service.CustomerSmsValidationService;
import com.keji50.zhucexia.service.out.sms.SmsTemplate;
import com.keji50.zhucexia.service.weixin.WXUserService;

@Controller
@RequestMapping("/WXUser")
public class WXUserController {
	
	@Resource(name="WXUserService")
	private WXUserService userService;
	@Resource
	private CustomerSmsValidationService customerSmsValidationService;
	@Resource
	private CustomerEmailValidationService customerEmailValidationService;
	
	@RequestMapping("/toLogin")
	public String toLogin(HttpServletRequest request,HttpServletResponse response){
		String aim =request.getParameter("aim");
		String sign="login";
		request.setAttribute("sign",sign);
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
	
	@RequestMapping("/mess")
	@ResponseBody
	public int sentMess(HttpServletRequest request,HttpServletResponse response){
		String mobile=request.getParameter("mobile");
		String ip="";
		 try {
			ip = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		CustomerSmsPo sms=customerSmsValidationService.sendValidationSms(mobile, ip, SmsTemplate.VALIDATION_TEMPLATE);
		System.out.println("验证码："+sms.getValidationCode());
		request.getSession().setAttribute("sms", sms);
		int i=0;
		if(sms==null){
			i=1;
		}
		return i;
	}
	
	@RequestMapping("/validateMobile")
	@ResponseBody
	public int validateMobile(HttpServletRequest request,HttpServletResponse response){
		int i=0;
		String mobile = request.getParameter("mobile");
		CustomerPo c=new CustomerPo();
		c.setMobile(mobile);
		CustomerPo customer=userService.validatephone(c);
		if(customer==null){
			i=1;
		}
		return i;
	}
	
	@RequestMapping("/regist")
	@ResponseBody
	public int regist(HttpServletRequest request,HttpServletResponse response){
		String mobile=request.getParameter("mobile");
		String password=request.getParameter("password");
		String code=request.getParameter("code");
		CustomerSmsPo sms = (CustomerSmsPo)request.getSession().getAttribute("sms");
		int result=customerSmsValidationService.validateSms(sms.getId(), mobile, code);
		int i = 0;
		if(result==-1){
			i=-1;
		}else if(result==-2){
			i=-2;
			request.getSession().removeAttribute("customersms");
		}else if(result==0){
			request.getSession().removeAttribute("customersms");
			CustomerPo cust = new CustomerPo();
			cust.setUsername(mobile);
			cust.setMobile(mobile);
			cust.setPassword(password);
			int j=userService.insertreg(cust);
			if(j>0){
				i=0;
				request.getSession().setAttribute("customer",cust);
			}else{
				i=1;
			}
		}
		return i;
	}
	
	@RequestMapping("/lostPwd")
	@ResponseBody
	public int lostPwd(HttpServletRequest request,HttpServletResponse response){
		int i=0;
		String mobile = request.getParameter("mobile");
		String password=request.getParameter("password");
		String code=request.getParameter("code");
		CustomerSmsPo sms=(CustomerSmsPo)request.getSession().getAttribute("sms");
		int result=customerSmsValidationService.validateSms(sms.getId(), mobile, code);
		if(result==-1){
			i=-1;
		}else if(result==-2){
			request.getSession().removeAttribute("customersms");
			i=-2;
		}else if(result==0){
			request.getSession().removeAttribute("customersms");
			CustomerPo cust=new CustomerPo();
			cust.setMobile(mobile);
			cust.setPassword(password);
			int j = userService.updatepass(cust);
			if(j>0){
				i=0;
				request.getSession().setAttribute("customer", cust);
			}else{
				i=1;
			}
		}
		return i;
	}
	
	@RequestMapping("/toChangePwd")
	public String toChangePwd(HttpServletRequest request, HttpServletResponse response){
		String sign = "change";
		String aim="3";
		request.setAttribute("sign", sign);
		request.setAttribute("aim", aim);
		return "weixinpage/login";
	}
}
