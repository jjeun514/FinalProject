package com.example.demo.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.test.service.TestService;
import com.example.demo.test.vo.TestVo;

@Controller
@ComponentScan(basePackageClasses = {Test2controller.class})
public class Test2controller {
	@Autowired
	TestService testService;
	
	@RequestMapping(value = "/test")
	public ModelAndView test() throws Exception{
		List<TestVo> testList = testService.selectTest();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list",testList);
		mav.setViewName("test");
		return mav;
	}
	
}
