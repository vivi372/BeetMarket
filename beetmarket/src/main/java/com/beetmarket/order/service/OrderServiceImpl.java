package com.beetmarket.order.service;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.order.mapper.OrderMapper;

import com.beetmarket.order.vo.OrderVO;
import com.beetmarket.order.vo.SearchVO;
import com.webjjang.util.page.PageObject;

import lombok.Setter;

@Service
@Qualifier("OrderServiceImpl")
public class OrderServiceImpl implements OrderService {
	
	@Setter(onMethod_ = @Autowired)
	OrderMapper mapper;

	@Override
	public List<OrderVO> orderList(PageObject pageObject,SearchVO searchVO) {
		
		//페이지의 최대 수를 가져오기
		pageObject.setTotalRow(mapper.totalRow(pageObject,searchVO));			
		
		
		return mapper.orderList(pageObject,searchVO);
	}

	@Override
	public Map<String, Object> writeFrom(Long[] goodsNos, Long[] optNos) {
		Map<String, Object> map = new HashMap<>();
		
		
		map.put("goodsList", mapper.getGoodsList(goodsNos));
		map.put("optList", mapper.getOptList(optNos));		
		
		return map;
	}

	@Override
	public Integer write(List<OrderVO> list) {
		
		return mapper.write(list);
	}
	
	

}
