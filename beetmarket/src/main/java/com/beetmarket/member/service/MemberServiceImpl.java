package com.beetmarket.member.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.beetmarket.member.mapper.MemberMapper;
import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("memberServiceImpl")
public class MemberServiceImpl implements MemberService{
	
	@Inject
	private MemberMapper mapper;
	
	@Override
	public LoginVO login(LoginVO vo) {
		// TODO Auto-generated method stub
		return mapper.login(vo);
	}

	@Override
	public List<MemberVO> list(PageObject pageObject) {
		log.info("list() 실행");
		// 전체 데이터 개수 구하기
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	// 회원 등급변경
	@Override
	public Integer changeGrade(MemberVO vo) {
		log.info(vo);
		return mapper.changeGrade(vo);
	}
	// 회원 맴버쉽변경
	@Override
	public Integer changeMemeberShip(MemberVO vo) {
		log.info(vo);
		return mapper.changeMemeberShip(vo);
	}
	// 회원 상태변경
	@Override
	public Integer changeStatus(MemberVO vo) {
		log.info(vo);
		return mapper.changeStatus(vo);
	}
	// 회원 최근 접속일 업데이트
	@Override
	public Integer ConDateUpdate(LoginVO vo) {
		log.info(vo);
		return mapper.ConDateUpdate(vo);
	}
	
	// 회원관리 글보기
	@Override
	public MemberVO view(String id) {
		log.info("view() 실행");
		return mapper.view(id);
	}
}
