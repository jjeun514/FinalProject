package com.bit.fn.controller;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.fn.model.service.CompanyinfoService;
import com.bit.fn.model.service.MailService;

@Controller
@Component
public class MailController {
	@Autowired
	MailService mailService;
	@Autowired
	CompanyinfoService companyinfoService;
	String to;

	// 회원 가입 페이지
	@RequestMapping("/signup")
	String signup(Model model) {
		model.addAttribute("company",companyinfoService.selectAll());
		return "signup";
	}
	
	// 이메일 인증 코드가 발송되는 부분
	@RequestMapping(path="/signup", method=RequestMethod.POST)
	@ResponseBody
	public String auth(String email) {
		String code="";
		to=email;
		
		try {
			// 인증번호 메일 보내기
			code=mailService.sendMail(to);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		// 인증번호 일치 여부 확인 (인증번호 전송된 이메일인지도 확인)
		return code;
	}
	
	// 비밀번호 찾기 (이메일 전송)
	@ResponseBody
	public String forgotPw(String email) {
		String code="";
		to=email;
			
		try {
			// 인증번호 메일 보내기
			code=mailService.sendMail(to);
			// 비밀번호 변경 링크 전송
			mailService.sendMail(to);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return code;
	}
}