package com.beetmarket.stock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beetmarket.stock.service.StockService;

import lombok.extern.log4j.Log4j;



/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/stock")
@Log4j
public class StockController {
	
   
    private final String APP_KEY = "PSdTPt6Y6Y8jlz2bZavylela0LPunIuP9CAq"; // 실제 키로 교체 필요
    private final String APP_SECRET = "5A9NiHMzRkPIxx6rujN5hkpZ/LI4lEU69Yh34G4b9YzUxgrSgQMPTMpztTzoXtdIytjMYr6UwlH+CMNQxI33p04UmV4c4KhKrNnWXmV0Y0Qpjp2+Tn4Jxg6iPNNNU5F0pt+m0NQ0ZDnuW+I0CKgjxYTYdwtu7QDmPF/5Z4CCYDVCqwot0zo="; // 실제 키로 교체 필요
    
	// 자동 DI 
	@Autowired 
	@Qualifier("StockServiceImpl")
	private StockService stockService;

	@GetMapping("/stockMain.do")
	public String stockMain(Model model) {
		
		model.addAttribute("stockList", stockService.stockList());
		
		return "stock/stockMain";
	}
	
	@GetMapping("/stockList.do")
	public String stockList(Model model) {
		
		
		return "stock/stockList";
	}
    
 
}
