package com.beetmarket.main.service;

import java.util.List;

import com.beetmarket.main.vo.MainSearchVO;
import com.webjjang.util.page.PageObject;

public interface MainService {

	public List<MainSearchVO> list(PageObject pageObject);
	
}
