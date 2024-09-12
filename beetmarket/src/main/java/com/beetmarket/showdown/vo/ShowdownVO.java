package com.beetmarket.showdown.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ShowdownVO {
	private Long no;
	private String title;
	private String content;
	private Date writeDate;
	private Date updateDate;
	private Long event_no;
}