package com.beetmarket.order.service;



import java.util.List;
import java.util.Map;


import com.beetmarket.order.vo.OrderVO;
import com.beetmarket.order.vo.SearchVO;
import com.webjjang.util.page.PageObject;

public interface OrderService {
	
	//주문 리스트
	public List<OrderVO> orderList(PageObject pageObject,SearchVO searchVO);
	
	//주문 등록 폼
	public Map<String, Object> writeFrom(Long[] goodsNos,Long[] optNos);
	
	//주문 등록
	public Integer write(List<OrderVO> list);

}
