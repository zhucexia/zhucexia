package com.keji50.zhucexia.weixin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.service.GoodService;

@Controller
@RequestMapping("weixinGood")
public class WXGoodController {
	
	@Resource(name="goodService")
	private GoodService goodService;
	
	@RequestMapping("goodDetail")
	public String goodDetail(HttpServletRequest request,HttpServletResponse response){
		int id = Integer.parseInt(request.getParameter("id"));
		GoodPo good = goodService.getGoodById(id);
		request.setAttribute("good", good);
		return "weixinpage/detail";
	}
}
