package com.webjjang.pointshop.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.webjjang.pointshop.service.PointShopService;
import com.webjjang.pointshop.vo.PointShopVO;
import com.webjjang.util.file.FileUtil;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/pointShop")
@Log4j
public class PointShopController {
	
	@Autowired
	@Qualifier("PointShopServiceImpl")
	private PointShopService service;
	
	String path = "/upload/pointshop";
	
	@GetMapping(value = "/list.do",produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<PointShopVO>> list(PointShopVO vo) {		
		
		return new ResponseEntity<List<PointShopVO>>(service.list(vo), HttpStatus.OK);
	}
	
	@PostMapping(value = "/write.do", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> write(PointShopVO vo,
			@RequestPart(name = "goodsImageFile") MultipartFile goodsImageFile,HttpServletRequest request ) throws Exception {
		log.info("하이");
		log.info(vo);
		log.info(goodsImageFile.getOriginalFilename());
		
		//파일 업로드 후 파일 경로 받아오기
		vo.setGoodsImage(FileUtil.upload(path, goodsImageFile, request));
		
		//등록을 위한 데이터 세팅
		List<PointShopVO> list = null;
		//입력된 재고가 0 이상일때만 재고 생성을 위한 리스트 생성
		if(vo.getGoodsStock() > 0) {
			for(int i=0;i<vo.getGoodsStock();i++) {
				if(list == null) list = new ArrayList<PointShopVO>();
				list.add(vo);
			}	
		} else {
			//재고가 0개 경우 vo를 한번만 넣는다.
			list = new ArrayList<PointShopVO>();
			list.add(vo);
		}
		
		try {
			service.write(list);
		} catch (Exception e) {
			//등록 실패하면 파일 삭제
			FileUtil.remove(FileUtil.getRealPath("",vo.getGoodsImage(),request));
			return new ResponseEntity<String>("등록이 실패했습니다.", HttpStatus.BAD_REQUEST);
		}
		
		
		return new ResponseEntity<String>("정상적으로 등록되었습니다.", HttpStatus.OK);
	}
	
}
