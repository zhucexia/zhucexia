package com.keji50.zhucexia.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class CustomerAddrController {
	
	@RequestMapping("/toAddAddre")
	public String toAddAddre (){	
		return "/user/addAdress";	
	}
}
