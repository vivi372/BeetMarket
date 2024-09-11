package com.beetmarket.goods.service;

import java.util.List;

import com.beetmarket.goods.vo.GoodsVO;

import com.webjjang.util.page.PageObject;

public interface GoodsService {

	// 상품 리스트
	public List<GoodsVO> list(PageObject pageObject, GoodsSearchVO searchVO);
	
	// 상품 보기
	public GoodsVO view(Long goods_no, int inc);
	public List<GoodsImageVO> viewImageList(Long goods_no);
	public List<GoodsSizeColorVO> sizeColorList(Long goods_no);
	public List<GoodsOptionVO> OptionList(Long goods_no);
	
	// 상품 등록
	public Integer write(GoodsVO vo, List<GoodsImageVO> goodsImageList,
			List<GoodsSizeColorVO> goodsSizeColorList,
			List<GoodsOptionVO> goodsOptionList);
	
	// 상품 수정 - 텍스트 정보 + 대표 이미지 + 상세 설명 이미지
	public Integer update(GoodsVO vo);
	
	// 상품 삭제
	public Integer delete(GoodsVO vo);
	
	// 상품 이미지 추가
	// 상품 이미지 변경
	// 상품 이미지 제거
	
	// 상품 사이즈컬러 추가
	// 상품 사이즈컬러 변경
	// 상품 사이즈컬러 제거
	
	// 상품 현재 가격 변경 + 기간 변경
	// 상품 예정 가격 추가
	
	// 상품 사이즈 가져오기
	public List<SizeVO> getSize(Integer cate_code1);
	
	// 상품 색상 가져오기
	public List<ColorVO> getColor(Integer cate_code1);

}
