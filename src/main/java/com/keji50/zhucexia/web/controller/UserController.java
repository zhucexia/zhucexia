package com.keji50.zhucexia.web.controller;

import java.util.List;

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
    	List<GoodPo> goodlist=goodService.showindexgood();
    	List<GoodPo> serverlist=goodService.showindexserver();
    	request.setAttribute("goodlist",goodlist);
    	request.setAttribute("serverlist", serverlist);
    	return "/index";
    }

}
