package com.keji50.zhucexia.web.controller;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.service.GoodService;

/**
 * 
 * @author hc
 *
 */

@Controller
@RequestMapping(value = "/index")
public class UserController {

	@Resource(name="goodService")
	private GoodService goodService;
	
    @RequestMapping(value = "/show")
    public String index(HttpServletRequest request) {
    	//InputStream in = this.getClass().getResourceAsStream("test.properties");
    	//  Properties p = new Properties();
    	/*读取config配置文件里的配置*/
    	Properties prop = new Properties(); 
    	InputStream in = this.getClass() .getResourceAsStream("/config.properties" ); 
    	try {
			prop.load(in);
			System.out.println("------"+prop.get("fileupload.dir"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 	
    	System.out.println(System.getProperty("fileupload.dir"));
    	List<GoodPo> goodlist=goodService.showindexgood();
    	List<GoodPo> serverlist=goodService.showindexserver();
    	request.setAttribute("goodlist",goodlist);
    	request.setAttribute("serverlist", serverlist);
    	return "/index";
    }

}
