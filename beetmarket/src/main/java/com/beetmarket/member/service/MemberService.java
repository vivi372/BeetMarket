package com.beetmarket.member.service;

import java.util.List;

import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

public interface MemberService {
	public LoginVO login(LoginVO vo);
	
	// 회원관리 리스트
	public List<MemberVO> list(PageObject pageObject);
	// 회원등급변경
	public Integer changeGrade(MemberVO vo);
	// 회원 맴버쉽 변경
	public Integer changeMemeberShip(MemberVO vo);
	// 회원 상태변경
	public Integer changeStatus(MemberVO vo);
	// 회원관리 글보기
	public MemberVO view(String id);
}
