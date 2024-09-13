package com.beetmarket.review.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.review.service.ReviewService;
import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/review")
@Log4j
public class ReviewController {

	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService service;
	
	
	// 리뷰 리스트
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request) 
			throws Exception{
		log.info("list.do");
		PageObject pageObject = PageObject.getInstance(request);
		model.addAttribute("list", service.list(pageObject));
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		return "review/list";
	}
	
	

	// 리뷰 등록 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("writeForm.do");
		return "review/writeForm";
	}
	
	
	// 리뷰 등록처리
	@PostMapping("/write.do")
	public String write(ReviewVO vo, RedirectAttributes rttr) {
		log.info("write.do");
		log.info(vo);
		service.write(vo);
		
		// 처리 결과에 대한 메시지 처리
		rttr.addFlashAttribute("리뷰가 등록되었습니다");
		
		return "redirect:list.do";
	}

}