package com.bit.fn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {

	@RequestMapping("/intro")
	public String intro() {
		return "memberIntro";
	}
	
	@RequestMapping("/board")
	public String bbs() {
		return "memberBbs";
	}
	
	@RequestMapping("/board")
	public String notice() {
		return "memberBbs";
	}
	
	@RequestMapping("/board")
	public String roomREZ() {
		return "memberBbs";
	}
	
}