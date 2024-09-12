package com.webjjang.pointshop.vo;

import lombok.Data;

@Data
public class PointShopVO {
	private Long goodsId;
	private String goodsName;
	private String goodsImage;
	private Long pointAmount;
	private Long goodsStock;
	private String category;
	private Integer discountRate;

}
