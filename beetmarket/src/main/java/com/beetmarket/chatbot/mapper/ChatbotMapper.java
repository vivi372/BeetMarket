package com.beetmarket.chatbot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.chatbot.vo.ChatbotVO;

public interface ChatbotMapper {
	public List<ChatbotVO> list(String id);
	public List<ChatbotVO> history(Long roomno);
	public Long updateacceptdate(@Param("roomno") Long roomno, @Param("id") String id);
	public Long chating(ChatbotVO vo);
}