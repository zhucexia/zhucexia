package com.keji50.zhucexia.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.service.GoodService;

@Controller
@RequestMapping(value = "/sales")
public class SalaOrderController {
	@Resource(name = "goodService")
	private GoodService   goodService;
	/*跳转到订单上传页*/
	@RequestMapping("/toBuildOrder")
	public String toBuildOrder(HttpServletRequest request){
		/*获取传递过来的商品的id值*/
		String id = request.getParameter("id");
		System.out.println("-----------"+id);
		/*获取单个商品的信息，以及和它关联的商品信息*/
		//查询单个商品信息,
		Map<String,Object> map =  goodService.getGood(id);
		//查询关联商品的信息
		List<Map<String,Object>> list = goodService.getRelationGood(id);
		/*把选择的商品信息，放入已选择里面,并且以商品信息id作为key值，商品信息作为value存入到一个map中去*/
		//判断session 里是否有已选择变量
		if(request.getSession().getAttribute("selectedGood")!=null){
			/*存在已选择变量，在加入新的已选择good的时候，判断该good是否已经被加入购买中*/
			Map<String,Object> selectedGood=(Map<String,Object>)request.getSession().getAttribute("selectedGood");
			/*如果不存在就添加进去*/
			if(map.get(map.get("id").toString())==null){
				selectedGood.put(map.get("id").toString(),map);
				/*更新session里面，selectedGood的内容*/
				request.getSession().setAttribute("selectedGood", selectedGood);
				}
			Map<String,Object> unSelectedGood=(Map<String,Object>)request.getSession().getAttribute("unSelectedGood");
			/*判断是否在为推送里面存在，如果存在的话要删除推送里该商品的信息*/
			if(unSelectedGood.get(id)!=null){
				unSelectedGood.remove(id);
			}
			}
		else{
			Map<String,Object> selectedGood=new HashMap<String,Object>();
			selectedGood.put(map.get("id").toString(), map);
			/*更新session里面，selectedGood的内容*/
			request.getSession().setAttribute("selectedGood", selectedGood);
		}
		//判断seesion里面是否存在未添加这个变量
		if(request.getSession().getAttribute("unSelectedGood")!=null){
		/*把没有选择商品信息，放入未选择里面，且以商品信息id做为key值，商品信息作为value值存入到一个map中去*/
		Map<String,Object> unSelectedGood=(Map<String,Object>)request.getSession().getAttribute("unSelectedGood");
		/*遍历查询出的关联*/
		Map<String,Object> selGood=(Map<String, Object>) request.getSession().getAttribute("selectedGood");
		for(Map<String,Object> maps:list){
			if(unSelectedGood.get(maps.get("id").toString())==null&&selGood.get(maps.get("id").toString())==null)
				unSelectedGood.put(maps.get("id").toString(), maps);
			}
		request.getSession().setAttribute("unSelectedGood", unSelectedGood);
		}
		else{
			Map<String,Object> unSelectedGood=new HashMap<String,Object>();
			/*遍历查询出的关联*/
			for(Map<String,Object> maps:list){		
					unSelectedGood.put(maps.get("id").toString(), maps);
			}
			request.getSession().setAttribute("unSelectedGood", unSelectedGood);
		}
		/*存储该商品和其关联产品件的关联关系*/
		if(request.getSession().getAttribute("relationGood")!=null){
			System.out.println("relationGood已经创建？");
			/*且以商品信息id做为key值，关联商品id拼接字符作为value值，*/
			Map<String,Object> relationGood=(Map<String,Object>)request.getSession().getAttribute("relationGood");
			/*遍历查询出的关联*/
			if(relationGood.get(id)==null){
				/*拼接关联该商品的其他商品id值*/
			String relationIds=",";
			for(Map<String,Object> maps:list){
				relationIds+=maps.get("id").toString()+",";	
				}
			relationGood.put(id, relationIds);
			request.getSession().setAttribute("relationGood", relationGood);
			}
		}
		else{
				Map<String,Object> relationGood=new HashMap<String,Object>();
				/*遍历查询出的关联*/
				/*拼接关联该商品的其他商品id值*/
				String relationIds=",";
				for(Map<String,Object> maps:list){
				relationIds+=maps.get("id").toString()+",";	
				}
				relationGood.put(id, relationIds);
				request.getSession().setAttribute("relationGood", relationGood);
			} 
		System.out.println("进入了SalaOrderController的方法---toBuildOrder");
		return "cart";
	}
	
