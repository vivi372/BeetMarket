package com.beetmarket.category.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.beetmarket.category.vo.CategoryVO;

@Repository
public interface CategoryMapper {

	// 카테고리 리스트
	public List<CategoryVO> list(@Param("cate_code1") Integer cate_code1);
	
	// 대분류 등록
	public Integer writeBig(CategoryVO vo);
	
	// 중분류 등록
	public Integer writeMid(CategoryVO vo);
	
	// 수정
	public Integer update(CategoryVO vo);
	
	// 삭제
	public Integer delete(CategoryVO vo);
	
}
