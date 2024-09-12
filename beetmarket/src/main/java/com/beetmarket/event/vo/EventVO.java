package com.beetmarket.event.vo;

import lombok.Data;

@Data
public class EventVO {
	private Long no;
	private String title;
	private String content;
	private String image;
	private String pw;
	private String id;
	private Long startDate;
	private Long endDate;
	private Long updateDate;
	private Long writeDate;
	private String status;
}