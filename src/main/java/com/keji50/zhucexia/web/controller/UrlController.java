package com.keji50.zhucexia.web.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.service.GoodService;

@Controller
@RequestMapping("/")
public class UrlController {
	
	@Resource
	private GoodService goodService;
	
	@RequestMapping("")
	public String index(HttpServletRequest request,HttpServletResponse response){
		/*读取config配置文件里的配置*/
    	Properties prop = new Properties(); 
    	InputStream in = this.getClass() .getResourceAsStream("/config.properties" ); 
    	try {
			prop.load(in);
			System.out.println("------"+prop.get("fileupload.dir"));
		} catch (IOException e) {
			e.printStackTrace();
		} 	
    	System.out.println(System.getProperty("fileupload.dir"));
    	List<GoodPo> goodlist=goodService.showindexgood();
    	List<GoodPo> serverlist=goodService.showindexserver();
    	request.setAttribute("goodlist",goodlist);
    	request.setAttribute("serverlist", serverlist);
    	return "/index";
	}
	
	@RequestMapping("about")
	public String aboutUs(HttpServletRequest request,HttpServletResponse response){
		return "/about";
	}
	
	@RequestMapping("faq")
	public String FAQ(HttpServletRequest request,HttpServletResponse response){
		return "/qa";
	}
	
	@RequestMapping("good")
	public void goodList(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		RequestDispatcher rd = request.getRequestDispatcher("/good/goodlist");
		rd.forward(request, response);	
	}
}
