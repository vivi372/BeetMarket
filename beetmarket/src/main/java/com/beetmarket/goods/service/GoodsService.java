package com.beetmarket.goods.service;

import java.util.List;

import com.beetmarket.goods.vo.GoodsImageVO;
import com.beetmarket.goods.vo.GoodsInfoVO;
import com.beetmarket.goods.vo.GoodsOptionVO;
import com.beetmarket.goods.vo.GoodsSearchVO;
import com.beetmarket.goods.vo.GoodsVO;

import com.webjjang.util.page.PageObject;

public interface GoodsService {

	// 상품 리스트
	public List<GoodsVO> list(PageObject pageObject, GoodsSearchVO searchVO);

	// 상품 보기
	public GoodsVO view(Long goodsNo, int inc);

	public List<GoodsImageVO> viewImageList(Long goodsNo);

	public List<GoodsOptionVO> OptionList(Long goodsNo);

	public List<GoodsInfoVO> InfoList(Long goodsNo);

	// 상품 등록
	public Integer write(GoodsVO vo, List<GoodsImageVO> goodsImageList, List<GoodsOptionVO> goodsOptionList,
			List<GoodsInfoVO> goodsInfoList);

}
