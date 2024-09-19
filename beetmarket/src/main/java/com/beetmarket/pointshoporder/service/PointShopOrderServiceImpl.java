package com.beetmarket.pointshoporder.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.beetmarket.pointshoporder.mapper.PointShopOrderMapper;
import com.beetmarket.pointshoporder.vo.PointShopOrderVO;
import com.beetmarket.pointshoporder.vo.SearchVO;
import com.webjjang.util.page.PageObject;

import lombok.Setter;

@Service
@Qualifier("PointShopOrderServiceImpl")
public class PointShopOrderServiceImpl implements PointShopOrderService {
	
	@Setter(onMethod_ = @Autowired)
	PointShopOrderMapper mapper;
	
	//주문 리스트 가져오기
	@Override
	public List<PointShopOrderVO> list(PageObject pageObject,SearchVO searchVO,Integer admin) {
		
		pageObject.setTotalRow(mapper.totalRow(pageObject,searchVO,admin));
		
		return mapper.list(pageObject,searchVO,admin);
	}
	
	//포인트샵 주문 등록
	@Override
	@Transactional
	public boolean write(List<PointShopOrderVO> list, String id) {		
		

		boolean	outOfStock = false;
		List<PointShopOrderVO> values = mapper.getStockNo(list);
		
		//결제할 재고와 양과 결제 가능한 재고의 양 비교
		for(PointShopOrderVO vo:list) {
			Long goodsid = vo.getGoodsId();
			int cnt = 0;
			for(PointShopOrderVO value :values) {
				if(value.getGoodsId() == goodsid)
					cnt++;
			}
			if(vo.getAmount() != cnt) {
				outOfStock = true;
				break;
			}
		}		
		
		if(!outOfStock) {
			mapper.write(values, id);			
			//해당 재고 상태 변경
			//변경을 위해 데이터 담기
			Long[] stockNos = new Long[values.size()];
			for(int i=0;i<values.size();i++)
				stockNos[i] = values.get(i).getStockNo();
			mapper.stockStateUpdate(stockNos);
		}
		
		return outOfStock;
	}
	
	
	//구매 상품 삭제
	@Override
	public Integer delete(Long stockNo) {
		return mapper.delete(stockNo);
	}
	
	//상품 환불
	@Override
	@Transactional
	public Integer refund(Long pointShopOrderNo) {
		//포인트 환불
		
		//주문 삭제
		mapper.refundDelete(pointShopOrderNo);
		//상품 환불
		return mapper.refund(pointShopOrderNo);
	}

}
