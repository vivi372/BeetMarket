package com.beetmarket.pointshoporder.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.beetmarket.pointshoporder.vo.PointShopOrderVO;

@Repository
public interface PointShopOrderMapper {
	
	//포인트샵 주문 전 재고 번호 가져오기
	public List<PointShopOrderVO> getStockNo(List<PointShopOrderVO> list);
	//포인트샵 주문 등록
	public Integer write(@Param("values") List<PointShopOrderVO> values,@Param("id") String id);
	//해당 재고 상태 수정
	public Integer stockStateUpdate(Long[] stockNos);
}
