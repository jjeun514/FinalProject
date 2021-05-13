package com.bit.fn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bit.fn.model.service.join.BranchAndAdminService;

@Controller
@ComponentScan
public class JoinController {
	@Autowired
	BranchAndAdminService branchAndAdminService;
	
	//삭제예정
	@RequestMapping("/join")
	public String join() {
		//mav.addObject("list",branchAndAdminService.selectAll());
		//mav.addObject("aa",branchAndAdminService.selectaa());
		return "test/join";
	}
	
}
