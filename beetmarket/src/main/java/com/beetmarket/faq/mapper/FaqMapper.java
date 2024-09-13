package com.beetmarket.faq.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.beetmarket.faq.vo.FaqCateVO;
import com.beetmarket.faq.vo.FaqVO;
import com.webjjang.util.page.PageObject;

@Repository
public interface FaqMapper {
	public List<FaqVO> list(PageObject po);
	public Long getTotalRow(PageObject po);
	
	public FaqVO view(Long faqno);
	public Long updatehit(Long faqno);
	
	public List<FaqCateVO> getcate();
	public Integer write(FaqVO vo);
	
	public Integer update(FaqVO vo);
	
	public Integer delete(Long faqno);
}