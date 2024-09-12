package com.beetmarket.pointshop.service;

import java.util.List;

import com.beetmarket.pointshop.vo.PointShopVO;

public interface PointShopService {
	
	//포인트샵 상품 리스트
	public List<PointShopVO> list(PointShopVO vo);
	//포인트샵 상품 등록
	public Integer write(List<PointShopVO> list);
	//포인트샵 상품 수정
	public Integer update(PointShopVO vo);

}
