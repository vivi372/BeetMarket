package com.beetmarket.event.mapper;

import java.util.List;

import com.beetmarket.event.vo.EventVO;

import com.webjjang.util.page.PageObject;

public interface EventMapper {
	// 이벤트 리스트
	public List<EventVO> list(PageObject pageObject);
	// 이벤트 리스트 페이지 처리를 위한 젠체 데이터 개수
	public Long getTotal(PageObject pageObject);
	// 이벤트 상세보기
	public EventVO view(Long no);
	// 이벤트 등록
	public Integer write(EventVO vo);
	// 이벤트 수정
	public Integer update(EventVO vo);
	// 이벤트 삭제
	public Integer delete(EventVO vo);

}