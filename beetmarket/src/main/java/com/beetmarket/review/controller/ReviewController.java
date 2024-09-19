package com.beetmarket.review.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.review.mapper.ReviewMapper;
import com.beetmarket.review.service.ReviewService;
import com.beetmarket.review.vo.ReviewVO;
import com.webjjang.util.file.FileUtil;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/review")
@Log4j
public class ReviewController {

	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService service;
	
	
    @Autowired
    private ReviewMapper mapper;
	
	
	String path = "/upload/review";
	
	
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request) throws Exception {
	    log.info("list.do");

	    // 페이지 객체 생성 및 초기화
	    PageObject pageObject = PageObject.getInstance(request);

	    // 리뷰 리스트 가져오기
	    List<ReviewVO> reviews = service.list(pageObject);

	    // 총 리뷰 개수 가져오기
	    Long totalReviewCount = service.getTotalRow(pageObject); 
	    
	    // 평균 평점 계산
	    // 별점 / 리뷰개수 = 평점
	    Double averageRating = reviews.stream()
	      .mapToDouble(ReviewVO::getStarscore) // starscore를 double로 매핑
	      .average() // 별점의 총합을 구한 후, 전체 리뷰 개수로 나누어 평균을 계산
	      .orElse(0.0); // 리뷰가 없는 경우 0.0

	    // 모델에 리뷰 리스트, 총 리뷰 개수 및 평균 평점 추가
	    model.addAttribute("list", reviews);
	    model.addAttribute("totalReviewCount", totalReviewCount);  // 리뷰 총 개수
	    model.addAttribute("averageRating", averageRating);        // 평균 평점
	    log.info(pageObject);
	    model.addAttribute("pageObject", pageObject);

	    return "review/list";
	}
	


	// 리뷰 등록 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("writeForm.do");
		return "review/writeForm";
	}
	
	
	
	// 리뷰 등록처리
	@PostMapping("/write.do")
	public String write(ReviewVO vo, HttpServletRequest request, 
			RedirectAttributes rttr, MultipartFile reviewFile ) throws Exception {
		log.info("<<<----- 이미지 처리 ----------------->>");
		// 대표 이미지 처리
		vo.setReviewImage(FileUtil.upload(path, reviewFile, request));
		
		log.info("write.do");
		log.info(vo);
		service.write(vo);
		
		// 처리 결과에 대한 메시지 처리
		rttr.addFlashAttribute("리뷰가 등록되었습니다");
		
		return "redirect:list.do";
	}
	
	
	
	// 수정 폼
	@GetMapping("/updateForm.do")
	public String updateForm(Long reviewNo, Model model) {
		log.info("updateForm.do");
		model.addAttribute("vo", service.list(null));
		
		return "review/updateForm";
	}
	
	
	
	// 수정 처리
	@PostMapping("/update.do")
	public String update(ReviewVO vo, RedirectAttributes rttr) {
		log.info("update.do");
		log.info(vo);
		if(service.update(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("수정 되었습니다.");
		else
			rttr.addFlashAttribute("업데이트가 되지 않았습니다");
		
		return "redirect:list.do?reviewNo=" + vo.getReviewNo();
	}
	
	
	
	//삭제
	@PostMapping("/delete.do")
	public String delete(ReviewVO vo, RedirectAttributes rttr) {
		log.info("delete.do");
		log.info(vo);
		// 처리 결과에 대한 메시지 처리
		if(service.delete(vo) == 1) {
			rttr.addFlashAttribute("msg", "일반 게시판 글삭제가 되었습니다.");
			return "redirect:list.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"일반 게시판 글삭제가 되지 않았습니다. "
							+ "글번호나 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
			return "redirect:list.do?reviewNo=" + vo.getReviewNo();
		}
	}
}