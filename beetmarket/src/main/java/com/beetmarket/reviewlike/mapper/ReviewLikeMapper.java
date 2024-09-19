package com.beetmarket.reviewlike.mapper;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.reviewlike.vo.ReviewLikeVO;

public interface ReviewLikeMapper {

    // 좋아요 추가
    void insertLike(ReviewLikeVO likeVO); // MyBatis가 이 메서드를 XML에서 찾을 수 있어야 합니다.

    // 기타 메서드
    int countLikes(@Param("reviewNo") Long reviewNo);

    void deleteLike(ReviewLikeVO likeVO);
    

	boolean userHasLiked(ReviewLikeVO likeVO);

}
