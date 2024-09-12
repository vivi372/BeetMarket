package com.beetmarket.goods.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import com.beetmarket.goods.vo.GoodsSearchVO;
import com.beetmarket.goods.vo.GoodsVO;

import com.webjjang.util.page.PageObject;

@Repository
public interface GoodsMapper {

	//상품 리스트
	public List<GoodsVO> list(@Param("pageObject") PageObject pageObject,
			@Param("searchVO") GoodsSearchVO searchVO);
	
	// 상품 리스트 페이지 처리를 위한 전체 데이터 개수
	public Long getTotalRow(@Param("searchVO") GoodsSearchVO searchVO);
	

	
}
