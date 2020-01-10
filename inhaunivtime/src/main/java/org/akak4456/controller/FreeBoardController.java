package org.akak4456.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.akak4456.domain.AttachVO;
import org.akak4456.domain.Criteria;
import org.akak4456.domain.FreeBoardVO;
import org.akak4456.domain.PageDTO;
import org.akak4456.service.FreeBoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/freeboard/*")
@AllArgsConstructor
public class FreeBoardController {
	private FreeBoardService freeBoardService;
	
	@GetMapping("/list")
	public void list(Criteria cri,Model model) {
		log.info("list: "+cri);
		int total = freeBoardService.getTotal(cri);
		PageDTO page = new PageDTO(cri,total);
		log.info("page: "+page );
		model.addAttribute("pageMaker",page);
		model.addAttribute("list",freeBoardService.getList(cri));
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	@PostMapping("/register")
	public String register(FreeBoardVO freeboard, RedirectAttributes rttr) {
		log.info("register: "+freeboard);
		if(freeboard.getAttachList() != null) {
			freeboard.getAttachList().forEach(attach->log.info(attach));
		}
		freeBoardService.register(freeboard);
		
		rttr.addFlashAttribute("result",freeboard.getBno());
		
		return "redirect:/freeboard/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno")Long bno,@ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get or modify");
		model.addAttribute("freeboard",freeBoardService.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(FreeBoardVO freeboard,@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify: "+freeboard);
		
		if(freeBoardService.modify(freeboard)) {
			rttr.addFlashAttribute("result","modifysuccess");
		}else {
			rttr.addFlashAttribute("result","modifyfail");
		}
		return "redirect:/freeboard/list"+cri.getListLink();
	}
	
	@PostMapping("/recommend")
	public String updateRecommend(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
		log.info("coutup recommend: "+bno );
		if(freeBoardService.recommendCountUp(bno)) {
			rttr.addFlashAttribute("result","updaterecommendsuccess");
		}else {
			rttr.addFlashAttribute("result","updaterecommendfail");
		}
		return "redirect:/freeboard/get?bno="+bno;
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri ,RedirectAttributes rttr) {
		log.info("remove: "+bno);
		List<AttachVO> attachList = freeBoardService.getAttachList(bno);
		if(freeBoardService.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result","removesuccess");
		}else {
			rttr.addFlashAttribute("result","removefail");
		}
		return "redirect:/freeboard/list"+cri.getListLink();
	}
	@GetMapping(value="/getAttachList",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(Long bno){
		log.info("getAttachList "+bno);
		
		return new ResponseEntity<>(freeBoardService.getAttachList(bno),HttpStatus.OK);
	}
	private void deleteFiles(List<AttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach files......");
		log.info(attachList);
		attachList.forEach(attach->{
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadpath()+"\\"+attach.getUuid()+"_"+attach.getFilename());
				Files.deleteIfExists(file);
				Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadpath()+"\\s_"+attach.getUuid()+"_"+attach.getFilename());
				Files.delete(thumbNail);
			}catch(Exception e) {
				e.printStackTrace();
			}
		});
	}
}
