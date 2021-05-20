package com.bit.fn.controller;

import java.security.Principal;

import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.fn.model.service.AccountRoleService;
import com.bit.fn.model.service.AdminAccountService;
import com.bit.fn.model.service.CompanyinfoService;
import com.bit.fn.model.service.MasterAccountService;
import com.bit.fn.model.service.MemberinfoService;
import com.bit.fn.model.service.OfficeService;
import com.bit.fn.model.service.join.AccountAndMemberInfoService;
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
	
	@Autowired
	AccountAndMemberInfoService accountAndMemberInfoService;
	
	@Autowired
	CompanyinfoService companyinfoService;
	
	@Autowired
	OfficeService officeService;
	
	//로그인
	@GetMapping("/login")
	public String login() {
		return "test/login";
	}
	
	@GetMapping("/signin")
	public String signin() {
		return "/signin";
	}
	
	//멤버 회원가입
	@PostMapping("/joinMember")
	public String joinMember(Account account, String memName, String username, String memNickName, int comCode,String dept, String memPhone) {
		try {
		memberinfoService.insertOne(memName, memNickName, username, comCode, dept, memPhone);
		s_accountService.memverSave(account);
		
		}catch (Exception e) {
			e.printStackTrace();
			return "redirect:/jungbok";
		}
		return "redirect:/index";
	}
	
	//계정 확인
	@RequestMapping(path="/usercheck", method=RequestMethod.POST)
	@ResponseBody
	public String usercheck(@RequestBody String username ) {
		
		String id=username.replace("%40", "@").split("username=")[1];
		int count=memberinfoService.idCount(id);
		   
		if(count != 0) {
			 id="Already in use";
		}else {
			 id="Available";
		}
		return id;
	}
	
	//닉네임 확인
	@RequestMapping(path="/nickNameCheck", method=RequestMethod.POST, produces = "application/x-www-form-urlencoded; charset=UTF-8")
	@ResponseBody
	public String nickNameCheck(String memNickName ) {
		
		int count=memberinfoService.nicknameCount(memNickName);
		   
		if(count != 0) {
			memNickName="Already in use";
			
		}else {
			memNickName="Available";
		}
		return memNickName;
	}
	
	//비밀번호 확인
	@RequestMapping(path="/checkPw", method=RequestMethod.POST, produces = "application/x-www-form-urlencoded; charset=UTF-8")
	@ResponseBody
	public String checkPw(String pw, Principal principal) {
		
		String username = principal.getName();
		
		String dbpassword=u_accountService.selectOne(username).getPassword();
		
		
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
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		newCheckPw=encoder.encode(newCheckPw);
		
		int result=u_accountService.updatePw(newCheckPw, username);
		String send="failure";
		if(result == 1) {
			send="success";
		}
		return send;
	}
	
	//비밀번호 찾기 후 비밀번호 변경
		@RequestMapping(path="/forgotUpdatePw", method=RequestMethod.PUT, produces = "application/x-www-form-urlencoded; charset=UTF-8")
		@ResponseBody
		public String updatePw(String newPwConfirm, String hiddenInputId) {
			
			
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			
			newPwConfirm=encoder.encode(newPwConfirm);
			
			int result=u_accountService.updatePw(newPwConfirm, hiddenInputId);
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
			adminAccountService.deleteOne(username);
		}else if(master != -1) {
			//회사 코드 불러오기
			int comCode = masterAccountService.selectOne(username).getComCode();
			//사무실 번호 불러오기
			int officeNum = companyinfoService.selectOfficeNum(comCode);
			//마스터 계정 삭제
			masterAccountService.deleteOne(username);
			//회사 정보 삭제
			companyinfoService.deleteCompanyInfo(comCode);
			//사무실 공실 업데이트
			officeService.updateOccupancy(officeNum, 0);
		}else if(member != -1) {
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
	
	
	//권한 변경
		@RequestMapping(path="/updateMemberAdmission", method=RequestMethod.PUT, produces = "application/x-www-form-urlencoded; charset=UTF-8")
		@ResponseBody
		public String updateMemberAdmission(String currAdmission, String memberId) {
			int isupdate=-1;
			//허용->비허용
			if("허용".equals(currAdmission)) {
				isupdate = accountAndMemberInfoService.updateMemberAdmission(0, 0, memberId);
			//비허용->허용
			}else {
				isupdate = accountAndMemberInfoService.updateMemberAdmission(1, 1, memberId);
			}
			
			if(isupdate==2) {
				return "updated";
			}
			
			return "false";
		}
	
	
	
}
