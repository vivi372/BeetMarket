package com.beetmarket.goods.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.beetmarket.goods.vo.GoodsVO;

import com.beetmarket.category.vo.CategoryVO;
import com.beetmarket.goods.mapper.GoodsMapper;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//- @Controller - url : HTML, @Service - 처리, @Repository - 데이터 저장, 
//@Component - 구성체, @RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("goodsServiceImpl")
public class GoodsServiceImpl implements GoodsService{

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
	
	// 상품 글보기
	@Override
	@Transactional
	public GoodsVO view(Long goods_no, int inc) {
		log.info("view() 실행");
		if(inc == 1) mapper.increase(goods_no);
		return mapper.view(goods_no);
	}
	
	public List<GoodsImageVO> viewImageList(Long goods_no) {
		log.info("viewImageList() 실행");
		return mapper.imageList(goods_no);
	}
	
	@Override
	public List<GoodsSizeColorVO> sizeColorList(Long goods_no) {
		// TODO Auto-generated method stub
		return mapper.sizeColorList(goods_no);
	}
	
	@Override
	public List<GoodsOptionVO> OptionList(Long goods_no) {
		// TODO Auto-generated method stub
		return mapper.optionList(goods_no);
	}
	
	
	// 상품 글등록
	@Override
	// @Transactional - insert 2번이 성공을 해야 commit 한다. 한개라도 오류가 나면 rollback.
	// 상품, 가격, 이미지, 사이즈컬러, 옵션 -> 등록하다가 하나라고 오류가 나면 다 rollback 시킨다.
	@Transactional
	public Integer write(GoodsVO vo, List<GoodsImageVO> goodsImageList,
			List<GoodsSizeColorVO> goodsSizeColorList,
			List<GoodsOptionVO> goodsOptionList) {
		Integer result = null;
		// 상품 상세 정보 - vo : 필수 - 처리가 끝나면 goods_no 세팅되서 넘어온다.
		mapper.write(vo);
		// 추가 이미지 - goodsImageList. null이 아닌 경우에만 DB에 추가
		if(goodsImageList != null && goodsImageList.size() > 0) {
			// goods_no를 세팅해서 넘긴다.
			for(GoodsImageVO imageVO : goodsImageList)
				imageVO.setGoods_no(vo.getGoods_no());
			mapper.writeImage(goodsImageList);
		}
		// 사이즈와 색상 - goodsSizeColorList. null이 아닌 경우에만 DB에 추가
		if(goodsSizeColorList != null && goodsSizeColorList.size() > 0) {
			// goods_no를 세팅해서 넘긴다.
			for(GoodsSizeColorVO sizeColorVO : goodsSizeColorList)
				sizeColorVO.setGoods_no(vo.getGoods_no());
			mapper.writeSizeColor(goodsSizeColorList);
		}
		// 옵션 - goodsOptionList. null이 아닌 경우에만 DB에 추가
		if(goodsOptionList != null && goodsOptionList.size() > 0) {
			// goods_no를 세팅해서 넘긴다.
			for(GoodsOptionVO optionVO : goodsOptionList)
				optionVO.setGoods_no(vo.getGoods_no());
			mapper.writeOption(goodsOptionList);
		}
		// 가격 - vo : 필수
		result = mapper.writePrice(vo);
		return result;
	}
	
	// 상품 글수정
	@Override
	public Integer update(GoodsVO vo) {
		log.info(vo);
		return mapper.update(vo);
	}
	
	// 상품 글삭제
	@Override
	public Integer delete(GoodsVO vo) {
		log.info(vo);
		return mapper.delete(vo);
	}

	@Override
	public List<SizeVO> getSize(Integer cate_code1) {
		// TODO Auto-generated method stub
		return mapper.getSize(cate_code1);
	}

	@Override
	public List<ColorVO> getColor(Integer cate_code1) {
		// TODO Auto-generated method stub
		return mapper.getColor(cate_code1);
	}
	// 삭제할 제품에 대한 이미지를 전부 가져오기 : 상품 이미지 가져오기 -> DB 상품 삭제 -> 이미지 삭제 
	
}
