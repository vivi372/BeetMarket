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
	@Override
	public List<EventVO> list(PageObject pageObject){
		pageObject.setTotalRow(mapper.getTotal(pageObject));
		return mapper.list(pageObject);
	}
	@Override
	public EventVO view(Long[] in) {
		Long no=in[0];
		return mapper.view(no);
	}
	@Override
	public Integer write(EventVO vo) {
		Integer result = mapper.write(vo);
		return result;
	}
	@Override
	public Integer update(EventVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}
	@Override
	public Integer delete(EventVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}
}
