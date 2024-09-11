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
import com.beetmarket.goods.vo.GoodsVO;

import com.beetmarket.goods.service.GoodsService;
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
	
	//--- 상품 리스트 ------------------------------------
	@GetMapping("/list.do")
	// 검색을 위한 데이터를 따로 받아야 한다.
	// @ModelAttribute() - 전달받는 데이터를 Model에 담아서 바로 JSP까지 보낼 때 사용
	//  속성명을 보통 타입으로 사용한다. name = "searchVO" 설정해서 변경해서 사용
	public String list(Model model,
			@ModelAttribute(name = "searchVO") GoodsSearchVO searchVO,
			HttpServletRequest request)
			throws Exception {
		
		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);
		
		// 한 페이지당 보여주는 데이터의 개수가 없으면 기본은 8로 정한다.
		String strPerPageNum = request.getParameter("perPageNum");
		if(strPerPageNum == null || strPerPageNum.equals(""))
			pageObject.setPerPageNum(6);
		
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
	
	//--- 상품 글보기 ------------------------------------
	@GetMapping("/view.do")
	public String view(Model model, Long goods_no, int inc,
			@ModelAttribute(name = "searchVO") GoodsSearchVO searchVO
			) {
		log.info("view.do - goods_no=" + goods_no + ", inc=" + inc);
		
		// 상품 상세 정보 가져오기 - 현재 판매 가격 포함
		model.addAttribute("vo", service.view(goods_no, inc));
		// 첨부 이미지 파일 리스트
		model.addAttribute("imageList", service.viewImageList(goods_no));
		// 사이즈와 색상 리스트
		model.addAttribute("sizeColorList", service.sizeColorList(goods_no));
		// 옵션 리스트
		model.addAttribute("optionList", service.OptionList(goods_no));
		
		return "goods/view";
	}
	
	//--- 상품 글등록 폼 ------------------------------------
	@GetMapping("/writeForm.do")
	public String writeForm(Model model) {
		log.info("writeForm.do");
		// 대분류를 가져와서 JSP로 넘기기.
		model.addAttribute("bigList", categoryService.list(0));
		return "goods/writeForm";
	}
	
	//--- 상품 글등록 처리 ------------------------------------
	@PostMapping("/write.do")
	public String write(GoodsVO vo, 
			// 대표이미지
			MultipartFile imageFile,
			// 상세 설명 이미지
			MultipartFile detailImageFile,
			// 추가 이미지들
			ArrayList<MultipartFile> imageFiles,
			// 옵션들 받기 - 사이즈, 컬러, 옵션 : ArrayList로 받으면 null인 경우 오류
			// 	@RequestParam(required = false) 붙여야 받을 수 있다. 배열인 경우 오류 안남
			@RequestParam(name = "size_nos", required = false) ArrayList<Long> size_nos,
			@RequestParam(name = "color_nos", required = false) ArrayList<Long> color_nos,
			@RequestParam(name = "option_names", required = false) ArrayList<String> option_names,
			Long perPageNum,
			HttpServletRequest request,
			RedirectAttributes rttr) throws Exception {
		log.info("write.do ------------------------------");
		log.info(vo);
		log.info("대표 이미지 : " + imageFile.getOriginalFilename());
		log.info("상세 설명 이미지 : " + detailImageFile.getOriginalFilename());
		log.info("<< 첨부 이미지들>>");
		for(MultipartFile file : imageFiles)
			log.info(file.getOriginalFilename());
		log.info("사이즈 : " + size_nos);
		log.info("색상 : " + color_nos);
		log.info("옵션 : " + option_names);
		
		// 이미지 올리기와 DB에 저장할 데이터 수집
		log.info("<<<----- 이미지 처리 ----------------->>");
		// 대표 이미지 처리
		vo.setImage_name(FileUtil.upload(path, imageFile, request));
		
		String fileName = detailImageFile.getOriginalFilename();
		
		// 상품 상세 이미지
		if(fileName != null && !fileName.equals(""))
			vo.setDetail_image_name(FileUtil.upload(path, detailImageFile, request));
		
		// 첨부 이미지 - GoodsImageVO
		List<GoodsImageVO> goodsImageList = null;
		// 첨부 추가 이미지가 있는 경우 처리
		if(imageFiles != null && imageFiles.size() > 0)
			for(MultipartFile file : imageFiles) {
				if(goodsImageList == null) goodsImageList = new ArrayList<>();
				fileName = file.getOriginalFilename();
				// 파일은 선택한 경우 처리
				if(fileName != null && !fileName.equals("")) {
					GoodsImageVO imageVO = new GoodsImageVO();
					// 파일은 서버에 올리고 DB에 저장할 정보를 VO에 저장한다.
					imageVO.setImage_name(FileUtil.upload(path, file, request));
					goodsImageList.add(imageVO);
				}
			}
		// 상품 상세 / 가격 정보 확인
		log.info(vo);
		// 첨부 이미지 목록 확인
		log.info("goodsImageList : " + goodsImageList);
		
		// 사이즈와 컬러 - 데이터 개수 : 사이즈 * 컬러 - GoodsSizeColorVO
		List<GoodsSizeColorVO> goodsSizeColorList = null;
		// 사이즈가 있는 경우 처리(옵션이 없다.)
		if(size_nos != null && size_nos.size() > 0) {
			for (Long sizeNo : size_nos) {
				if(goodsSizeColorList == null) goodsSizeColorList = new ArrayList<>();
				if(color_nos != null && color_nos.size() > 0) { // 컬러가 있는 경우
					for (Long colorNo : color_nos) {
						GoodsSizeColorVO sizeColorVO = new GoodsSizeColorVO();
						sizeColorVO.setSize_no(sizeNo);
						sizeColorVO.setColor_no(colorNo);
						goodsSizeColorList.add(sizeColorVO);
					}
				} else { // 컬러가 없는 경우
					GoodsSizeColorVO sizeColorVO = new GoodsSizeColorVO();
					sizeColorVO.setSize_no(sizeNo);
					goodsSizeColorList.add(sizeColorVO);
				}
			}
		}
		//사이즈 컬러 확인
		log.info("goodsSizeColorList : " + goodsSizeColorList);
		
		// 옵션 - GoodsOptionVO
		List<GoodsOptionVO> goodsOptionList = null;
		// 옵션이 있는 경우 처리(사이즈 컬러는 없다.)
		if(option_names != null && option_names.size() > 0) {
			for(String option_name : option_names) {
				if(goodsOptionList == null) goodsOptionList = new ArrayList<>();
				// 비이 있지 않으면 처리한다.
				if(option_names != null && !option_names.equals("")) {
					GoodsOptionVO optionVO = new GoodsOptionVO();
					optionVO.setOption_name(option_name);
					goodsOptionList.add(optionVO);
				}
			}
		}
		// 옵션 확인
		log.info("goodsOptionList : " + goodsOptionList);
		
		// service.write()에 넘길 데이터
		//  - vo, goodsImageList, goodsSizeColorList, goodsOptionList
		service.write(vo, goodsImageList, goodsSizeColorList, goodsOptionList);
		
		// 처리 결과에 대한 메시지 처리
		log.info("상품 등록이 되었습니다. 상품 번호 : " + vo.getGoods_no());
		rttr.addFlashAttribute("msg", "상품 글등록이 되었습니다.");
		
		
		return "redirect:list.do?perPageNum=" + perPageNum;
		// return null;
	}
	
	//--- 상품 글수정 폼 ------------------------------------
	@GetMapping("/updateForm.do")
	public String updateForm(Long no, Model model) {
		log.info("updateForm.do");
		
		model.addAttribute("vo", service.view(no, 0));
		
		return "goods/updateForm";
	}
	
	//--- 상품 글수정 처리 ------------------------------------
	@PostMapping("/update.do")
	public String update(GoodsVO vo, RedirectAttributes rttr) {
		log.info("update.do");
		log.info(vo);
		if(service.update(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "상품 글수정이 되었습니다.");
		else
			rttr.addFlashAttribute("msg",
					"상품 글수정이 되지 않았습니다. "
					+ "글번호나 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
		
		return "redirect:view.do";
	}
	
	
	//--- 상품 글삭제 처리 ------------------------------------
	@PostMapping("/delete.do")
	public String delete(GoodsVO vo, RedirectAttributes rttr) {
		log.info("delete.do");
		log.info(vo);
		// 처리 결과에 대한 메시지 처리
		if(service.delete(vo) == 1) {
			rttr.addFlashAttribute("msg", "상품 글삭제가 되었습니다.");
			return "redirect:list.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"상품 글삭제가 되지 않았습니다. "
							+ "글번호나 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
			return "redirect:view.do";
		}
	}
	
}
