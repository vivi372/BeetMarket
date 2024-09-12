package com.beetmarket.review.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("ReviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

	@Inject
	private ReviewMapper mapper;
	
	@Override
	public List<ReviewVO> list(PageObject pageObject){
		log.info("list() 실행");
		
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
}