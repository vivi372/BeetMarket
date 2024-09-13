package com.beetmarket.review.service;

import java.util.List;

import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

public interface ReviewService {

	// 1. 리스트
	public List<ReviewVO> list(PageObject pageObject);
	
	
	
	// 2. 등록
	public Integer write(ReviewVO vo);

	
	
	// 3. 수정
	public Integer update(ReviewVO vo);
}