package com.beetmarket.pointshoporder.vo;

import java.util.List;

import lombok.Data;

@Data
public class PointShopOrderVO {
	
	private Long pointShopOrderNo;
	private Long goodsId;
	private Long amount;
	private Long pointShopBasketNo;
	private Long stockNo;
	private Long orderPoint;
	
	
	private List<PointShopOrderVO> list;

}
