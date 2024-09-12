package com.beetmarket.pointshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.beetmarket.pointshop.vo.PointShopVO;

@Repository
public interface PointShopMapper {
	
	//포인트샵 상품 리스트
	public List<PointShopVO> list(PointShopVO vo);
	//포인트샵 상품 등록
	public Integer goodsWrite(PointShopVO vo);
	//포인트샵 재고 등록
	public Integer stockWrite(List<PointShopVO> list);
	//포인트샵 상품 수정
	public Integer update(PointShopVO vo);
	

}
