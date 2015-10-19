package com.keji50.zhucexia.web.controller;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.dao.po.CustomerSmsPo;
import com.keji50.zhucexia.service.CustomerService;
import com.keji50.zhucexia.service.CustomerSmsValidationService;
import com.keji50.zhucexia.service.out.sms.SmsTemplate;

@Controller
@RequestMapping(value = "/customer")
public class CustomerController {

	@Resource(name="customerService")
	private CustomerService customerService;
	
	
	@RequestMapping("/login")
	@ResponseBody
	public String login(HttpServletRequest request, HttpServletResponse response){
		System.out.println("进入了login方法--login");
		//判断用户是否存在
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		CustomerPo c=new CustomerPo();
		c.setUsername(username);
		c.setPassword(password);
		c.setMobile(username);
		System.out.println("--"+c);
		CustomerPo customer=customerService.login(c);
		String json="";
		if(customer!=null){
			request.getSession().setAttribute("customer", customer);
			if(customer.getUsername().equals(username)){
				json="{'message':'登录成功','names':'"+customer.getUsername()+"'}";
			}else {
				json="{'message':'登录成功','names':'"+customer.getMobile()+"'}";
			}
		}else {
			json="{'message':'登录失败'}";
		}
		System.out.println(json);
		return json;
	}
	
	@RequestMapping("/mess")
	@ResponseBody
	public String mess(HttpServletRequest request, HttpServletResponse response){
		String phone=request.getParameter("phonenum");
		System.out.println("----"+phone);
		
		@SuppressWarnings("resource")
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
				"spring-context.xml");
		CustomerSmsValidationService service = (CustomerSmsValidationService) applicationContext
				.getBean("customerSmsValidationService");
		CustomerSmsPo sms=service.sendValidationSms(phone, "192.168.1.1", SmsTemplate.VALIDATION_TEMPLATE);
		
		String json="";
		if(sms!=null){
			request.getSession().setAttribute("customersms", sms);
			json="{'message':'发送成功','names':'"+sms.getValidationCode()+"'}";
		}else {
			json="{'message':'发送失败'}";
		}
		System.out.println(json);
		return json;
	}
	
	
	@RequestMapping("/clearsession")
	@ResponseBody
	public String clearsession(HttpServletRequest request, HttpServletResponse response){
		request.getSession().invalidate();
		String pa=request.getRealPath("/");
		System.out.println(pa);
		pa=pa.substring(0,pa.lastIndexOf("\\"));
		System.out.println(pa);
		pa=pa.substring(0,pa.lastIndexOf("\\"))+"\\resource";
		System.out.println(pa);
		File file = new File(pa);
		if(!file.exists()){
			System.out.println(file.mkdirs());
			if(file.mkdir())
				{
				
				System.out.println("oh!ye成功喽！！！！");
				}
		}
		System.out.println("进入清除缓存方法");
		String	json="{'message':'清除缓存'}";
		return json;
	}
	
	@RequestMapping("/validateuser")
	@ResponseBody
	public String validateuser(HttpServletRequest request, HttpServletResponse response){
		System.out.println("进入了验证用户方法");
		//判断用户是否存在
		String username=request.getParameter("username");
		CustomerPo c=new CustomerPo();
		c.setUsername(username);
		CustomerPo customer=customerService.validate(c);
		String json="";
		if(customer!=null){
			json="{'message':'已经被占用','names':'"+customer.getUsername()+"'}";
		}else {
			json="{'message':'可以使用'}";
		}
		System.out.println(json);
		return json;
	}
	
	@RequestMapping("/validatephone")
	@ResponseBody
	public String validatephone(HttpServletRequest request, HttpServletResponse response){
		System.out.println("进入了验证手机方法");
		//判断用户是否存在
		String mobile=request.getParameter("phonenum");
		CustomerPo c=new CustomerPo();
		c.setMobile(mobile);
		CustomerPo customer=customerService.validatephone(c);
		String json="";
		if(customer!=null){
			json="{'message':'该号已占用','names':'"+customer.getMobile()+"'}";
		}else {
			json="{'message':'可以使用'}";
		}
		System.out.println(json);
		return json;
	}
	
	@RequestMapping("/reg")
	@ResponseBody
	public String reg(HttpServletRequest request ){
		System.out.println("进入了注册方法");
		CustomerSmsPo s=(CustomerSmsPo) request.getSession().getAttribute("customersms");
		System.out.println("发送短信session保存的"+s);
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
				"spring-context.xml");
		CustomerSmsValidationService service = (CustomerSmsValidationService) applicationContext
				.getBean("customerSmsValidationService");
		int result=service.validateSms(s.getId(), s.getMobile(), s.getValidationCode());
		System.out.println("注册返回result:"+result);
		//验证是否成功 0成功 -1验证码不正确 -2验证码已过期
		String json="";
		request.getSession().removeAttribute("customersms");
		if(result == -1){
			json="{'message':'验证码不正确'}";
		}else if(result == -2){
			json="{'message':'验证码不正确'}";
		}else if(result == 0){
			String username=request.getParameter("username");
			String password=request.getParameter("password");
			String phonenum=request.getParameter("phonenum");
			String email=request.getParameter("email");
			CustomerPo c=new CustomerPo();
			c.setUsername(username);
			c.setPassword(password);
			c.setMobile(phonenum);
			c.setEmail(email);
			//判断用户是否存在
			System.out.println(c);
			int num=customerService.insertreg(c);			
			if(num>0){
				System.out.println("注册成功！！！");
				json="{'message':'注册成功'}";
			}else {
				System.out.println("注册失败");
				json="{'message':'注册失败'}";
			}
		}
		
		
		System.out.println(json);
		return json;
	}
}
