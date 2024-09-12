package com.beetmarket.pointshop.service;

import java.util.List;
import java.util.Map;

import com.beetmarket.pointshop.vo.PointShopVO;

public interface PointShopService {
	
	//포인트샵 상품 리스트
	public Map<String, Object> list(PointShopVO vo,String id);
	//포인트샵 상품 등록
	public Integer write(List<PointShopVO> list);
	//포인트샵 상품 수정
	public Integer update(PointShopVO vo);

}
