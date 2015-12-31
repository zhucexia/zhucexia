package com.keji50.zhucexia.service.weixin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.CustomerAddrPoMapper;
import com.keji50.zhucexia.dao.mapper.GoodPoMapper;
import com.keji50.zhucexia.dao.mapper.SaleOrderDetailPoMapper;
import com.keji50.zhucexia.dao.mapper.SaleOrderPoMapper;
import com.keji50.zhucexia.dao.po.CustomerAddrPo;
import com.keji50.zhucexia.dao.po.GoodPo;
import com.keji50.zhucexia.dao.po.SalaOrderPo;
import com.keji50.zhucexia.dao.po.SaleOrderDetailPo;

@Service("WXOrderService")
public class WXOrderService {
	
	@Resource(name="saleOrderPoMapper")
	private SaleOrderPoMapper saleOrderPoMapper;
	@Resource(name="customerAddrPoMapper")
	private CustomerAddrPoMapper addrPoMapper;
	@Resource(name="goodPoMapper")
	private GoodPoMapper goodPoMapper;
	@Resource(name="saleOrderDetailPoMapper")
	private SaleOrderDetailPoMapper orderDetail;
	public List<HashMap<String,Object>> querryOrders(Map<String, Object> maps) {
		return saleOrderPoMapper.querryOrders(maps);
	}
	
	public HashMap<String,Object> getOrderById(int id){
		return saleOrderPoMapper.getOrderById(id);
	}
	
	/*生成订单，添加到数据库，1.添加地址到数据库，2.添加订单信息到数据库，3，添加商品详情信息到数据库*/
	public int buildOrders(SalaOrderPo saleOrder,CustomerAddrPo addrPo,String goodId) throws DataAccessException{
		/*添加地址*/
		//把其他的地址设置为非默认地址，新添加的地址设置为默认地址
		addrPoMapper.updateDefaultAddr();
		addrPoMapper.insert(addrPo);
		int id=addrPo.getId();
		if(id>0){
			/*设置地址*/
			saleOrder.setAddress(Integer.toString(id));
			/*查询商品信息*/
			GoodPo goodPo = goodPoMapper.getGoodById(Integer.parseInt(goodId));
			saleOrder.setRemark(goodPo.getName());
			saleOrder.setOrder_pic(goodPo.getPic());
			saleOrder.setType("1");
			saleOrder.setOrderstate("1");
			/*插入订单表信息*/
			saleOrderPoMapper.wxAdd(saleOrder);
			int saleId=saleOrder.getId();
			if(saleId>0){
				/*插入商品信息到订单详情表*/
				SaleOrderDetailPo detailPo=new SaleOrderDetailPo();
				detailPo.setOrder_id(saleId);
				/*查询订单号*/
				SalaOrderPo saleOrders=saleOrderPoMapper.getOrder(saleId);
				detailPo.setOrder_no(saleOrders.getOrder_no());
				detailPo.setGood_id(goodPo.getId());
				detailPo.setGood_name(goodPo.getName());
				detailPo.setGood_num(1);
				detailPo.setGood_price(saleOrder.getOrdermoney());
				detailPo.setGood_price_id(12);
				detailPo.setTotal_price(saleOrder.getOrdermoney());
				List<SaleOrderDetailPo> list=new ArrayList<SaleOrderDetailPo>();
				list.add(detailPo);
				int nu=orderDetail.inserts(list);
				if(nu>0){
					return saleId;
				}
				else{
					throw new RuntimeException();
				}
			}
			else{
				throw new RuntimeException();
			}
			
		}
		else{
			throw new RuntimeException();
		}
	}

	public SalaOrderPo getOrderPo(int parseInt) {
		return saleOrderPoMapper.getOrder(parseInt);

	}
	public int delOrder(String id) throws RuntimeException {
		
		int flag=saleOrderPoMapper.delOrder(id);
		if(flag>0){
			return flag;
		}
		else{
			throw new RuntimeException();
		} 
	}
	
	public int cancleOrder(String id) {
		int flag=saleOrderPoMapper.cancleOrder(id);
		if(flag>0){
			return flag;
		}
		else{
			throw new RuntimeException();
		} 
	}
	
	public int completeOrder(String id) {
		int flag=saleOrderPoMapper.completeOrder(id);
		if(flag>0){
			return flag;
		}else{
			throw new RuntimeException();
		}
	}
}
