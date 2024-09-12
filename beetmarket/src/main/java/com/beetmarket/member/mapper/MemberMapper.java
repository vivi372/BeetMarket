package com.beetmarket.member.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

public interface MemberMapper {

	public LoginVO login(LoginVO vo);
	// 회원관리 리스트
	public List<MemberVO> list(@Param("pageObject") PageObject pageObject);
	
	// 회원관리 리스트 페이지 처리를 위한 전체 데이터 개수
	public Long getTotalRow(@Param("pageObject") PageObject pageObject);
	// 등급 변경
	public Integer changeGrade(MemberVO vo);
	// 맴버쉽 변경
	public Integer changeMemeberShip(MemberVO vo);
	// 상태 변경
	public Integer changeStatus(MemberVO vo);

	// 보기
	public MemberVO view(String id);
	
}
