package com.keji50.zhucexia.web.controller;

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
		System.out.println("进入了sysuserController的方法--login");
		//判断用户是否存在
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		CustomerPo c=new CustomerPo();
		c.setUsername(username);
		c.setPassword(password);
		c.setMobile(username);
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
		System.out.println("进入了sysuserController的方法--login");
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
		request.getSession().removeAttribute("customer");
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
	public String reg(HttpServletRequest request, CustomerPo cust){
		System.out.println("进入了注册方法");
		//判断用户是否存在
		System.out.println(cust);
		int result=customerService.insertreg(cust);
		String json="";
		if(result>0){
			System.out.println("插入成功！！！");
			json="{'message':'插入成功'}";
		}else {
			System.out.println("插入失败");
			json="{'message':'插入失败'}";
		}
		System.out.println(json);
		return json;
	}
}
