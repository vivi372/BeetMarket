package com.beetmarket.event.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import com.beetmarket.event.mapper.EventMapper;
import com.beetmarket.event.vo.EventVO;

import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;
@Service
@Log4j
@Qualifier("eventServiceImpl")
public class EventServiceImpl implements EventService{
	@Inject
	public EventMapper mapper;
	public List<EventVO> list(PageObject pageObject){
		pageObject.setTotalRow(mapper.getTotal(pageObject));
		return mapper.list(pageObject);
	}
	public EventVO view(Long[] in) {
		Long no=in[0];
		return mapper.view(no);
	}
	public Integer write(EventVO vo) {
		Integer result = mapper.write(vo);
		return result;
	}
	public Integer update(EventVO vo) {
		return mapper.update(vo);
	}
	public Integer delete(EventVO vo) {
		return mapper.delete(vo);
	}
}