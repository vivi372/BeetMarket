package com.beetmarket.showdown.cotroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.showdown.service.ShowdownService;
import com.beetmarket.showdown.vo.ShowdownVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/showdown")
@Log4j
public class ShowdownController {
	@Autowired
	@Qualifier("showdownServiceImpl")
	private ShowdownService service;
	
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request) throws Exception {
		PageObject pageObject = PageObject.getInstance(request);
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject", pageObject);
		return "showdown/list";
	}
	@GetMapping("/view.do")
	public String view(Model model, Long no){
		Long [] hi = new Long[] {no};
		ShowdownVO vo = service.view(hi);
		model.addAttribute("vo", vo);
		return "showdown/list";
	}
	@GetMapping("/writeForm.do")
	public String writeForm (Model model, Long no){
		log.info("writeForm.do");
		return "notice/writeForm";
	}
	@PostMapping("/write.do")
	public String write (ShowdownVO vo, RedirectAttributes rttr){
		service.write(vo);
		rttr.addFlashAttribute("msg", "공지사항 글등록이 되었습니다.");
		return "redirect:list.do";
	}
	@GetMapping("/updateForm.do")
	public String updateForm(Model model, Long no){
		Long[] in = new Long[] {no};
		ShowdownVO vo = service.view(in);
		model.addAttribute("vo", vo);
		return "notice/updateForm";
	}
	@PostMapping("/update.do")
	public String update(ShowdownVO vo, RedirectAttributes rttr){
		Long no = vo.getNo();
		rttr.addFlashAttribute("msg", "공지사항 글등록이 되었습니다.");
		return "redirect:view.do?no="+no;
	}
	@PostMapping("/delete.do")
	public String delete(ShowdownVO vo, RedirectAttributes rttr){
		rttr.addFlashAttribute("msg", "공지사항이 삭제 되었습니다.");
		return "redirect:list.do";
	}	
}