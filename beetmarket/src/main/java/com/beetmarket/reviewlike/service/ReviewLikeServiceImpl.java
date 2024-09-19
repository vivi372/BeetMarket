package com.beetmarket.reviewlike.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beetmarket.reviewlike.mapper.ReviewLikeMapper;
import com.beetmarket.reviewlike.vo.ReviewLikeVO;

@Service
public class ReviewLikeServiceImpl implements ReviewLikeService {

    @Autowired
    private ReviewLikeMapper reviewLikeMapper;

    /**
     * 특정 리뷰의 좋아요 개수를 조회하는 메서드.
     * @param reviewNo 리뷰 번호
     * @return 좋아요 개수
     */
    @Override
    public int getLikeCount(Long reviewNo) {
        return reviewLikeMapper.countLikes(reviewNo);
    }

    /**
     * 특정 리뷰에 좋아요를 추가하는 메서드.
     * 이미 좋아요를 누른 상태가 아니라면 좋아요를 추가합니다.
     * @param likeVO 좋아요 정보
     */
    @Override
    public void addLike(ReviewLikeVO likeVO) {
        reviewLikeMapper.insertLike(likeVO); // Mapper의 insertLike 메서드를 호출
    }

    /**
     * 특정 리뷰의 좋아요를 삭제하는 메서드.
     * 이미 좋아요를 누른 상태라면 좋아요를 삭제합니다.
     * @param likeVO 좋아요 정보
     */
    @Override
    public void removeLike(ReviewLikeVO likeVO) {
        if (reviewLikeMapper.userHasLiked(likeVO)) {
            reviewLikeMapper.deleteLike(likeVO);
        }
    }
}
