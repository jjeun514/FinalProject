package com.bit.nam.model.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bit.nam.model.service.DeptService;

@Controller
@ComponentScan
public class DeptController {
	@Autowired
	DeptService deptService;
	
	@RequestMapping("/index")
	public ModelAndView index() {
		ModelAndView mav=new ModelAndView();
		mav.addObject("list",deptService.selectAll());
		return mav;
	}
}
