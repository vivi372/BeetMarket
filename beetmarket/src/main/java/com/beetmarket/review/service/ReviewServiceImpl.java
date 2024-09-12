package com.beetmarket.review.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.review.mapper.ReviewMapper;
import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

@Service
@Qualifier("ReviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

	@Inject
	private ReviewMapper mapper;
	
	@Override
	public List<ReviewVO> list(PageObject pageObject, Long reviewNo){
		
		pageObject.setTotalRow(mapper.getTotalRow(pageObject, reviewNo));
		return mapper.list(pageObject, reviewNo);
	}
}