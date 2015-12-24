package com.keji50.zhucexia.weixin.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.service.GoodService;

@Controller
@RequestMapping("/weixinindex")
public class IndexController {
	
	@Resource(name="goodService")
	private GoodService goodService;
	
	@RequestMapping("/goodList")
	public String indexGoods(HttpServletRequest request,HttpServletResponse response){
		List<GoodPo> goodList = goodService.getAllMeal();
		for(GoodPo good:goodList){
			String content = good.getDetail_content();
			int a =content.indexOf("img alt=\"\" src=\"");
			if(a>=0){
				int b =content.indexOf("\"", a+16);
				good.setDetail_content(content.substring(a+16, b));
			}
		}
		request.setAttribute("goodList", goodList);
		return "weixinpage/index";
	}
}
