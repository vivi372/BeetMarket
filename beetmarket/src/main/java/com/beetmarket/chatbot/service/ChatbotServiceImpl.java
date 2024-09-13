package com.beetmarket.chatbot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.beetmarket.chatbot.mapper.ChatbotMapper;
import com.beetmarket.chatbot.vo.ChatbotVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
@Qualifier("chatbotserviceimpl")
public class ChatbotServiceImpl implements ChatbotService {
	@Autowired
	private ChatbotMapper mapper;

	@Override
	public List<ChatbotVO> list(String id) {
		return mapper.list(id);
	}

	@Override
	@Transactional
	public List<ChatbotVO> history(Long roomno, String id) {
		mapper.updateacceptdate(roomno, id);
		return mapper.history(roomno);
	}

	@Override
	public Long chating(ChatbotVO vo) {
		return mapper.chating(vo);
	}
	
	
}