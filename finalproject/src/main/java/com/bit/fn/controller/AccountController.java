  
package com.bit.fn.controller;

import java.net.http.HttpRequest;
import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.fn.model.service.AccountRoleService;
import com.bit.fn.model.service.AdminAccountService;
import com.bit.fn.model.service.MasterAccountService;
import com.bit.fn.model.service.MemberinfoService;
import com.bit.fn.security.model.Account;
import com.bit.fn.security.service.AccountService;


@Controller
@ComponentScan
public class AccountController {
	@Autowired
	private com.bit.fn.model.service.UserAccountService u_accountService;
	
	@Autowired
	private AccountService s_accountService;
	
	@Autowired
	AdminAccountService adminAccountService;
	
	@Autowired
	MasterAccountService masterAccountService;
	
	@Autowired
	private MemberinfoService memberinfoService;
	
	@Autowired
	AccountRoleService accountRoleService;
	
	/*
	@RequestMapping("/index")
	public ModelAndView index() {
		ModelAndView mav=new ModelAndView();
		mav.addObject("list",adminAccountService.selectAll());
		return mav;
	}
	*/
	
	//로그인
	@GetMapping("/login")
	public String login() {
		return "test/login";
	}
	
	@GetMapping("/signin")
	public String signin() {
		return "/signin";
	}
	
	//지울예정
	@GetMapping("/resister")
	public String resister() {
		
		return "test/resister";
	}
	
	//지울예정
	@GetMapping("/jungbok")
	public String jungbok() {
		
		return "test/jungbok";
	}
	
	//지울예정
	@GetMapping("/user")
	public String user() {
		
		return "test/user";
	}
	
	
	//지울예정인 예전 회원가입
	@PostMapping("/resister")
	public String resister(Account account) {
		try {
			s_accountService.memverSave(account);
		}catch (Exception e) {
			return "redirect:/jungbok";
		}
		return "redirect:/index";
	}
	
	
	//멤버 회원가입
	@PostMapping("/joinMember")
	public String joinMember(Account account, String memName, String username, String memNickName, int comCode,String dept, String memPhone) {
		System.out.println("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■username="+username);
		System.out.println(account);
		System.out.println("memName="+memName);
		System.out.println("memNickName="+memNickName);
		System.out.println("id="+username);
		System.out.println("comCode="+comCode);
		System.out.println("dept="+dept);
		System.out.println("memPhone="+memPhone);
		
		try {
		memberinfoService.insertOne(memName, memNickName, username, comCode, dept, memPhone);
		s_accountService.memverSave(account);
		
		}catch (Exception e) {
			e.printStackTrace();
			return "redirect:/jungbok";
		}
		return "redirect:/index";
	}
	
	
	//테스트용(지울예정)
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
	
	//계정 확인
	@RequestMapping(path="/usercheck", method=RequestMethod.POST)
	@ResponseBody
	public String usercheck(@RequestBody String username ) {
		
		String id=username.replace("%40", "@").split("username=")[1];
		System.out.println(id);
		int count=memberinfoService.idCount(id);
		System.out.println("바뀐후="+count);
		   
		if(count != 0) {
			System.out.println("Already in use");
			 id="Already in use";
		}else {
			System.out.println("Available");
			 id="Available";
		}
		return id;
	}
	
	//닉네임 확인
	@RequestMapping(path="/nickNameCheck", method=RequestMethod.POST, produces = "application/x-www-form-urlencoded; charset=UTF-8")
	@ResponseBody
	public String nickNameCheck(String memNickName ) {
		
		System.out.println("---------------받은 닉네임 = "+memNickName);
		int count=memberinfoService.nicknameCount(memNickName);
		System.out.println("바뀐후="+count);
		   
		if(count != 0) {
			System.out.println("Already in use");
			memNickName="Already in use";
			
		}else {
			System.out.println("Available");
			memNickName="Available";
		}
		return memNickName;
	}
	
	//비밀번호 확인
	@RequestMapping(path="/checkPw", method=RequestMethod.POST, produces = "application/x-www-form-urlencoded; charset=UTF-8")
	@ResponseBody
	public String checkPw(String pw, Principal principal) {
		
		String username = principal.getName();
		System.out.println("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■유저네임= "+username);
		
		String dbpassword=u_accountService.selectOne(username).getPassword();
		
		System.out.println(dbpassword);
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		String result = null;		
		
		if(encoder.matches(pw, dbpassword)) {
		 result = "correct";	
		}else {
		 result = "incorrect";
		}
		
		return result;
	}
	
	//비밀번호 변경
	@RequestMapping(path="/updatePw", method=RequestMethod.PUT, produces = "application/x-www-form-urlencoded; charset=UTF-8")
	@ResponseBody
	public String updatePw(String newCheckPw, Principal principal) {
		
		String username = principal.getName();
		System.out.println("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■유저네임= "+username);
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		newCheckPw=encoder.encode(newCheckPw);
		
		int result=u_accountService.updatePw(newCheckPw, username);
		System.out.println("결과값="+result);
		String send="failure";
		if(result == 1) {
			send="success";
		}
		return send;
	}
	
	//회원탈퇴
	@DeleteMapping("/withdraw")
	public String withdraw(Principal principal, HttpSession session) {
		//아이디
		String username = principal.getName();
		
		//권한 여부
		int admin=principal.toString().indexOf("ROLE_ADMIN");
		int master=principal.toString().indexOf("ROLE_MASTER");
		int member=principal.toString().indexOf("ROLE_MEMBER");
		
		//권한에 따른 계정 정보 삭제
		if(admin != -1) {
			System.out.println("탈퇴할 계정은 어드민입니다.");
			adminAccountService.deleteOne(username);
		}else if(master != -1) {
			System.out.println("탈퇴할 계정은 마스터입니다.");
			masterAccountService.deleteOne(username);
		}else if(member != -1) {
			System.out.println("탈퇴할 계정은 멤버입니다.");
			memberinfoService.deleteOne(username);
		}else {
			return "redirect:/index";
		}
		
		//accountRole 권한 삭제
		int accountNum = u_accountService.selectOne(username).getNum();
		accountRoleService.deleteOne(accountNum);
		
		//account 계정 삭제
		u_accountService.deleteOne(username);
		
		//로그아웃
		session.invalidate();
		
		return "redirect:/index";
	}
	
	
	
	
	
	
}