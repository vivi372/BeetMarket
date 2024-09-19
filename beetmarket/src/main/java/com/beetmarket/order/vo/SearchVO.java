package com.beetmarket.order.vo;

import java.time.LocalDate;


import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SearchVO {
	private String goodsTitle;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate minDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate maxDate;
	private String orderState;
}
