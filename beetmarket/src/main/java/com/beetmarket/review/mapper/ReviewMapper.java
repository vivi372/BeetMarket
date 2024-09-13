package com.beetmarket.review.mapper;

import java.util.List;

import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

public interface ReviewMapper {
	
	//1-1 list
	public List<ReviewVO> list(PageObject pageObject);
	
	// 1-2. getTotalRow
	public Long getTotalRow(PageObject pageObject);
}