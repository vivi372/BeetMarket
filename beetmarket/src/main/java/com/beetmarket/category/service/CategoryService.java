package com.beetmarket.category.service;

import java.util.List;

import com.beetmarket.category.vo.CategoryVO;

public interface CategoryService {

	// 카테로리 리스트
	public List<CategoryVO> list(Integer cate_code1);
	
	// 카테로리 등록 - cate_code1이 있으면 중분류 등록, 없으면 대분류 등록
	public Integer write(CategoryVO vo);
	
	// 카테로리 수정
	public Integer update(CategoryVO vo);
	
	// 카테로리 삭제
	public Integer delete(CategoryVO vo);
	
}
