package com.bit.fn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ForgotIdPwController {
	@RequestMapping("forgotIdPw")
	public String forgotIdPw() {
		System.out.println("[ForgotIdPwController] forgotIdPw");
		
		return "forgotIdPw";
	}
	@RequestMapping(path="forgotId", method = RequestMethod.POST)
	public String forgotId() {
		System.out.println("[ForgotIdPwController] forgotId");
		return "forgotIdPw";
	}
	@RequestMapping(path="forgotPw", method = RequestMethod.POST)
	public String forgotPw() {
		System.out.println("[ForgotIdPwController] forgotPw");
		
		return "forgotIdPw";
	}
}