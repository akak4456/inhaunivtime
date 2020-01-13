package org.akak4456.controller;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.PageDTO;
import org.akak4456.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Controller
@RequestMapping("/notice/*")
@Log4j
@AllArgsConstructor
public class NoticeController {
	private NoticeService noticeService;
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri, Model model) {
		log.info("get......");
		model.addAttribute("notice",noticeService.get(bno));
	}
	@GetMapping("/list")
	public void list(Criteria cri,Model model) {
		log.info("list: "+cri);
		int total = noticeService.getTotal();
		PageDTO page = new PageDTO(cri,total);
		model.addAttribute("pageMaker",page);
		model.addAttribute("list",noticeService.getList(cri));
	}
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri ,RedirectAttributes rttr) {
		log.info("remove: "+bno);
		noticeService.remove(bno);
		return "redirect:/notice/list"+cri.getListLink();
	}
}
