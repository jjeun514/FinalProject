package com.example.demo.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.test.service.TestService;
import com.example.demo.test.vo.TestVo;

@RestController
public class TestController {
	
	@RequestMapping(value = "/")
	public String home() throws Exception{
		return "Hello World";
	}
	
}
