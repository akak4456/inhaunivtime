package org.akak4456.controller;

import org.akak4456.domain.Criteria;
import org.akak4456.domain.NoticeVO;
import org.akak4456.domain.PageDTO;
import org.akak4456.service.NoticeService;
import org.akak4456.service.ReportService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/*")
@Log4j
@AllArgsConstructor
public class AdminController {
	private NoticeService noticeService;
	private ReportService reportService;
	@GetMapping("/main")
	public void mainGet() {
		
	}
	@GetMapping("/noticeadd")
	public void noticeadd() {
		
	}
	@PostMapping("/noticeadd")
	public String noticeAddPost(NoticeVO vo, RedirectAttributes rttr) {
		noticeService.register(vo);
		return "redirect:/admin/main";
	}
	@GetMapping("/seereport")
	public void seeReport(Criteria cri,Model model) {
		int total = reportService.getTotal();
		PageDTO page = new PageDTO(cri,total);
		model.addAttribute("pageMaker",page);
		model.addAttribute("list",reportService.getList(cri));
	}
	@GetMapping("/seereportGo")
	public String seeReportPost(Long rno) {
		log.info("seereport: "+rno);
		Long bno = reportService.findByRno(rno);
		return "redirect:/freeboard/get?bno="+bno;
	}
	@GetMapping("/blockuser")
	public void blockuser() {
		
	}
}
