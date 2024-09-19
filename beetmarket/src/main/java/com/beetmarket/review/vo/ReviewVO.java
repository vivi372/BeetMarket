package com.beetmarket.review.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {

	private Long reviewNo; 			//리뷰번호
	private Long orderNo;  			//주문번호
	private Long goodsNo;  			//상품번혼
	private Date WriteDate;			//작성일
	private Long  starscore;		//별점
	private String reviewImage;		//리뷰이미지
	private String reviewContent;	//리뷰내용
	private String id; 				//작성자 id
	private Long reviewLike;		//좋아요 개수
}