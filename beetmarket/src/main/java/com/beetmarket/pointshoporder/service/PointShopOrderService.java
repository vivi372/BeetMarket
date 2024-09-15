package com.beetmarket.pointshoporder.service;

import java.util.List;

import com.beetmarket.pointshoporder.vo.PointShopOrderVO;

public interface PointShopOrderService {
	
	//포인트샵 주문 등록
	public boolean write(List<PointShopOrderVO> list,String id);

}
