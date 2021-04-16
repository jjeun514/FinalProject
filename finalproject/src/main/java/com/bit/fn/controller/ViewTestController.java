package com.bit.fn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ViewTestController {

	@RequestMapping("/index")
	public String main() {
		return "index";
	}
	
	@RequestMapping("/bbs")
	public String bbs() {
		return "bbs";
	} 
	
	@RequestMapping("/detail")
	public String detail() {
		return "detail";
	}
	
	@RequestMapping("/mypage")
	public String myPage() {
		return "myPage";
	}
	
	@RequestMapping("/test")
	public String sample() {
		return "test";
	}
	
}
