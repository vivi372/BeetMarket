package com.beetmarket.event.service;

import java.util.List;

import com.beetmarket.event.vo.EventVO;

import com.webjjang.util.page.PageObject;

public interface EventService {
	// 이벤트 리스트
	public List<EventVO> list(PageObject pageObject);
	// 이벤트 상세보기
	public EventVO view(Long[] in);
	// 이벤트 등록
	public Integer write(EventVO vo);
	// 이벤트 수정
	public Integer update(EventVO vo);
	// 이벤트 삭제
	public Integer delete(EventVO vo);
}
