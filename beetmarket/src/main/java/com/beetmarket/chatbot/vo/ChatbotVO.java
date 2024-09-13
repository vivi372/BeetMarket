package com.beetmarket.chatbot.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ChatbotVO {
	private Long chatno;
	private Long roomno;
	private String member2;
	private String member1;
	private String content;
	private String sender;
	private String accepter;
	private Date acceptdate;
	private Date senddate;
}