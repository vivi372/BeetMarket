package com.beetmarket.member.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.member.service.MemberService;
import com.beetmarket.member.vo.LoginVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("member")
@Log4j
public class MemberController {

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService service; 
	
	@GetMapping("list.do")
	public String list(HttpServletRequest request , Model model) throws Exception{
		
		PageObject pageObject = PageObject.getInstance(request);
		
		model.addAttribute("list",service.list(pageObject));
		model.addAttribute("pageObject",pageObject);
		
		return "member/list";
	}
	
	
	
	@GetMapping("/loginForm.do")
	public String loginForm() {
		log.info("loginForm---------------");
		return "member/loginForm";
	}
	
	@PostMapping("/login.do")
	public String login(LoginVO vo , HttpSession session , RedirectAttributes rttr) {
		
		LoginVO loginVO = service.login(vo);
		
		if(loginVO == null) {
			rttr.addAttribute("msg","로그인 정보가 맞지않습니다 다시확인 부탁드립니다");
			return "redirect:member/loginForm.do";
		}
		
		session.setAttribute("login", loginVO);
		rttr.addAttribute("msg","로그인 완료");
		
		
		return null;
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session,RedirectAttributes rttr) {
		log.info("logout-------------------------------");
		session.removeAttribute("login");
		
		rttr.addAttribute("msg","로그아웃 완료");
	return null;	
	}
}
