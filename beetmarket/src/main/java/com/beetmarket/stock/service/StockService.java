package com.beetmarket.stock.service;

import java.util.List;

import com.beetmarket.review.vo.ReviewVO;
import com.beetmarket.stock.vo.StockVO;
import com.beetmarket.stock.vo.Stock_InfoVO;
import com.webjjang.util.page.PageObject;

public interface StockService {

	//종목 리스트
	public List<StockVO> stockList();
	
	public String insertStockInfo(Stock_InfoVO vo);
}