package com.bit.fn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bit.fn.model.service.AdminAccountService;
import com.bit.fn.security.model.Account;
import com.bit.fn.security.service.AccountService;


@Controller
@ComponentScan
public class AccountController {
	@Autowired
	AdminAccountService adminAccountService;
	
	@Autowired
	private AccountService accountService;
	
	
	/*
	@RequestMapping("/index")
	public ModelAndView index() {
		ModelAndView mav=new ModelAndView();
		mav.addObject("list",adminAccountService.selectAll());
		return mav;
	}
	*/
	
	@GetMapping("/login")
	public String login() {
		return "test/login";
	}
	
	@GetMapping("/resister")
	public String resister() {
		
		return "test/resister";
	}
	
	@GetMapping("/jungbok")
	public String jungbok() {
		
		return "test/jungbok";
	}
	
	@GetMapping("/user")
	public String user() {
		
		return "test/user";
	}
	
	@GetMapping("/denied")
	public String denied() {
		
		return "test/denied";
	}
	
	@PostMapping("/resister")
	public String resister(Account account) {
		try {
		accountService.save(account);
		}catch (Exception e) {
			return "redirect:/jungbok";
		}
		return "redirect:/index";
	}
	
	
}
