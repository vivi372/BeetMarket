package com.beetmarket.notice.vo;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private Long no;
	private String title;
	private String content;
	private Date startDate;
	private Date endDate;
	private Date writeDate;
	private Date updateDate;
	private String status;
}