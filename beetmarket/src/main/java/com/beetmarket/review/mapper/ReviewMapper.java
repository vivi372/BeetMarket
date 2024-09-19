package com.beetmarket.review.mapper;

import java.util.List;

import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

public interface ReviewMapper {
	
	// 1-1 리스트
	public List<ReviewVO> list(PageObject pageObject);
	
	
	
	// 1-2. 리스트 전체 개수 & 평점
	public Long getTotalRow(PageObject pageObject);

	
	
	// 2. 등록
	public Integer write(ReviewVO vo);
	
	
	
	// 3.글수정
	public Integer update(ReviewVO vo);
	
	
	
	// 4.삭제
	public Integer delete(ReviewVO vo);


}