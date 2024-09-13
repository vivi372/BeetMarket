package com.beetmarket.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.review.mapper.ReviewMapper;
import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

import lombok.Setter;

@Service
@Qualifier("ReviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {
	
	@Setter(onMethod_ = @Autowired)
	private ReviewMapper mapper;
	
	
	// 리스트
	@Override
	public List<ReviewVO> list(PageObject pageObject){
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	
	
	
	// 글등록
	@Override
	public Integer write(ReviewVO vo) {
		Integer result = mapper.write(vo);
		return result;
	}

}