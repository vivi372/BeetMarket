package com.beetmarket.goods.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
// import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.beetmarket.category.service.CategoryService;
import com.beetmarket.goods.service.GoodsService;
import com.beetmarket.goods.vo.GoodsSearchVO;
import com.beetmarket.goods.vo.GoodsVO;

import com.webjjang.util.file.FileUtil;
import com.webjjang.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/goods")
@Log4j
public class GoodsController {

	// 자동 DI
	// @Setter(onMethod_ = @Autowired)
	// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
	@Autowired
	@Qualifier("goodsServiceImpl")
	private GoodsService service;

	@Autowired
	@Qualifier("categoryServiceImpl")
	private CategoryService categoryService;

	String path = "/upload/goods";

	// --- 상품 리스트 ------------------------------------
	@GetMapping("/list.do")
	public String list(Model model, @ModelAttribute(name = "searchVO") GoodsSearchVO searchVO,
			HttpServletRequest request) throws Exception {

		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);

		// 한 페이지당 보여주는 데이터의 개수가 없으면 기본은 8로 정한다.
		String strPerPageNum = request.getParameter("perPageNum");
		if (strPerPageNum == null || strPerPageNum.equals(""))
			pageObject.setPerPageNum(8);

		// 대분류를 가져와서 JSP로 넘기기.
		model.addAttribute("bigList", categoryService.list(0));

		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("list", service.list(pageObject, searchVO));
		// pageObject에 데이터 가져 오기 전에는 시작 페이지, 끝 페이지, 전체 페이지가 정해지지 않는다.
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		// model.addAttribute("searchVO", searchVO);
		// 검색에 대한 정보도 넘겨야 한다.
		return "goods/list";

	}

}
