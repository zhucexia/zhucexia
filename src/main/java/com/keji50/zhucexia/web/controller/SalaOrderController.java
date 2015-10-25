package com.keji50.zhucexia.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.keji50.zhucexia.dao.po.CustomerAddrPo;
import com.keji50.zhucexia.dao.po.CustomerPo;
import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.dao.po.PaymentPo;
import com.keji50.zhucexia.dao.po.SalaOrderPo;
import com.keji50.zhucexia.dao.po.SaleOrderDetailPo;
import com.keji50.zhucexia.service.CustomerAddressService;
import com.keji50.zhucexia.service.GoodService;
import com.keji50.zhucexia.service.PaymentService;
import com.keji50.zhucexia.service.SaleOrderService;

@Controller
@RequestMapping(value = "/sales")
public class SalaOrderController {
	@Resource(name = "goodService")
	private GoodService   goodService;
	
	@Resource(name="paymentService")
	private PaymentService paymentService;
	
	@Resource(name="customerAddressService")
	private CustomerAddressService customerAddrService; 
	
	@Resource(name="saleOrderService")
	private SaleOrderService saleOrderService;
	
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
							int flagss=-1;
							if(relationMap.get(keys)!=null){
								System.out.println("============"+relationMap.get(keys).toString());
								flagss=relationMap.get(keys).toString().lastIndexOf(","+key+",");
							}
							if(flags<0&&flagss<0){
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
	/*返回购物车*/
	@RequestMapping("/returnCart")
	public String returnCart(){
		return "cart";
	}
	/*确认订单页面，选择支付方式*/
	@RequestMapping("/toOrderDetail")
	public String toOrderDetail(HttpServletRequest request){
		/*用户选择购买的产品的id*/
		String[] ids=request.getParameter("goodIds").split(",");
		/*商品总价格*/
		String totalPrice=request.getParameter("priceTotal").toString();
		System.out.println("totalPrice---"+totalPrice);
		/*根据产品id，从session里获取产品信息,存入到map中*/
		Map<String,Object> map=new HashMap<String,Object>();
		/*selectedGood,sesion里的产品数据*/
		Map<String,Object> mapGood=(Map<String, Object>) request.getSession().getAttribute("selectedGood");
		for(int i=0;i<ids.length;i++){
			map.put(ids[i], mapGood.get(ids[i]));
		}
		request.setAttribute("chooseGood", map);
		request.setAttribute("ids", request.getParameter("goodIds"));
		request.setAttribute("totalPrice", totalPrice);
		/*查询已存在的支付方式*/
		List<PaymentPo> list=paymentService.getPayMethod();
		/*返回数据到页面*/
		request.setAttribute("list", list);
		return  "orderDetail";
	}
	/*选择支付方式，生成订单*/
	@RequestMapping("/buildOrders")
	public String buildOrders(HttpServletRequest request) throws ParseException{
		/*添加收获地址----*/
		CustomerAddrPo customerAddrPo = new CustomerAddrPo();
		/*获取用户的id值*/
		CustomerPo customerPo= (CustomerPo) request.getSession().getAttribute("customer");
		System.out.println(customerPo.toString());
		customerAddrPo.setCustomer_id(customerPo.getId());
		/*地址，包括省份，和城市*/
		String addr=request.getParameter("newAddress[province]")+request.getParameter("newAddress[city]");
		customerAddrPo.setAddress(addr);
		/*地址地区*/
		String area=request.getParameter("newAddress[district]");
		customerAddrPo.setAreaRegion(area);
		/*街道*/
		String street=request.getParameter("newAddress[address]");
		customerAddrPo.setStreet(street);
		/*邮政编码*/
		String zip_code = request.getParameter("newAddress[zipcode]");
		customerAddrPo.setZip_code(zip_code);
		/*电话号*/
		String mobile=request.getParameter("newAddress[tel]");
		customerAddrPo.setTelephone(mobile);
		/*收货人*/
		String names=request.getParameter("newAddress[consignee]");
		customerAddrPo.setName(names);
		//默认地址
		customerAddrPo.setIs_default("1");
		/*备注说明*/
		String remark=request.getParameter("newAddress[tag_name]");
		customerAddrPo.setRemark(remark);
		//int flag=customerAddrService.insert(customerAddrPo);
		/*添加收货地址结束------*/
		
		/*开始生成订单--------*/	
		/*1.获取支付方式的信息----*/
		//确定用户所选择的支付方式
		String payMethod=request.getParameter("Checkout[pay_id]");
		System.out.println("进入了buildOrders方法--支付方式的id=="+payMethod);
	    //根据支付方式id，获取支付方式的具体信息
		PaymentPo payment=paymentService.getPayMethodById(payMethod);
		//声明一个订单对象
		SalaOrderPo    saleOrder= new SalaOrderPo();
		//设置订单的支付方式信息
		saleOrder.setPaymentid(Integer.parseInt(payMethod));
		saleOrder.setPaymentname(payment.getName());
		saleOrder.setPaymentcode(payment.getCode());
		/*支付方式信息完毕-------*/
		
		/*2.获取地址信息-----*/
		saleOrder.setAddress(addr+area+street);
		saleOrder.setZipcode(zip_code);
		saleOrder.setMobile(mobile);
		/*地址信息结束----*/
		
		/*3.客户信息-----*/
		saleOrder.setCustomerid(customerPo.getId());
		saleOrder.setCustomername(names);
		/*客户信息结束--------*/
		
		//订单确认时间
		Date date = new Date();
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		saleOrder.setOrderstatetime(sdf.parse(sdf.format(date)));
		
		//商品总价格
		String totalPrice =request.getParameter("totalPrice");
		saleOrder.setOrdermoney(Float.parseFloat(totalPrice));
		
		//订单状态 0：未确认、 1：已确认、 2：交易成功、 9：交易取消'
		saleOrder.setOrderstate("1");
		
		/*生成订单明细表开始------*/
		//实际购买的商品清单id
		String[] ids=request.getParameter("ids").toString().split(",");
		//从session里取出已选择商品清单
		Date dates = new Date();
		Map<String,Object> selectedGood=(Map<String, Object>) request.getSession().getAttribute("selectedGood");
		List<SaleOrderDetailPo> list= new ArrayList<SaleOrderDetailPo>();
		for(int i=0;i<ids.length;i++){
			SaleOrderDetailPo saleOrderDetailPo= new SaleOrderDetailPo();
			System.out.println(ids[i]);
			Map<String,Object> mapGood=(Map<String, Object>) selectedGood.get(ids[i]);
			saleOrderDetailPo.setGood_id(Integer.parseInt(ids[i]));
			saleOrderDetailPo.setGood_name(mapGood.get("name").toString());
			System.out.println("good_name---------"+mapGood.get("name").toString());
			saleOrderDetailPo.setGood_price(Float.parseFloat(mapGood.get("price_market").toString()));
			saleOrderDetailPo.setTotal_price(Float.parseFloat(mapGood.get("price_market").toString()));
			saleOrderDetailPo.setGood_num(1);
			saleOrderDetailPo.setGood_price_id(12);
			saleOrderDetailPo.setCreateBy(customerPo.getUsername());
			/*创建时间*/
			saleOrderDetailPo.setCreateTime(sdf.parse(sdf.format(dates)));	
			list.add(saleOrderDetailPo);
		}
		/*生成订单明细表结束------*/
		
		int flags=saleOrderService.buildOrder(saleOrder,customerAddrPo,list);
		System.out.println("id的值----"+flags);
		/*生成订单，插入到数据库中结束--------*/
		request.setAttribute("id", flags);
		/*选择支付方式，进行*/
		return "confirmOrder";
	}
	/*确认订单，生成订单*/
	@RequestMapping("/buildOrder")
	public String buildOrder(HttpServletRequest request) throws ParseException{
		/*获取用户的id值*/
		CustomerPo customerPo= (CustomerPo) request.getSession().getAttribute("customer");
		System.out.println(customerPo.toString());
		SalaOrderPo   saleOrder= new SalaOrderPo();
		/*1.客户信息-----*/
		saleOrder.setCustomerid(customerPo.getId());
		/*客户信息结束--------*/
		//订单状态 0：未确认、 1：已确认、 2：交易成功、 9：交易取消'
		saleOrder.setOrderstate("1");
		
		saleOrder.setCustomername(customerPo.getUsername());
		//订单确认时间
		Date date = new Date();
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		saleOrder.setOrderstatetime(sdf.parse(sdf.format(date)));
		//商品总价格
		String totalPrice =request.getParameter("priceTotal");
		saleOrder.setOrdermoney(Float.parseFloat(totalPrice));
		/*生成订单明细表开始------*/
		//实际购买的商品清单id
		String[] ids=request.getParameter("goodIds").toString().split(",");
		//从session里取出已选择商品清单
		Date dates = new Date();
		Map<String,Object> selectedGood=(Map<String, Object>) request.getSession().getAttribute("selectedGood");
		List<SaleOrderDetailPo> list= new ArrayList<SaleOrderDetailPo>();
		for(int i=0;i<ids.length;i++){
			SaleOrderDetailPo saleOrderDetailPo= new SaleOrderDetailPo();
			System.out.println(ids[i]);
			Map<String,Object> mapGood=(Map<String, Object>) selectedGood.get(ids[i]);
			saleOrderDetailPo.setGood_id(Integer.parseInt(ids[i]));
			saleOrderDetailPo.setGood_name(mapGood.get("name").toString());
			System.out.println("good_name---------"+mapGood.get("name").toString());
			saleOrderDetailPo.setGood_price(Float.parseFloat(mapGood.get("price_market").toString()));
			saleOrderDetailPo.setTotal_price(Float.parseFloat(mapGood.get("price_market").toString()));
			saleOrderDetailPo.setGood_num(1);
			saleOrderDetailPo.setGood_price_id(12);
			saleOrderDetailPo.setCreateBy(customerPo.getUsername());
			/*创建时间*/
			saleOrderDetailPo.setCreateTime(sdf.parse(sdf.format(dates)));	
			list.add(saleOrderDetailPo);
		}
		
		SalaOrderPo order=saleOrderService.addOrder(saleOrder,list);
		/*判断是否成功生成了订单和插入了订单详细*/
		if(order!=null){
			//成功插入数据
			/*查询已存在的支付方式*/
			List<PaymentPo> lists=paymentService.getPayMethod();
			/*返回数据到页面*/
			request.setAttribute("list", lists);
			/*返回订单id值*/
			request.setAttribute("saleOrder", order);
			/*查询用户的收获地址，默认地址*/
			CustomerAddrPo customerAddr=customerAddrService.query(customerPo.getId());
			//返回地址对象
			request.setAttribute("customerAddr", customerAddr);
			//订单详情
			Map<String,Object> maps=new HashMap<String,Object>();
			for(int i=0;i<ids.length;i++){
				maps.put(ids[i], selectedGood.get(ids[i]));
				/*从选中的seesion里去除这些已支付的*/
				selectedGood.remove(ids[i]);
			}                      
			request.setAttribute("chooseGood", maps);

			//跳转到支付页面
			return "orderDetail";		
		}
		else{
			//跳转到本页面
			return "cart";
		}
		
	}
	/*添加一个收货地址,在外部的文件js中写的，${root}不生效，而页面默认的路径是/zhucexia/sales/*** ,所以把添加方法放到saleOrderController里*/
	@RequestMapping("/addAddre")
	@ResponseBody
	public String AddAddre (HttpServletRequest request){	
		/*添加收获地址----*/
		CustomerAddrPo customerAddrPo = new CustomerAddrPo();
		/*获取用户的id值*/
		CustomerPo customerPo= (CustomerPo) request.getSession().getAttribute("customer");
		customerAddrPo.setCustomer_id(customerPo.getId());
		/*地址，包括省份，和城市*/
		String addr=request.getParameter("newProvince")+" "+request.getParameter("newCity")+" ";
		customerAddrPo.setAddress(addr);
		/*地址地区*/
		String area=request.getParameter("newCountry");
		customerAddrPo.setAreaRegion(area);
		/*街道*/
		String street=request.getParameter("newStreet");
		customerAddrPo.setStreet(street);
		/*邮政编码*/
		String zip_code = request.getParameter("newZipCode");
		customerAddrPo.setZip_code(zip_code);
		/*电话号*/
		String mobile=request.getParameter("newtel");
		customerAddrPo.setTelephone(mobile);
		/*收货人*/
		String names=request.getParameter("newConsignee");
		customerAddrPo.setName(names);
		/*备注说明*/
		String remark=request.getParameter("newTag");
		customerAddrPo.setRemark(remark);
		/*默认地址*/
		customerAddrPo.setIs_default("1");
		int flag=customerAddrService.insert(customerAddrPo);
		System.out.println(customerAddrPo.toString());
		/*添加收货地址结束------*/
		if(flag>0){
			return "{message:"+flag+"}";
		}
		else{
			return "{message:false}";
		}
	}
	
}
