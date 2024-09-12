package com.beetmarket.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.beetmarket.review.service.ReviewService;
import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/review")
@Log4j
public class ReviewController {

	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService service;
	
	//1. 리스트
	 @GetMapping(value = "/review.do", 
			 produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	 public ResponseEntity<Map<String, Object>>
	 	list(PageObject pageObject, Long reviewNo) {
		 log.info("list - page : " + pageObject.getPage() + ", reviewNo : " + reviewNo);
		 
		 List<ReviewVO> list = service.list(pageObject, reviewNo);
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("list", list);
		 map.put("pageObject", pageObject);
		 
		 return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
				 
	 }
	
}
