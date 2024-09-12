package com.beetmarket.goods.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.beetmarket.category.vo.CategoryVO;
import com.beetmarket.goods.mapper.GoodsMapper;
import com.beetmarket.goods.vo.GoodsSearchVO;
import com.beetmarket.goods.vo.GoodsVO;

import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("goodsServiceImpl")
public class GoodsServiceImpl implements GoodsService {

	// 자동 DI 적용 - @Setter, @Autowired, @Inject
	@Inject
	private GoodsMapper mapper;

	// 상품 리스트
	@Override
	public List<GoodsVO> list(PageObject pageObject, GoodsSearchVO searchVO) {
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getTotalRow(searchVO));
		return mapper.list(pageObject, searchVO);
	}

}
