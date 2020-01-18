package org.akak4456.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	@GetMapping("/accessError")
	public void accessError() {
		
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error: "+error);
		log.info("logout: "+logout);
		if(error != null) {
			model.addAttribute("error","아이디 또는 비밀번호가 틀렸습니다");
		}
		if(logout != null) {
			model.addAttribute("logout","로그아웃 되었습니다");
		}
	}
	
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("customLogout get");
	}
	
	@PostMapping("/customLogout")
	public void logoutPOST() {
		
	}
}
