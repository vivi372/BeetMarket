package com.beetmarket.event.cotroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.event.service.EventService;
import com.beetmarket.event.vo.EventVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/evnet")
@Log4j
public class EventController {
	@Autowired
	@Qualifier("eventServiceImpl")
	private EventService service;
	
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request) throws Exception {
		PageObject pageObject = PageObject.getInstance(request);
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject",pageObject);
		return "event/list";
	}
	@GetMapping("/view.do")
	public String view(Long no, Model model)  {
		Long[] in = new Long[]{no};
		EventVO vo = service.view(in);
		model.addAttribute("vo",vo);
		return "event/view";
	}
	@GetMapping("/writeForm.do")
	public String writeForm()  {
		return "event/writeForm";
	}
	@PostMapping("/write.do")
	public String write(EventVO vo, RedirectAttributes rttr) {
		System.out.println("EventController().write");
		service.write(vo);
		rttr.addAttribute("msg", "이벤트 등록이 되었습니다.");
		return "redirect:list.do";
	}
	@GetMapping("/updateForm.do")
	public String updateForm(Long no, Model model)  {
		Long [] in = new Long[] {no};
		EventVO vo = service.view(in);
		model.addAttribute("vo",vo);
		return "event/updateForm";
	}
	@PostMapping("/update.do")
	public String update(EventVO vo, RedirectAttributes rttr) {
		System.out.println("EventController().update");
		service.update(vo);
		Long no = vo.getNo();
		rttr.addAttribute("msg", "이벤트 수정이 되었습니다.");
		return "redirect:view.do?no=" + no ;
	}
//	@PostMapping("/delete.do")
//	public String delete(EventVO vo, RedirectAttributes rttr) {
//		if(service.delete(vo)==1) {
//			rttr.addAttribute("msg", "이벤트 삭제 되었습니다.");
//			return "redirect:list.do";			
//		}else
//			rttr.addAttribute("msg", "이벤트가 삭제가 되지 않았습니다. 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
//			return "redirect:view.do?no"+vo.getNo();
//	}
}