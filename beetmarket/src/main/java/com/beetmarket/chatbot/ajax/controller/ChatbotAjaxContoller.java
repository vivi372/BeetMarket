package com.beetmarket.chatbot.ajax.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.beetmarket.chatbot.service.ChatbotService;
import com.beetmarket.chatbot.vo.ChatbotVO;
import com.beetmarket.member.vo.LoginVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/chatajax")
public class ChatbotAjaxContoller {
	@Autowired
	@Qualifier("chatbotserviceimpl")
	public ChatbotService service;
	
	@GetMapping("/history.do")
	public String history(HttpServletRequest request, Long roomno, Model model) {
		List<ChatbotVO> list=new ArrayList<>();
		list=service.history(roomno, "test");
		
		HttpSession session=request.getSession();
		LoginVO loginvo=(LoginVO)session.getAttribute("login");
		String id=loginvo.getId();
		
		
		ChatbotVO vo=list.get(0);
		if(!vo.getSender().equals(id)) model.addAttribute("partner", vo.getSender());
		if(!vo.getAccepter().equals(id)) model.addAttribute("partner", vo.getAccepter());
		
		model.addAttribute("histroylist", list);
		
		return "chatbot/historyajax";
	}
}