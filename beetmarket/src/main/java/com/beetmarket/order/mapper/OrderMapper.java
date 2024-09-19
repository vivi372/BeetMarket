package com.beetmarket.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.beetmarket.goods.vo.GoodsVO;
import com.beetmarket.order.vo.OrderOptVO;
import com.beetmarket.order.vo.OrderVO;
import com.beetmarket.order.vo.SearchVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface OrderMapper {
	
	//주문 리스트
	public List<OrderVO> orderList(@Param("pageObject") PageObject pageObject,@Param("searchVO") SearchVO searchVO);
	//주문 전체 수 구하기
	public Long totalRow(@Param("pageObject") PageObject pageObject,@Param("searchVO") SearchVO searchVO);
	//writeForm 상품의 데이터 가져오는 쿼리 

	public List<OrderVO> getGoodsList(@Param("goodsNos") Long[] goodsNos);

	//writeForm 옵션의 데이터 가져오는 쿼리 
	public List<OrderOptVO> getOptList(@Param("optNos") Long[] optNos);
	//주문 등록
	public Integer write(List<OrderVO> list);


}
