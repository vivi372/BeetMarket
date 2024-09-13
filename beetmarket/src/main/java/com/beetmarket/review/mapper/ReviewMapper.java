package com.beetmarket.review.mapper;

import java.util.List;

import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

public interface ReviewMapper {
	
	// 1-1 리스트
	public List<ReviewVO> list(PageObject pageObject);
	
	
	
	// 1-2. 리스트 전체 개수
	public Long getTotalRow(PageObject pageObject);
	
	
	
	// 2. 등록
	public Integer write(ReviewVO vo);
}