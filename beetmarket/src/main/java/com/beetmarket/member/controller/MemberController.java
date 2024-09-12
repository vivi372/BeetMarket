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
import com.beetmarket.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService service; 
	
	//--- 회원 관리 리스트 ------------------------------------
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request , HttpSession session)
			throws Exception {
		log.info("list.do");
		
		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);
		
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("list", service.list(pageObject));
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		return "member/list";
	}
	
	//--- 회원 등급변경 처리 ------------------------------------
	@GetMapping("/changeGrade.do")
	public String changeGrade(MemberVO vo, RedirectAttributes rttr) {
		log.info("changeGrade.do.do");
		log.info(vo);
		if(service.changeGrade(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "회원 등급 수정이 되었습니다.");
		else
			rttr.addFlashAttribute("msg",
					"회원 관리 글수정이 되지 않았습니다. "
					+ "글번호나 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
		
		return "redirect:list.do";
	}
	// ----------------------[ 회원 맴버쉽 변경 ]------------------------------------
	@GetMapping("/changeMemeberShip.do")
	public String changeMemeberShip(MemberVO vo, RedirectAttributes rttr) {
		log.info("changeGrade.do.do");
		log.info(vo);
		if(service.changeMemeberShip(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "회원 맴버쉽 수정이 되었습니다.");
		else
			rttr.addFlashAttribute("msg",
					"회원 관리 글수정이 되지 않았습니다. "
							+ "글번호나 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
		
		return "redirect:list.do";
	}
	// ----------------------[ 회원 맴버쉽 변경 ]------------------------------------
	@GetMapping("/changeStatus.do")
	public String changeStatus(MemberVO vo, RedirectAttributes rttr) {
		log.info("changeGrade.do.do");
		log.info(vo);
		if(service.changeStatus(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "회원 맴버쉽 수정이 되었습니다.");
		else
			rttr.addFlashAttribute("msg",
					"회원 관리 글수정이 되지 않았습니다. "
							+ "글번호나 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
		
		return "redirect:list.do";
	}
	
	
	//--- 회원 관리 글보기 ------------------------------------
	@GetMapping("/view.do")
	public String view(Model model,String id) {
		log.info("view.do");
		
		model.addAttribute("vo", service.view(id));
		
		return "member/view";
	}
	
	//--- 회원 관리 글보기 ------------------------------------
	@GetMapping("/myView.do")
	public String myView(Model model,String id) {
		log.info("myView.do");
		
		model.addAttribute("homeVO", service.myView(id));
		
		return "member/myView";
	}
	
	
	// 로그인 폼
	@GetMapping("/loginForm.do")
	public String loginForm() {
		log.info("loginForm---------------");
		return "member/loginForm";
	}
	
	// 로그인 처리
	@PostMapping("/login.do")
	public String login(LoginVO vo , HttpSession session , RedirectAttributes rttr) {
		
		service.ConDateUpdate(vo);
		LoginVO loginVO = service.login(vo);
		
		if(loginVO == null) {
			rttr.addAttribute("msg","로그인 정보가 맞지않습니다 다시확인 부탁드립니다");
			return "redirect:member/loginForm.do";
		}
		
		session.setAttribute("login", loginVO);
		rttr.addAttribute("msg","로그인 완료");
		 
		
		return "redirect:main/main.do";
	}
	
	// 로그아웃
	@GetMapping("/logout.do")
	public String logout(HttpSession session,RedirectAttributes rttr) {
		log.info("logout-------------------------------");
		session.removeAttribute("login");
		
		rttr.addAttribute("msg","로그아웃 완료");
	return "redirect:main/main.do";	
	}
}
