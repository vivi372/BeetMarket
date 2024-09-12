package com.beetmarket.stock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.stock.mapper.StockMapper;
import com.beetmarket.stock.vo.StockVO;
import com.beetmarket.stock.vo.Stock_InfoVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("StockServiceImpl")
public class StockServiceImpl implements StockService {

	@Inject
	private StockMapper mapper;
	
	@Override
	public List<StockVO> stockList(){
		log.info("list() 실행");
	
		return mapper.stockList();
	}

	@Override
	public String insertStockInfo(Stock_InfoVO vo) {
		// TODO Auto-generated method stub
		return null;
	}
}