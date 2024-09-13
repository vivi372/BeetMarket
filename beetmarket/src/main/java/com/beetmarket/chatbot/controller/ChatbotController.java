package com.beetmarket.chatbot.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beetmarket.chatbot.service.ChatbotService;
import com.beetmarket.chatbot.vo.ChatbotVO;
import com.beetmarket.member.vo.LoginVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/chatbot")
public class ChatbotController {
	@Autowired
	@Qualifier("chatbotserviceimpl")
	private ChatbotService service;
	
	@GetMapping("/roomlist")
	public String roomlist(HttpServletRequest request, Model model) { //채팅방 목록
		HttpSession session=request.getSession();
		LoginVO loginvo=(LoginVO)session.getAttribute("login");
		String id=loginvo.getId();
		
		log.info("chatbotcontroller.roomlist()!!!!!!!!!!!!");
		
		List<ChatbotVO> roomlist=new ArrayList<>();
		roomlist=service.list(id);
		
		model.addAttribute("roomlist", roomlist);
		model.addAttribute("id", id);
		return "chatbot/roomlist";
	}
	
	@PostMapping("/history")
	public String history(Long roomno, HttpServletRequest request, Model model) { //채팅창
		HttpSession session=request.getSession();
		LoginVO loginvo=(LoginVO)session.getAttribute("login");
		String id=loginvo.getId();
		
//		List<ChatbotVO> historylist=new ArrayList<>();
//		historylist=service.history(roomno, id);
//		
//		ChatbotVO vo=historylist.get(0);
//		if(!vo.getSender().equals(id)) model.addAttribute("partner", vo.getSender());
//		if(!vo.getAccepter().equals(id)) model.addAttribute("partner", vo.getAccepter());
		
		
		//model.addAttribute("historylist", historylist);
		model.addAttribute("id", id);
		
		return "chatbot/history";
	}
	
	@PostMapping("/chating")
	public String chating(ChatbotVO vo) {
		service.chating(vo);
		
		return "redirect:history.do?roomno="+vo.getRoomno();
	}
	
	@GetMapping("/delete")
	public String delete() {
		return null;
	}
}