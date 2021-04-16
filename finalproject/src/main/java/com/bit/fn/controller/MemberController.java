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
		return "memberBoard";
	}
	
	@RequestMapping("/notice")
	public String notice() {
		return "memberNotice";
	}
	
	@RequestMapping("/reservation")
	public String roomREZ() {
		return "memberREZ";
	}
	
	@RequestMapping("/schedule")
	public String schedule() {
		return "memberSchedule";
	}
	
}