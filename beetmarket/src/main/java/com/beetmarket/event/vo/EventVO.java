package com.beetmarket.event.vo;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EventVO {
	private Long no;
	private String title;
	private String content;
	private String image;
	private String pw;
	private String id;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Long startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Long endDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Long updateDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Long writeDate;
	private String status;
}