package com.beetmarket.faq.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beetmarket.faq.service.FaqService;
import com.beetmarket.faq.vo.FaqCateVO;
import com.beetmarket.faq.vo.FaqVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/faq")
public class FaqController {
	
	@Autowired
	@Qualifier("faqserviceimpl")
	private FaqService service;
	
	@GetMapping("/list.do")
	public String list(Model model, PageObject po) {
		List<FaqVO> list=new ArrayList<>();
		
		list=service.list(po);
		model.addAttribute("list", list);
		
		return "faq/list";
	}
	
	@GetMapping("/view.do")
	public String view(Model model, Long faqno, Long hit) {
		FaqVO vo=new FaqVO();
		vo=service.view(faqno, hit);
		
		model.addAttribute("vo", vo);
		
		return "faq/view";
	}
	
	@GetMapping("/writeform.do")
	public String writeform(Model model) {
		//faq 카테고리 고르기
		List<FaqCateVO> catelist=new ArrayList<>();
		catelist=service.getcate();
		
		model.addAttribute("catelist", catelist);
		
		return "faq/writeform";
	}
	@PostMapping("/write.do")
	public String write(FaqVO vo) {
		service.write(vo);
		return "redirect:list.do";
	}
	
	@GetMapping("/updateform.do")
	public String updateform(Model model, Long faqno) {
		//faq 카테고리 고르기
		List<FaqCateVO> catelist=new ArrayList<>();
		catelist=service.getcate();
		
		model.addAttribute("catelist", catelist);
		
		FaqVO vo=service.view(faqno, 0L);
		model.addAttribute("vo", vo);
		//카테고리 번호, 카테고리명도 전달함
		
		return "faq/updateform";
	}
	@PostMapping("/update.do")
	public String update(FaqVO vo) {
		service.update(vo);
		return "redirect:view.do?faqno="+vo.getFaqno()+"&hit=0";
	}
	
	@GetMapping("/delete.do")
	public String delete(Long faqno) {
		service.delete(faqno);
		return "redirect:list.do";
	}
}