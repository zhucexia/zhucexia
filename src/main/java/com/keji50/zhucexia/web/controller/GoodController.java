package com.keji50.zhucexia.web.controller;



import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.service.GoodService;






/**
 * 
 * @author hc
 *
 */
@Controller
@RequestMapping(value = "/good")
public class GoodController {

	@Resource(name="goodService")
	private GoodService goodService;
	
	
	@RequestMapping("/showindexgood")
	@ResponseBody
	public void showindexgood(HttpServletRequest request, HttpServletResponse response){
		List<GoodPo> goodlist=goodService.showindexgood();
	}
	
	@RequestMapping("/showindexserver")
	@ResponseBody
	public void showindexserver(HttpServletRequest request, HttpServletResponse response){
		List<GoodPo> goodlist=goodService.showindexserver();
	}
	
	@RequestMapping("/showdetailgood")
	@ResponseBody
	public void showdetailgood(HttpServletRequest request, HttpServletResponse response){
		List<GoodPo> goodlist=goodService.showdetailgood();
	}
	
	@RequestMapping("/showdetailserver")
	@ResponseBody
	public void showdetailserver(HttpServletRequest request, HttpServletResponse response){
		List<GoodPo> serverlist=goodService.showdetailserver();
	}
	
	@RequestMapping("/goodlist")
	public String detail(HttpServletRequest request, HttpServletResponse response){
		String flag=request.getParameter("flag");
		if(flag!=null){
			request.setAttribute("flag", flag);
		}
		if(flag==null){
			request.setAttribute("flag", '1');
		}
		List<GoodPo> goodlist=goodService.showdetailgood();
		List<GoodPo> newgoodlist=goodService.newdetailgood();
		List<GoodPo> serverlist=goodService.showdetailserver();
		request.setAttribute("goodlist", goodlist);
		request.setAttribute("newgoodlist", newgoodlist);
		request.setAttribute("serverlist", serverlist);
		return "/productlist";
	}
	
	@RequestMapping("/goodsdetail")
	public String goodsdetail(HttpServletRequest request, HttpServletResponse response){
		String no=request.getParameter("id");
		int id=Integer.valueOf(no);
		List<HashMap<String, Object>> good=goodService.goodsdetail(id);
		request.setAttribute("good", good);
		return "/productdetail";
	}
}
