package com.beetmarket.order.vo;



import lombok.Data;

@Data
public class OrderVO {
	private long orderNo;
	private long orderPrice;
	private long dlvyCharge;
	private String orderState;
	private String cancleReason;
	private String id;
	private String name;
	private String memberTel;
	private String payWay;
	private String payDetail;
	private String orderDate;
	private String confirmDate;
	private String dlvyMemo;
	private long dlvyAddrNo;
	private long postNo;
	private String recipient;
	private String dlvyName;
	private String tel;
	private String addr;
	private String addrDetail;
	private long goodsNo;
	private String goodsTitle;
	private String goodsImage;
	private String goodsPublicher;
	private long orderOptNo;
	private String optName;
	private long optNo;
	private long amount;	
	private String paymentKey;
	
}
