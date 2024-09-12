package com.beetmarket.main.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.beetmarket.main.service.MainService;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {

	@Autowired
	@Qualifier("mainServiceImpl")
	private MainService service;
	
	@GetMapping(value = {"/", "/main.do"})
	public String goMain() {
		log.info("redirect main......................");
		return "redirect:/main/main.do";
	}
	
	@GetMapping(value = {"/main/main.do"})
	public String main(Model model) {
		log.info("/member/main.do ......................");
		return "main/main";
	}
	
	@GetMapping(value = {"/main/searchList.do"})
	public String searchList(Model model, HttpServletRequest request) throws Exception {
		log.info("/member/searchList.do ......................");
		PageObject pageObject = PageObject.getInstance(request);
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject",pageObject);
		return "main/searchList";
	}
	
}
