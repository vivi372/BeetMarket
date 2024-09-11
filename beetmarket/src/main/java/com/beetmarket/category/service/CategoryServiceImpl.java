package com.beetmarket.category.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.beetmarket.category.mapper.CategoryMapper;
import com.beetmarket.category.vo.CategoryVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//- @Controller - url : HTML, @Service - 처리, @Repository - 데이터 저장, 
//@Component - 구성체, @RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("categoryServiceImpl")
public class CategoryServiceImpl implements CategoryService{

	// 자동 DI 적용 - @Setter, @Autowired, @Inject
	@Inject
	private CategoryMapper mapper;
	
	// 카테고리 리스트
	@Override
	public List<CategoryVO> list(Integer cate_code1) {
		return mapper.list(cate_code1);
	}
	
	// 카테고리 등록
	@Override
	public Integer write(CategoryVO vo) {
		// 카테로리 등록 - cate_code1이 있으면 중분류 등록, 없으면 대분류 등록
		if(vo.getCate_code1() == 0) return mapper.writeBig(vo);
		return mapper.writeMid(vo);
	}
	
	// 카테고리 수정
	@Override
	public Integer update(CategoryVO vo) {
		return mapper.update(vo);
	}
	
	// 카테고리 삭제
	@Override
	public Integer delete(CategoryVO vo) {
		return mapper.delete(vo);
	}
	
}
