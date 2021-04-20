package com.bit.fn.controller;

import java.security.Principal;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bit.fn.model.service.AdminAccountService;
import com.bit.fn.model.service.MemberinfoService;
import com.bit.fn.security.model.Account;
import com.bit.fn.security.service.AccountService;


@Controller
@ComponentScan
public class AccountController {
	@Autowired
	AdminAccountService adminAccountService;
	
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private MemberinfoService memberinfoService;
	
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
		accountService.memverSave(account);
		}catch (Exception e) {
			return "redirect:/jungbok";
		}
		return "redirect:/index";
	}
	
	
	@PostMapping("/joinMember")
	public String joinMember(Account account,@Param("memName")String memName, String memNickName, @RequestParam(name = "username") String id,int comCode,String dept, String memPhone) {
		System.out.println(account);
		System.out.println("memName="+memName);
		System.out.println("memNickName="+memNickName);
		System.out.println("id="+id);
		System.out.println("comCode="+comCode);
		System.out.println("dept="+dept);
		System.out.println("memPhone="+memPhone);
		try {
		memberinfoService.insertOne(memName, memNickName, id, comCode, dept, memPhone);
		accountService.memverSave(account);
		
		}catch (Exception e) {
			e.printStackTrace();
			return "redirect:/jungbok";
		}
		return "redirect:/index";
	}
	
	
	@GetMapping("/test/info")
	public String test(Principal  principal,Model model) {
		
		String id = principal.getName();
		
		int one=principal.toString().indexOf("ROLE_ADMIN");
		
		int two=principal.toString().indexOf("ROLE_MASTER");
		
		int three=principal.toString().indexOf("ROLE_MEMBER");
		
		System.out.println("아이디 = " + id);
		System.out.println("admin 인가? = "+one);
		System.out.println("master 인가? = "+two);
		System.out.println("member 인가? = "+three);
		
		model.addAttribute("list",principal.toString().indexOf("ROLE_ADMIN"));
		model.addAttribute("ss","send");
		
		return "test/info";
	}
	
}
