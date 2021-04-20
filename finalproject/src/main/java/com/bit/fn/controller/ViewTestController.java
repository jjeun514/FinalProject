package com.bit.fn.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.fn.model.service.AdminAccountService;
import com.bit.fn.model.service.MasterAccountService;
import com.bit.fn.model.service.MemberinfoService;

@Controller
public class ViewTestController {
	@Autowired
	AdminAccountService adminaccountservice;
	
	@Autowired
	MasterAccountService masterAccountService;
	
	@Autowired
	MemberinfoService memberinfoService;
	
	
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
	public String myPage(Principal  principal,Model model) {
		//아이디
		String id = principal.getName();
		
		//권한 여부
		int admin=principal.toString().indexOf("ROLE_ADMIN");
		int master=principal.toString().indexOf("ROLE_MASTER");
		int member=principal.toString().indexOf("ROLE_MEMBER");
		
		System.out.println("아이디 = " + id);
		System.out.println("admin 인가? = "+admin);
		System.out.println("master 인가? = "+master);
		System.out.println("member 인가? = "+member);
		
		//값이 잘 불러오는지 프로필 불러와봄
		
		
		//여기서 중점! 권한 여부에 따라 불러오는 테이블 값을 다르게 줄 수 있다!
		if(admin != -1) {
			System.out.println("접속하신 계정은 어드민입니다.");
			System.out.println(adminaccountservice.selectOne(id));
			model.addAttribute("admin",adminaccountservice.selectOne(id));
		}else if(master != -1) {
			System.out.println("접속하신 계정은 마스터입니다.");
			System.out.println(masterAccountService.selectOne(id));
			model.addAttribute("master",masterAccountService.selectOne(id));
		}else if(member != -1) {
			System.out.println("접속하신 계정은 멤버입니다.");
			System.out.println(memberinfoService.selectOne(id));
			model.addAttribute("member",memberinfoService.selectOne(id));
		}
		
		
		return "myPage";
	}
	
	@RequestMapping("/test")
	public String sample() {
		return "test";
	}
	
}
