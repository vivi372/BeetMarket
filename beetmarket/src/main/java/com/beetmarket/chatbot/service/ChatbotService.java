package com.beetmarket.chatbot.service;

import java.util.List;

import com.beetmarket.chatbot.vo.ChatbotVO;

public interface ChatbotService {
	public List<ChatbotVO> list(String id);
	public List<ChatbotVO> history(Long roomno, String id);
	public Long chating(ChatbotVO vo);
}