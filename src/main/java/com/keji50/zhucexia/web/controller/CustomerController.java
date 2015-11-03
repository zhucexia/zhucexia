package com.keji50.zhucexia.web.controller;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.dao.po.CustomerSmsPo;
import com.keji50.zhucexia.service.CustomerService;
import com.keji50.zhucexia.service.CustomerSmsValidationService;
import com.keji50.zhucexia.service.out.sms.SmsTemplate;
/**
 * 
 * @author hc
 * 客户信息控制器
 */
@Controller
@RequestMapping(value = "/customer")
public class CustomerController {

	/**
	 * 客户信息业务逻辑
	 */
	@Resource(name="customerService")
	private CustomerService customerService;
	
	/**
	 * 客户登录
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/login")
	@ResponseBody
	public String login(HttpServletRequest request, HttpServletResponse response){
		System.out.println("进入客户登录方法--login");
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
	/**
	 * 客户发送短信
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/mess")
	@ResponseBody
	public String mess(HttpServletRequest request, HttpServletResponse response){
		System.out.println("进入发短信方法");
		String phone=request.getParameter("phonenum");
		System.out.println("----"+phone);
		@SuppressWarnings("resource")
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
				"spring-context.xml");
		CustomerSmsValidationService service = (CustomerSmsValidationService) applicationContext
				.getBean("customerSmsValidationService");
		String ip="";
		 try {
			ip = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		System.out.println("ip:"+ip);
		CustomerSmsPo sms=service.sendValidationSms(phone, ip, SmsTemplate.VALIDATION_TEMPLATE);
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
	
	/**
	 * 客户注销清除session值
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/clearsession")
	@ResponseBody
	public String clearsession(HttpServletRequest request, HttpServletResponse response){
		request.getSession().invalidate();
		System.out.println("进入清除缓存方法");
		String	json="{'message':'清除缓存'}";
		return json;
	}
	
	/**
	 * 验证客户短信验证码
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/validateyzm")
	@ResponseBody
	public String validateyzm(HttpServletRequest request, HttpServletResponse response){
		System.out.println("验证客户短信验证码方法");
		String code=request.getParameter("yzm");
		String json="";
		CustomerSmsPo s=(CustomerSmsPo) request.getSession().getAttribute("customersms");
		if(s==null){
			json="{'message':'未发送短信'}";
		}else{
			if(!s.getValidationCode().equals(code)){
				json="{'message':'输入错误'}";
			}else{
				json="{'message':'输入正确'}";
			}
		}
		System.out.println("短信验证结果"+json);
		return json;
	}
	/**
	 * 验证用户是否注册过
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/validateuser")
	@ResponseBody
	public String validateuser(HttpServletRequest request, HttpServletResponse response){
		System.out.println("验证用户是否注册过方法");
		String username=request.getParameter("username");
		CustomerPo c=new CustomerPo();
		c.setUsername(username);
		CustomerPo customer=customerService.validate(c);
		String json="";
		if(customer!=null){
			json="{'message':'该用户已占用','names':'"+customer.getUsername()+"'}";
		}else {
			json="{'message':'该用户未占用'}";
		}
		System.out.println(json);
		return json;
	}
	
	/**
	 * 验证手机是否注册过
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/validatephone")
	@ResponseBody
	public String validatephone(HttpServletRequest request, HttpServletResponse response){
		String mobile=request.getParameter("phonenum");
		CustomerPo c=new CustomerPo();
		c.setMobile(mobile);
		CustomerPo customer=customerService.validatephone(c);
		String json="";
		if(customer!=null){
			json="{'message':'该手机已占用','names':'"+customer.getMobile()+"'}";
		}else {
			json="{'message':'该手机未占用'}";
		}
		System.out.println(json);
		return json;
	}
	
	/**
	 * 客户注册
	 * @param request
	 * @return
	 */
	@RequestMapping("/reg")
	@ResponseBody
	public String reg(HttpServletRequest request ){
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String phonenum=request.getParameter("phonenum");
		String email=request.getParameter("email");
		String smscode=request.getParameter("smscode");
		CustomerSmsPo s=(CustomerSmsPo) request.getSession().getAttribute("customersms");
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("spring-context.xml");
		CustomerSmsValidationService service = (CustomerSmsValidationService) applicationContext.getBean("customerSmsValidationService");
		String json="";
		if(s==null){
			return json="{'message':'未发送短信}";
		}
		int result=service.validateSms(s.getId(), phonenum, smscode);
		System.out.println("验证result:"+result);
		//验证是否成功 0成功 -1验证码不正确 -2验证码已过期
		if(result == -1){
			json="{'message':'验证码不正确'}";
		}else if(result == -2){
			json="{'message':'验证码已过期'}";
			request.getSession().removeAttribute("customersms");
		}else if(result == 0){
			CustomerPo c=new CustomerPo();
			c.setUsername(username);
			c.setPassword(password);
			c.setMobile(phonenum);
			c.setEmail(email);
			System.out.println(c);
			int num=customerService.insertreg(c);			
			if(num>0){
				request.getSession().removeAttribute("customersms");
				json="{'message':'注册成功'}";
			}else {
				System.out.println("注册失败");
				json="{'message':'注册失败'}";
			}
		}
		
		
		System.out.println(json);
		return json;
	}
	