	/*页面上删除商品后，清除session里的相应的商品信息，同时清除该商品关联的推送的其他商品的信息*/
	@RequestMapping("/clearSessionGood")
	public String clearSessionGood(String ids,HttpServletRequest request ){
		String[] idStr=ids.split(",");
		for(int n=0;n<idStr.length;n++){
			String id=idStr[n];
		/*从session里获取当前已选择的商品信息，是否要动态的删除与（如果确定是基本套餐的话）该基本套餐关联的其他的服务*/
		Map<String,Object> maps=(Map<String,Object>)request.getSession().getAttribute("selectedGood");
		System.out.println("进入了clearSessionGood---id"+id);
		//从session里获取为选择的商品
		Map<String,Object> mapUnselected=(Map<String,Object>)request.getSession().getAttribute("unSelectedGood");
		/*1判断该商品是服务，还是基本套餐，如果是基本套餐，删除与之关联的推送服务
		 * 2 判断该服务是否包含在其他的已选择的基本套餐之内，如果包含就不删除，反之删除
		 * */
		//获取该商品类型
		System.out.println(maps.get(id));
		String goodType=((Map<String,Object>)maps.get(id)).get("good_type_name").toString();

		if(goodType.equals("套餐")){
		//从session里的商品关系配置relationGood中查询，该id是否为主键，来判断它是否直接从数据库中查询出了商品配置关系
		Map<String,Object> map=(Map<String,Object>)request.getSession().getAttribute("relationGood");
	    if(map.get(id)!=null){
		//获取该商品的配置关系
		String[] relations=map.get(id).toString().split(",");
		//遍历商品配置关系
		//标示是否只剩下当前一个配置关系
		int fl=0;
		for(String key:map.keySet()){
			if(!key.equals(id)){
				/*分别获取每个关联商品，然后在其他关联关系中查找是否存在*/
				for(int i=0;i<relations.length;i++){
					int flag=map.get(key).toString().lastIndexOf(","+relations[i]+",");
					if(flag<0){
						mapUnselected.remove(relations[i]);
					}
				}
	             fl++;
				}
			}
		if(fl==0){
			for(int i=0;i<relations.length;i++){
					mapUnselected.remove(relations[i]);
			}
		}
		map.remove(id);
		System.out.println("到了map是的地方！");
	    }
		//清除session里的值，unSelectedGood
		//request.getSession().setAttribute("unSelectedGood", mapUnselected);
		//删除该基本套餐的配置关系
		maps.remove(id);
		if(maps.get(id)!=null){
			System.out.println("selectedGood session中没有删除，当前的被选商品！");
		}
		//request.getSession().setAttribute("selectedGood",maps);
		
		}
		else if(goodType.equals("服务")){
		/*选中的要删除的商品如果是一项服务：
		 * 1,如果是从数据库里查询出来的服务，则要关联删除其所推送的基本套餐
		 * 2，如果是通过推送而添加的服务，则要判断是否仍然有其他的基本套餐需要该服务，然后把它放入未选择的session里*/
		//从session里的商品关系配置relationGood中查询，该id是否为主键，来判断它是否直接从数据库中查询出了商品配置关系
		Map<String,Object> map=(Map<String,Object>)request.getSession().getAttribute("relationGood");
		if(map.get(id)!=null){
			 //获取该商品的配置关系
			String[] relations=map.get(id).toString().split(",");
			int fl=0;
			for(String key:map.keySet()){
				if(!key.equals(id)){
					/*分别获取每个关联商品，然后在其他关联关系中查找是否存在*/
					for(int i=0;i<relations.length;i++){
						int flag=map.get(key).toString().lastIndexOf(","+relations[i]+",");
						if(flag<0){
							mapUnselected.remove(relations[i]);
						}
					}
		             fl++;
					}
			}
			/*删除未选择的基本套餐*/
			if(fl==0){
				for(int i=0;i<relations.length;i++){
					mapUnselected.remove(relations[i]);
			}
			}
			//删除配置
			maps.remove(id);
			map.remove(id);
			//request.getSession().setAttribute("relationGood",map);
		}else{
			//推送过来的产品
			//遍历商品配置关系
			boolean bool=false;
			for(String key:map.keySet()){
					/*分别获取每个关联商品，然后在其他关联关系中查找是否存在*/
					int flag=map.get(key).toString().lastIndexOf(","+id+",");
					if(flag>0){
						bool=true;
					}
						
				}
			//
			if(bool){
				//删除已选择商品中该商品信息，添加未选择商品中该商品信息
				Map<String,Object> goodPo= (Map<String, Object>) maps.get(id);
				maps.remove(id);
				mapUnselected.put(id, goodPo);
				//request.getSession().setAttribute("unSelectedGood", mapUnselected);
				//request.getSession().setAttribute("selectedGood",maps);
			}
			else{
				//直接删除已选择中该商品信息
				maps.remove(id);
				//request.getSession().setAttribute("selectedGood",maps);
			}
			
		}
		
		}
		}
		 return "cart";
		
	}
	/*页面上推送的商品加入到购物车中*/
	@RequestMapping("/addGood")
	public String addGood(HttpServletRequest request,String id){
		/*获取购物车中商品*/
		Map<String,Object> selectedGood= (Map<String, Object>) request.getSession().getAttribute("selectedGood");
		/*获取推送的商品*/
		Map<String,Object> unSelectedGood=(Map<String, Object>) request.getSession().getAttribute("unSelectedGood");
	   /*被选中的推送商品信息*/
		Map<String,Object> good=(Map<String, Object>) unSelectedGood.get(id);
	   /*加入商品到购物车*/
		selectedGood.put(id, good);
	   /*推送列表删除*/
		unSelectedGood.remove(id);
		return "cart";
	}
	/*生成购买订单*/
	@RequestMapping(value="/buildOrder",method = RequestMethod.POST)
	@ResponseBody
	public String bulidOrder(HttpServletRequest request){
		/*判断添加的产品是否符合商品配置规则：
		 * 1：判断是否有一个基本套餐，不可以只有服务，而没有套餐
		 * 2：判断添加在订单里的服务，是否属于当前的套餐，
		 * */
		/*返回json数据格式数据*/
		System.out.println("aaaaaaaaa");
		String names="{name:";
		String myname="";
		/*查询所有商品的配置关系*/
		List<Map<String,Object>> list=goodService.getRelations();
		/*把配置关系存放到map中去*/
		Map<String,Object> relationMap=new HashMap<String,Object>();
		for(Map<String,Object> map:list){
			String good_id=map.get("good_id").toString();
			String related_good_id=map.get("related_good_id").toString();
			if(relationMap.get(good_id)==null){
				relationMap.put(good_id, ","+related_good_id+",");
			}
			else{
				String values=relationMap.get(good_id).toString();
				relationMap.put(good_id, values+related_good_id+",");
			}
		}
		System.out.println("bbbbbbbbbbbbbb");
		/*遍历selectedGood session里存放的值，找出基本套餐*/
		Map<String,Object> selectedGood=(Map<String, Object>) request.getSession().getAttribute("selectedGood");
		for(String key:selectedGood.keySet()){
			Map<String,Object> mapGood=(Map<String, Object>) selectedGood.get(key);
			String good_type_name=mapGood.get("good_type_name").toString();
			if(good_type_name.equals("服务")){
				System.out.println("ccccccccccccccccc");
				/*获取服务的配置关系*/
				if(relationMap.get(key)!=null){
					String serviceRelation=(String) relationMap.get(key);
					/*遍历选中列表中国是否存在它关联的套餐*/
					int fls=0;
					for(String keys:selectedGood.keySet()){
						System.out.println("遍历选中列表中国是否存在它关联的");
						Map<String,Object> mapGoods=(Map<String, Object>) selectedGood.get(keys);
						String good_type_names=mapGoods.get("good_type_name").toString();
						if(good_type_names.trim().equals("套餐")){
							fls++;
							/*该服务是否选中的该套餐的配置*/
							int flags=serviceRelation.lastIndexOf(","+keys+",");
							/*该基本套餐是否有该该服务的配置*/
							int flagss=0;
							if(relationMap.get(keys)!=null){
								flagss=relationMap.get(keys).toString().lastIndexOf(","+key+",");
							}
							if(flags<0&&flagss<=0){
								System.out.println(keys+"代表的服务没有绑定基本套餐，请删除该项服务！");
								myname+=mapGood.get("name").toString()+",";
							}
						}
				}
					if(fls==0){
						System.out.println("------"+mapGood.get("name"));
						myname+=mapGood.get("name").toString()+",";
					}
				}
				else{
					int flags=0;
					for(String keys:selectedGood.keySet()){
						Map<String,Object> mapGoods=(Map<String, Object>) selectedGood.get(keys);
						String good_type_names=mapGoods.get("good_type_name").toString();
						if(good_type_names.equals("套餐")){
							String  relations=relationMap.get(keys).toString();
							System.out.println("relations==="+relations+"====key=="+key);
							int bool=relations.lastIndexOf(","+key+",");
							if(bool<0){
								myname+=mapGood.get("name").toString()+",";
							}
							flags++;
						}
					}
					if(flags==0){
						System.out.println(key+"代表的服务没有绑定基本套餐，请删除该项服务");
						myname+=mapGood.get("name").toString()+",";
					}
				}
			}
			
		}
		if(myname.equals("")){
			myname="true";
		}else{
			myname=myname.substring(0,myname.lastIndexOf(","));
		}
		
		names+="\""+myname+"\""+"}";
		System.out.println(names);
		return names;
	}
	/*@Resource(name = "salaorderservice")
	private SalaOrderService salaorderservice;
	
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request) {
		return "salaorder/list";
	}
	
	
	@RequestMapping(value = "/getorderList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> listByCondition(HttpServletRequest request) {
		String requestJson = WebUtils.getRequestPayload(request);
		Map<String, Object> conditions = JSONObject.parseObject(requestJson);
		Page<SalaOrderPo> page = salaorderservice.getorderByConditions(conditions);
		for (SalaOrderPo salaOrderPo : page) {
			System.out.println(salaOrderPo.getOrderstate());
			if(salaOrderPo.getOrderstate().equals("0")){
				salaOrderPo.setOrderstate("未确认");
			}else if(salaOrderPo.getOrderstate().equals("1")) {
				salaOrderPo.setOrderstate("已确认");
			}else if(salaOrderPo.getOrderstate().equals("2")){
				salaOrderPo.setOrderstate("交易成功");
			}else{
				salaOrderPo.setOrderstate("交易取消");
			}
		}
		System.out.println("执行查询"+page.size());
		return PageUtils.pageToMap(page);
	}
	
	@RequestMapping(value = "/deletesalaorder", method = RequestMethod.POST)	
	@ResponseBody
	public JSONObject deletesalaorder(HttpServletRequest request) {
		System.out.println(request.getParameter("sno"));
		int id=Integer.valueOf(request.getParameter("sno"));
		int result=salaorderservice.deletesalaorder(id);
		JSONObject json;
		if(result>0){
			json=JSONObject.parseObject("{'message':'删除成功'}");
		}else{
			json=JSONObject.parseObject("{'message':'删除失败'}");
		}
		
		return json;
	}
	@RequestMapping(value = "/add")
	public String add(HttpServletRequest request) {
		return "salaorder/add";
	}
	
	
	@RequestMapping(value = "/getorder", method = RequestMethod.POST)	
	public String getorder(HttpServletRequest request) {
		System.out.println("编辑id："+request.getParameter("id"));
		int id=Integer.valueOf(request.getParameter("id"));
		SalaOrderPo order=salaorderservice.getorder(id);
		if(order.getOrderstate().equals("0")){
			order.setOrderstate("未确认");
		}else if(order.getOrderstate().equals("1")) {
			order.setOrderstate("已确认");
		}else if(order.getOrderstate().equals("2")){
			order.setOrderstate("交易成功");
		}else{
			order.setOrderstate("交易取消");
		}
		request.setAttribute("order", order);
		//System.out.println(cus.getUsername());
		return "salaorder/update";
	}
	
	@RequestMapping(value = "/updateorder")	
	@ResponseBody
	public String updateorder(HttpServletRequest request,SalaOrderPo cust) {
		System.out.println("进入修改controller,名为："+cust.getOrderstate());
		int result=salaorderservice.updateorder(cust);
		String mess="";
		if(result>0){
			mess="修改成功";
		}else{
			mess="修改成功";	
		}
		return mess;
	}*/
}
