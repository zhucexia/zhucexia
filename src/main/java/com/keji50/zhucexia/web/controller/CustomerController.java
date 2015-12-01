package com.keji50.zhucexia.web.controller;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.keji50.zhucexia.common.utils.MD5Utils;
import com.keji50.zhucexia.dao.po.CustomerEmailPo;
import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.dao.po.CustomerSmsPo;
import com.keji50.zhucexia.service.CustomerEmailValidationService;
import com.keji50.zhucexia.service.CustomerService;
import com.keji50.zhucexia.service.CustomerSmsValidationService;
import com.keji50.zhucexia.service.out.email.EmailTemplate;
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
	@Resource
	private CustomerSmsValidationService customerSmsValidationService;
	@Resource
	private CustomerEmailValidationService customerEmailValidationService;
	
	/**
	 * 客户登录
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/login")
	@ResponseBody
	public String login(HttpServletRequest request, HttpServletResponse response){
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
		String phone=request.getParameter("phonenum");
		String ip="";
		 try {
			ip = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		CustomerSmsPo sms=customerSmsValidationService.sendValidationSms(phone, ip, SmsTemplate.VALIDATION_TEMPLATE);
		String json="";
		if(sms!=null){
			request.getSession().setAttribute("customersms", sms);
			json="{'message':'发送成功','names':'"+sms.getValidationCode()+"'}";
		}else {
			json="{'message':'发送失败'}";
		}
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
		String code=request.getParameter("yzm");
		String mobile=request.getParameter("mobile");
		String json="";
		CustomerSmsPo s=(CustomerSmsPo) request.getSession().getAttribute("customersms");
		if(s==null){
			json="{'message':'未发送短信'}";
		}else{
			if(s.getValidationCode().equals(code)&&s.getMobile().equals(mobile)){
				json="{'message':'输入正确'}";
			}else{
				json="{'message':'输入错误'}";
			}
		}
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
		String json="";
		if(s==null){
			return json="{'message':'未发送短信}";
		}
		int result=customerSmsValidationService.validateSms(s.getId(), phonenum, smscode);
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
			int num=customerService.insertreg(c);			
			if(num>0){
				request.getSession().removeAttribute("customersms");
				json="{'message':'注册成功'}";
			}else {
				json="{'message':'注册失败'}";
			}
		}
		
		
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
		String password=request.getParameter("password");
		String mess=request.getParameter("mess");
		String phone=request.getParameter("phonenum");
		CustomerSmsPo s=(CustomerSmsPo) request.getSession().getAttribute("customersms");
		String json="";
		if(s==null){
			return json="{'message':'未发送短信'}";
		}
		int result=customerSmsValidationService.validateSms(s.getId(), phone,mess);
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
		}
		return json;
	}
	
	/**
	 * 用户基本信息
	 * @throws Exception 
	 */
	@RequestMapping("/setBaseDate")
	public String setBaseDate(HttpServletRequest request,HttpServletResponse response)throws Exception{
		MultipartHttpServletRequest req = (MultipartHttpServletRequest)request;
		MultipartFile file = null;
		if(req.getFileNames().hasNext()){
			file = req.getFile(req.getFileNames().next());
		}
		String fileName = file.getOriginalFilename();
		String path = request.getSession().getServletContext().getRealPath("/")+"/static/images/user/";
		File files = new File(path);
		if(!files.exists()){
			files.mkdir();
		}
		File tempFile = new File(path,new Date().getTime()+String.valueOf(fileName));
        if (!tempFile.getParentFile().exists()) {  
            tempFile.getParentFile().mkdir();  
        }  
        if (!tempFile.exists()) {  
            tempFile.createNewFile();  
        }
        file.transferTo(tempFile);
        String filePath= request.getSession().getServletContext().getContextPath()+"/static/images/user/"+tempFile.getName();
        String pic = tempFile.getName();
        CustomerPo customer = new CustomerPo();
        customer.setUsername(req.getParameter("username"));
        customer.setPic(pic);
        customer.setPic_id(pic);
        int flag = customerService.setBaseDate(customer);
        if(flag>0){
        	CustomerPo cust = (CustomerPo)request.getSession().getAttribute("customer");
        	cust.setPic(pic);
        }
		return "home";
	}
	
	/**
	 * 通过原密码修改密码
	 * @param request
	 * @param response
	 * @return
	 */
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
	
	/**
	 * 绑定手机号
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/bindMobile")
	@ResponseBody
	public int bindMobile(HttpServletRequest request,HttpServletResponse response){
		CustomerPo customerPo = (CustomerPo)request.getSession().getAttribute("customer");
		String userName = customerPo.getUsername();
		String mobile = request.getParameter("mobile");
		Timestamp time = new Timestamp(System.currentTimeMillis());
		CustomerPo cust = new CustomerPo();
		cust.setUsername(userName);
		cust.setMobile(mobile);
		cust.setUpdateBy(userName);
		cust.setUpdateTime(time);
		int result = customerService.bindMobile(cust);
		int i=0;
		if(result<=0){
			i=1;
		}
		customerPo.setMobile(mobile);
		return i;
	}
	
	/**
	 * 绑定邮箱发送验证邮件
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/sendEmail")
	@ResponseBody
	public int sendEmail(HttpServletRequest request,HttpServletResponse response){
		CustomerPo customer = (CustomerPo)request.getSession().getAttribute("customer");
		CustomerEmailPo customerEmail = new CustomerEmailPo();
		CustomerPo cust = new CustomerPo();
		int type = Integer.parseInt(request.getParameter("type"));
		String ip="";
		String email = request.getParameter("email");
		cust.setEmail(email);
		try {
			ip = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		if(type==1){
			cust.setId(0);
			customerEmail = customerEmailValidationService.sendEmail(cust, ip, EmailTemplate.RESET_PASSWORD_TEMPLATE);
		}else{
			int id = customer.getId();
			cust.setId(id);
		}
		
		
		if(type==0){
			customerEmail = customerEmailValidationService.sendEmail(cust, ip, EmailTemplate.VALIDATION_TEMPLATE);
		}
		
		if(type==2){
			customerEmail = customerEmailValidationService.sendEmail(cust, ip, EmailTemplate.UNBIND_TEMPLATE);
		}
		int i=0;
		if(customerEmail==null){
			i = 1;
		}else{
			/*customer = customerService.selectById(id);
			System.out.println(customer);
			request.getSession().setAttribute("customer",customer);*/
		}
		return i;
	}
	
	@RequestMapping("email/validate")
	public String validateEmail(HttpServletRequest request,HttpServletResponse response){
		int emailId = Integer.parseInt(request.getParameter("id"));
		String emailType = request.getParameter("type");
		String emailValidationCode = request.getParameter("validationCode");
		Map<String,Object> result = customerEmailValidationService.validateEmail(emailId, emailType, emailValidationCode);
		int resultCode = Integer.parseInt(result.get("resultCode").toString());
		String page="";
		String str="";
		switch(resultCode){
		case 0:
			String email = ((CustomerEmailPo)result.get("result")).getEmail();
			int customerId = ((CustomerEmailPo)result.get("result")).getCustomerId();
			if(emailType.equals("0")){
				customerService.bindEmail(email, customerId);			
				page= "validateSuccess";
			}
			if(emailType.equals("2")){
				customerService.delEmail(customerId);
				page="unbindSuccess";
			}
			if(emailType.equals("1")){
				page="changePwd";
			}
			break;
		case -1:
			page= "validateFailed1";
			break;
		case -2:
			page= "validateFailed2";
			break;
		}
		return page;
	}
	
	//通过邮箱修改密码时检查用户名邮箱是否存在
	@RequestMapping("/checkEmail")
	@ResponseBody
	public Boolean checkDate(HttpServletRequest request,HttpServletResponse response){
		String username=request.getParameter("username");
		String email=request.getParameter("email");
		CustomerPo customer = new CustomerPo();
		customer.setUsername(username);
		customer.setEmail(email);
		CustomerPo cust = customerService.checkEmail(customer);
		if(cust==null){
			return false;
		}else{
			return true;
		}
	}
	
}

