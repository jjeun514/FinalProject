package com.bit.fn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.fn.model.service.CompanyinfoService;
import com.bit.fn.model.service.MasterAccountService;
import com.bit.fn.model.service.join.MasteraccountAndCompanyInfoService;
import com.bit.fn.security.model.Account;
import com.bit.fn.security.service.AccountService;

@Controller
@ComponentScan
public class MasterController {
	@Autowired
	CompanyinfoService companyinfoService;
	
	@Autowired
	AccountService s_accountService;

	@Autowired
	MasteraccountAndCompanyInfoService masteraccountAndCompanyInfoService;
	
	@Autowired
	MasterAccountService masterAccountService;
	
	
	//마스터 회원가입
	@RequestMapping("masterSignup")
	public String masterSignup(Model model) {
		model.addAttribute("company",companyinfoService.selectAll());
		return "/masterSignup";
	}
	
	//멤버 회원가입
		@PostMapping("/joinMaster")
		public String joinMaster(Account account, String username, int comCode) {
			System.out.println("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■username="+username);
			System.out.println(account);
			System.out.println("id="+username);
			System.out.println("comCode="+comCode);
			
			try {
			masterAccountService.insertOne(username, comCode);
			s_accountService.masterSave(account);
			
			}catch (Exception e) {
				e.printStackTrace();
				return "redirect:/jungbok";
			}
			return "redirect:/index";
		}
	
}