	/**
	 * 验证忘记密码中手机是否注册过
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/validatelost")
	@ResponseBody
	public String validatelost(HttpServletRequest request, HttpServletResponse response){
		System.out.println("进入验证忘记密码手机验证");
		String mobile=request.getParameter("phonenum");
		CustomerPo c=new CustomerPo();
		c.setMobile(mobile);
		CustomerPo customer=customerService.validatelost(c);
		String json="";
		if(customer!=null){
			json="{'message':'该号已占用','names':'"+customer.getMobile()+"'}";
		}else {
			json="{'message':'该号为占用'}";
		}
		System.out.println(json);
		return json;
	}
	
	/**
	 * 忘记密码进行密码修改
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/updatepass")
	@ResponseBody
	public String updatepass(HttpServletRequest request, HttpServletResponse response){
		System.out.println("进行密码修改方法");
		String password=request.getParameter("password");
		String mess=request.getParameter("mess");
		String phone=request.getParameter("phonenum");
		CustomerSmsPo s=(CustomerSmsPo) request.getSession().getAttribute("customersms");
		System.out.println("短信session的值"+s);
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(
				"spring-context.xml");
		CustomerSmsValidationService service = (CustomerSmsValidationService) applicationContext
				.getBean("customerSmsValidationService");
		String json="";
		if(s==null){
			return json="{'message':'未发送短信'}";
		}
		int result=service.validateSms(s.getId(), phone,mess);
		System.out.println("验证短信结果result:"+result);
		//验证是否成功 0成功 -1验证码不正确 -2验证码已过期
		if(result == -1){
			json="{'message':'验证码不正确'}";
		}else if(result == -2){
			json="{'message':'验证码已过期'}";
			request.getSession().removeAttribute("customersms");
		}else if(result == 0){
		request.getSession().removeAttribute("customersms");
		CustomerPo c=new CustomerPo();
		c.setMobile(phone);
		c.setPassword(password);
		int num=customerService.updatepass(c);
		if(num>0){
			json="{'message':'找回成功'}";
		}else {
			json="{'message':'找回失败'}";
		}
		System.out.println(json);
		}
		return json;
	}
	
	/**
	 * 用户基本信息
	 * @throws Exception 
	 */
	@RequestMapping("/setBaseDate")
	@ResponseBody
	public String setBaseDate(HttpServletRequest request,HttpServletResponse response,ModelMap maps)throws Exception{
		boolean isMultipart = ServletFileUpload.isMultipartContent(request); 
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload uploader = new ServletFileUpload(factory);
		List<FileItem> list = uploader.parseRequest(request);
		for(FileItem item:list){
			if (item.isFormField()){
			// 处理普通表单域
			String field = item.getFieldName();//表单域名
			String value = item.getString("UTF-8");
			} else {
			//将临时文件保存到指定目录
			String fileName = item.getName();//文件名称
			String filepath = "${root}/static/images/user" + fileName;
			item.write(new File(filepath));//执行保存
			}
		}
		return null;
	}
	@RequestMapping("/changePwd")
	@ResponseBody
	public int updatePwd(HttpServletRequest request,HttpServletResponse response){
		CustomerPo customerPo = (CustomerPo)request.getSession().getAttribute("customer");
		String userName = customerPo.getUsername();
		String oldPwd = request.getParameter("oldPwd");
		String newPwd = request.getParameter("newPwd");
		String password = customerService.getPwdByUserName(userName);
		int i=0;
		if(password.equals(oldPwd)){
			customerPo.setPassword(newPwd);
			int resutl = customerService.updatePwd(customerPo);
			if(resutl>0){				
				i=0;
			}else{
				i=1;
			}
		}else{
			i=2;
		}

		return i;
	}
	
	@RequestMapping("/bindMobile")
	@ResponseBody
	public int bindMobile(HttpServletRequest request,HttpServletResponse response){
		CustomerPo customerPo = (CustomerPo)request.getSession().getAttribute("customer");
		String userName = customerPo.getUsername();
		String mobile = request.getParameter("mobile");
		Timestamp time = new Timestamp(System.currentTimeMillis());
		customerPo.setMobile(mobile);
		customerPo.setUpdateBy(userName);
		customerPo.setUpdateTime(time);
		System.out.println(customerPo.toString());
		int result = customerService.bindMobile(customerPo);
		System.out.println(result);
		int i=0;
		if(result<=0){
			i=1;
		}
		return i;
	}
}

