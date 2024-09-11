package com.beetmarket.member.mapper;

import java.util.List;

import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

public interface MemberMapper {

	public List<MemberVO> list(PageObject pageObject);
	
	public LoginVO login(LoginVO vo);

	public Long getTotalRow(PageObject pageObject);
	
}
