package com.beetmarket.review.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.review.service.ReviewService;
import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.file.FileUtil;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/review")
@Log4j
public class ReviewController {

	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService service;
	
	String path = "/upload/review";
	
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
	public String write(ReviewVO vo, HttpServletRequest request, RedirectAttributes rttr, MultipartFile reviewFile ) throws Exception {
		log.info("<<<----- 이미지 처리 ----------------->>");
		// 대표 이미지 처리
		vo.setReviewImage(FileUtil.upload(path, reviewFile, request));
		
		log.info("write.do");
		log.info(vo);
		service.write(vo);
		
		// 처리 결과에 대한 메시지 처리
		rttr.addFlashAttribute("리뷰가 등록되었습니다");
		
		return "redirect:list.do";
	}
	
	
	
	// 수정 폼
	@GetMapping("/updateForm.do")
	public String updateForm(Long no, Model model) {
		log.info("updateForm.do");
		model.addAttribute("vo", service.view(no, 0));
		
		return "review/updateForm";
	}
	
	
	
	// 수정 처리
	@PostMapping("/update.do")
	public String update(ReviewVO vo, RedirectAttributes rttr) {
		log.info("update.do");
		log.info(vo);
		if(service.update(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("수정 되었습니다.");
		else
			rttr.addFlashAttribute("업데이트가 되지 않았습니다");
		
		return "redirect:list.do?reivewNo=" + vo.getReviewNo();
	}
}