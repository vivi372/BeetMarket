package com.beetmarket.reviewlike.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.beetmarket.reviewlike.service.ReviewLikeService;
import com.beetmarket.reviewlike.vo.ReviewLikeVO;

@Controller
@RequestMapping("/reviewlike")
public class ReviewLikeController {

    @Autowired
    private ReviewLikeService reviewLikeService;

    /**
     * 특정 리뷰의 좋아요 상태를 확인하고, 좋아요 개수를 반환하는 메서드.
     * @param reviewNo 리뷰 번호
     * @param model 모델 객체
     * @return 좋아요 리스트 페이지
     */
    @GetMapping("/list")
    public String list(@RequestParam Long reviewNo, Model model) {
        int likeCount = reviewLikeService.getLikeCount(reviewNo);
        model.addAttribute("likeCount", likeCount);
        return "review/likeList"; // 좋아요 리스트를 보여줄 뷰 페이지
    }

    /**
     * 특정 리뷰에 좋아요를 추가하는 메서드.
     * @param reviewNo 리뷰 번호
     * @param id 사용자 ID
     * @return 리뷰 목록 페이지로 리다이렉트
     */
    @PostMapping("/write")
    public String write(@RequestParam Long reviewNo, @RequestParam String id) {
        ReviewLikeVO likeVO = new ReviewLikeVO();
        likeVO.setReviewNo(reviewNo);
        likeVO.setId(id);

        reviewLikeService.addLike(likeVO);

        return "redirect:/review/list.do"; // 리뷰 리스트 페이지로 리다이렉트
    }

    /**
     * 특정 리뷰의 좋아요를 삭제하는 메서드.
     * @param reviewNo 리뷰 번호
     * @param id 사용자 ID
     * @return 리뷰 목록 페이지로 리다이렉트
     */
    @PostMapping("/delete")
    public String delete(@RequestParam Long reviewNo, @RequestParam String id) {
        ReviewLikeVO likeVO = new ReviewLikeVO();
        likeVO.setReviewNo(reviewNo);
        likeVO.setId(id);

        reviewLikeService.removeLike(likeVO);

        return "redirect:/review/list.do"; // 리뷰 리스트 페이지로 리다이렉트
    }
}
