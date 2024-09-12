package com.beetmarket.stock.mapper;

import java.util.List;

import com.beetmarket.stock.vo.StockVO;
import com.beetmarket.stock.vo.Stock_InfoVO;

public interface StockMapper {
	
	//1-1 list
	public List<StockVO> stockList();
	// 2. 주식 정보 데이터 DB에 저장하기
	public String insertStockInfo(Stock_InfoVO vo);
	
	
}