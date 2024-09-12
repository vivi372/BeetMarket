package com.beetmarket.review.service;

import java.util.List;

import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

public interface ReviewService {

	//리뷰 리스트
	public List<ReviewVO> list(PageObject pageObject);
}