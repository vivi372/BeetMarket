package com.beetmarket.category.service;

import java.util.List;

import com.beetmarket.category.vo.CategoryVO;

public interface CategoryService {

	// 카테로리 리스트
	public List<CategoryVO> list(Integer cate_code1);
	
}
