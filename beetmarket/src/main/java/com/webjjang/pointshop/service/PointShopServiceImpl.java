package com.webjjang.pointshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.webjjang.pointshop.mapper.PointShopMapper;
import com.webjjang.pointshop.vo.PointShopVO;

import lombok.Setter;

@Service
@Qualifier("PointShopServiceImpl")
public class PointShopServiceImpl implements PointShopService {

	@Setter(onMethod_ = @Autowired)
	private PointShopMapper mapper;
	
	//포인트샵 상품 리스트
	@Override
	public List<PointShopVO> list(PointShopVO vo) {
		
		return mapper.list(vo);
	}
	//포인트샵 상품 등록
	@Override
	@Transactional
	public Integer write(List<PointShopVO> list) {
		Integer result = mapper.goodsWrite(list.get(0));
		//재고가 0이면 stockWrite 는 실행하지 않는다.
		if(list.get(0).getGoodsStock() > 0) {
			for(PointShopVO vo:list) {
				vo.setGoodsId(list.get(0).getGoodsId());
			}
			result = mapper.stockWrite(list);
		}
		return result;
	}

}
