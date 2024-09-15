package com.beetmarket.pointshoporder.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beetmarket.pointshopbasket.service.PointShopBasketService;
import com.beetmarket.pointshoporder.service.PointShopOrderService;
import com.beetmarket.pointshoporder.vo.PointShopOrderVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/pointShopOrder")
@Log4j
public class PointShopOrderController {
	
	@Autowired
	@Qualifier("PointShopOrderServiceImpl")
	PointShopOrderService service;
	@Autowired
	@Qualifier("PointShopServiceBasketImpl")
	PointShopBasketService basketService;
	
	
	//아작스로 데이터를 받고 보내기 위해 @ResponseBody 사용
	@PostMapping(value = "/write.do", produces = "text/plain;charset=UTF-8")
	public @ResponseBody ResponseEntity<String> write(@ModelAttribute PointShopOrderVO vo,String id) {
		List<PointShopOrderVO> list = vo.getList();
		log.info(list);
		//주문 등록(재고가 부족하면 write true 리턴 => 결제 하지 않고 리턴 시킨다.)
		if(service.write(list, id)) {
			return new ResponseEntity<>("죄송합니다. 현재 해당 상품의 재고가 부족하여 주문이 불가능합니다.",HttpStatus.OK);
		} 		
		//포인트 차감
		//장바구니 삭제
		//삭제를 위한 데이터 세팅
		Long[] pointShopBasketNos = new Long[list.size()];
		int i=0;
		for(PointShopOrderVO item:list) {
			pointShopBasketNos[i++] = item.getPointShopBasketNo();
		}
		//db에서 장바구니 삭제
		basketService.delete(pointShopBasketNos);
		
		
		return new ResponseEntity<>("주문이 정상적으로 진행되었습니다.",HttpStatus.OK);
	}

}
