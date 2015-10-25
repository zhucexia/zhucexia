package com.keji50.zhucexia.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.UncategorizedDataAccessException;
import org.springframework.stereotype.Service;

import com.keji50.zhucexia.dao.mapper.CustomerAddrPoMapper;
import com.keji50.zhucexia.dao.mapper.PaymentPoMapper;
import com.keji50.zhucexia.dao.mapper.SaleOrderDetailPoMapper;
import com.keji50.zhucexia.dao.mapper.SaleOrderPoMapper;
import com.keji50.zhucexia.dao.po.CustomerAddrPo;
import com.keji50.zhucexia.dao.po.PaymentPo;
import com.keji50.zhucexia.dao.po.SalaOrderPo;
import com.keji50.zhucexia.dao.po.SaleOrderDetailPo;

@Service(value="saleOrderService")
public class SaleOrderService {
     
	@Resource(name="saleOrderPoMapper")
	private SaleOrderPoMapper  saleOrderPoMapper;
	@Resource(name="customerAddrPoMapper")
    private CustomerAddrPoMapper customerAddrPoMapper;
	@Resource(name="saleOrderDetailPoMapper")
	private SaleOrderDetailPoMapper saleOrderDetailPoMapper;
	@Resource(name="paymentPoMapper")
	private PaymentPoMapper paymentPoMapper;
	public int  buildOrder(SalaOrderPo saleOrder, CustomerAddrPo customerAddrPo, List<SaleOrderDetailPo> list) throws DataAccessException
	{
		/*插入收货地址信息*/
		int addrFlag=customerAddrPoMapper.insert(customerAddrPo);
		/*判断收货地址是否添加成功，不成功，回滚事务*/
		if(addrFlag>0){
			/*插入订单信息,返回订单的id值*/
			int orderFlag=saleOrderPoMapper.bulidOrder(saleOrder);
			if(orderFlag>0){
				int id=saleOrder.getId();
				//查询订单的信息
				saleOrder=saleOrderPoMapper.getOrder(id);
				//把订单号和记录id放入到订单详情中
				for(int i=0;i<list.size();i++){
					SaleOrderDetailPo saleOrderDel=list.get(i);
					saleOrderDel.setOrder_id(saleOrder.getId());
					saleOrderDel.setOrder_no(saleOrder.getOrder_no());
					list.set(i, saleOrderDel);
				}
				int detail=saleOrderDetailPoMapper.inserts(list);
				if(detail>0){
					System.out.println("detail======="+detail);
					return id;
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
	public SalaOrderPo getOrder(int orderId) {
         return saleOrderPoMapper.getOrder(orderId);
	}
	
	/*生成订单，用户确认订单*/
	public SalaOrderPo addOrder(SalaOrderPo saleOrder, List<SaleOrderDetailPo> list) {
		/*插入订单信息,返回订单的id值*/
		int orderFlag=saleOrderPoMapper.addOrder(saleOrder);
		if(orderFlag>0){
			int id=saleOrder.getId();
			//查询订单的信息
			saleOrder=saleOrderPoMapper.getOrder(id);
			//把订单号和记录id放入到订单详情中
			for(int i=0;i<list.size();i++){
				SaleOrderDetailPo saleOrderDel=list.get(i);
				saleOrderDel.setOrder_id(saleOrder.getId());
				saleOrderDel.setOrder_no(saleOrder.getOrder_no());
				list.set(i, saleOrderDel);
			}
			int detail=saleOrderDetailPoMapper.inserts(list);
			if(detail>0){
				System.out.println("detail======="+detail);
				return saleOrder;
			}
			else{
				throw new RuntimeException();			
			}
		}
		else{
			throw new RuntimeException();
		}
	}
	
		//用户支付完成，修改订单状态
	public String update(String order_no,String payMethod,String trade_no) throws ParseException,DataAccessException{
		//查询订单的信息
		SalaOrderPo saleOrder=saleOrderPoMapper.getOrderByno(order_no);
		//更改订单状态
		saleOrder.setOrderstate("2");
		if(!saleOrder.getPaymentcode().equals("cash_no_delivery")){
			saleOrder.setPaymentstate("1");
		}
		if(payMethod.equals("0.00")){
			saleOrder.setOrderstate("1");
		}
		//支付宝订单号
		if(trade_no!=null){
			saleOrder.setAlipaytradeno(trade_no);
		}
		
		//付款时间
		Date date = new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		saleOrder.setPaymenttime(sdf.parse(sdf.format(date)));
		int flag=saleOrderPoMapper.update(saleOrder);
		if (flag>0){
			return "success";
		}
		else{
			throw new RuntimeException();
		}
	}
	public int updateAddr(SalaOrderPo saleOrder) throws RuntimeException {
		int flag=saleOrderPoMapper.updateAddr(saleOrder);
		if(flag>0){
			return flag;
		}
		else{
			throw new RuntimeException();
		} 
	}
}
