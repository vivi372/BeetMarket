package com.beetmarket.goods.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import com.beetmarket.goods.vo.GoodsVO;

import com.beetmarket.category.vo.CategoryVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface GoodsMapper {

	//상품 리스트
	public List<GoodsVO> list(@Param("pageObject") PageObject pageObject,
			@Param("searchVO") GoodsSearchVO searchVO);
	
	// 상품 리스트 페이지 처리를 위한 전체 데이터 개수
	public Long getTotalRow(@Param("searchVO") GoodsSearchVO searchVO);
	
	// 보기 조회수 1 증가
	public Integer increase(@Param("goods_no") Long goods_no);
	
	// 보기
	public GoodsVO view(@Param("goods_no") Long goods_no);
	public List<GoodsImageVO> imageList(@Param("goods_no") Long goods_no);
	public List<GoodsSizeColorVO> sizeColorList(@Param("goods_no") Long goods_no);
	public List<GoodsOptionVO> optionList(@Param("goods_no") Long goods_no);

	//---- 상품 등록 - transactional 처리한다.
	// 1. 상품 정보 등록
	public Integer write(GoodsVO vo);
	// 2. 상품 추가 이미지 등록
	public Integer writeImage(List<GoodsImageVO> goodsImageList);
	// 3. 상품 사이즈 / 색상 등록
	public Integer writeSizeColor(List<GoodsSizeColorVO> goodsSizeColorList);
	// 4. 상품 옵션 등록
	public Integer writeOption(List<GoodsOptionVO> goodsOptionList);
	// 5. 상품 가격 등록
	public Integer writePrice(GoodsVO vo);
	
	// 수정
	public Integer update(GoodsVO vo);
	
	// 삭제
	public Integer delete(GoodsVO vo);

	// 상품 사이즈 가져오기
	public List<SizeVO> getSize(@Param("cate_code1") Integer cate_code1);
	
	// 상품 색상 가져오기
	public List<ColorVO> getColor(@Param("cate_code1") Integer cate_code1);

	
}
