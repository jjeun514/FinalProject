package com.bit.fn.controller;

import java.security.Principal;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.fn.model.service.AdminAccountService;
import com.bit.fn.model.service.MasterAccountService;
import com.bit.fn.model.service.MemberinfoService;
import com.bit.fn.model.service.join.BranchAndAdminService;
import com.bit.fn.model.service.join.MasteraccountAndCompanyInfoService;
import com.bit.fn.model.service.join.MemberInfoAndCompanyInfoService;

@Controller
public class ViewTestController {
	@Autowired
	BranchAndAdminService branchAndAdminService;
	
	@Autowired
	MasterAccountService masterAccountService;
	
	@Autowired
	MemberinfoService memberinfoService;
	
	@Autowired
	MemberInfoAndCompanyInfoService memberInfoAndCompanyInfoService;
	
	@Autowired
	MasteraccountAndCompanyInfoService masteraccountAndCompanyInfoService;
	
	@Autowired
	AdminAccountService adminAccountService;
	
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
	
	//마이페이지
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
			System.out.println(branchAndAdminService.adminOne(id));
			model.addAttribute("admin",branchAndAdminService.adminOne(id));
		}else if(master != -1) {
			System.out.println("접속하신 계정은 마스터입니다.");
			System.out.println(masteraccountAndCompanyInfoService.masterOne(id).getCompanyInfo().getCeo());
			masteraccountAndCompanyInfoService.masterOne(id).getMasteraccount().getId();
			model.addAttribute("master",masteraccountAndCompanyInfoService.masterOne(id));
			int comCode=masteraccountAndCompanyInfoService.masterOne(id).getMasteraccount().getComCode();
			
		}else if(member != -1) {
			System.out.println("접속하신 계정은 멤버입니다.");
			System.out.println(memberInfoAndCompanyInfoService.memberOne(id).getMemberInfo().getMemName());
			model.addAttribute("member",memberInfoAndCompanyInfoService.memberOne(id));
			
		}else {
			return "redirect:/index";
		}
		
		return "myPage";
	}
	
	//마이페이지 정보수정
	@PutMapping("/modifyInfo")
	public String modifyInfo(Principal  principal, @RequestParam Map<String, String> allParameters) {
		System.out.println(allParameters.toString());
		
		//아이디
		String id = principal.getName();
		System.out.println(id);
		
		//권한 여부
		int admin=principal.toString().indexOf("ROLE_ADMIN");
		int master=principal.toString().indexOf("ROLE_MASTER");
		int member=principal.toString().indexOf("ROLE_MEMBER");
		
		
		//여기서 중점! 권한 여부에 따라 불러오는 테이블 값을 다르게 줄 수 있다!
		if(admin != -1) {
			System.out.println("어드민 수정");
			System.out.println(allParameters.get("adminNickName"));
			if(1!=adminAccountService.updateInfo(allParameters.get("adminNickName"),id)) {
				System.out.println("실패ㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐㅐ");
			}
			
		}else if(master != -1) {
			System.out.println("마스터 수정");
			//System.out.println(masterAccountService.selectOne(id));
			masteraccountAndCompanyInfoService.masterOne(id).getMasteraccount().getId();
			
			String comName=allParameters.get("comName");
			String ceo=allParameters.get("ceo");
			String manager=allParameters.get("manager");
			String comPhone=allParameters.get("comPhone");
			
			masteraccountAndCompanyInfoService.updateInfo(comName, ceo, manager, comPhone, id);
		}else if(member != -1) {
			System.out.println("멤버 수정");
			String memNickName=allParameters.get("memNickName");
			String memPhone=allParameters.get("memPhone");
			String dept=allParameters.get("dept");
			memberInfoAndCompanyInfoService.updateInfo(memNickName, memPhone, dept, id);
		}
		
		
		return "redirect:/mypage";
	}
	
	@RequestMapping("/test")
	public String sample() {
		return "test";
	}
	
	
	
}
