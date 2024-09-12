package com.beetmarket.review.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

public interface ReviewMapper {
	
	//1-1 list
	public List<ReviewVO> list(
			@Param("pageObject") PageObject pageObject,
			@Param("reviewNo") Long reviewNo);
	
	// 1-2. 전체 데이터 개수
	public Long getTotalRow(
			@Param("pageObject") PageObject pageObject,
			@Param("reviewNo") Long reviewNo);
}