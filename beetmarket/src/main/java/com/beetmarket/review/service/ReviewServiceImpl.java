package com.beetmarket.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.review.mapper.ReviewMapper;
import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
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
    
    
    
	// 리뷰수 & 평점
	@Override
    public Long getTotalRow(PageObject pageObject) {
        return mapper.getTotalRow(pageObject);
    }


	
	// 등록
	@Override
	public Integer write(ReviewVO vo) {
		Integer result = mapper.write(vo);
		return result;
	}
	
	
	
	// 수정
	@Override
	public Integer update(ReviewVO vo) {
		log.info(vo);
		return mapper.update(vo);
	}
	
	
	// 삭제
	@Override
	public Integer delete(ReviewVO vo) {
		log.info(vo);
		return mapper.delete(vo);
	}
    
}