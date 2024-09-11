package com.beetmarket.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {

	private String id;
	private String pw;
	private String name;
	private String email;
	private String gender;
	private String birth;
	private String tel;
	private String photo;
	private String status;
	private Date ship_change_date; // 맴버쉽 변경일자
	private Date conDate; // 최근접속일
	private Date regDate; // 계정 생성일
	private Long newMsgCnt;
	private Integer sale_rate; // 등급별 할인율
	private Long shipNo; // 맴버쉽 번호 1 - bronze ,2 - gold ,3 - diamond
	private Long gradeNo; // 등급 번호 1 - 일반회원 , 5 - 판매자 , 9 - 관리자
	
	
}
