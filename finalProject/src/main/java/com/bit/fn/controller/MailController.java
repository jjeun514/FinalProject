package com.bit.fn.controller;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.fn.bean.EmailBean;
import com.bit.fn.model.service.MailService;

@Controller
@Component
public class MailController {
	@Autowired
	MailService mailService;
	
	String to;

	// 회원 가입 페이지
	@RequestMapping("/signup")
	String signup() {
		System.out.println("[MailController(signup())]");
		return "signup";
	}
	
	// 이메일 인증 코드가 발송되는 부분
	@RequestMapping(path="/signup", method=RequestMethod.POST)
	@ResponseBody
	public String auth(String email) {
		String code="";
		System.out.println("[MailController(auth())]");
		to=email;
		System.out.println("[MailController(auth())] to: "+to);
		
		try {
			// 인증번호 메일 보내기
			code=mailService.sendMail(to);
			System.out.println("[MailController(auth())] code: "+code);
			System.out.println("[MailController(auth())] 메일 발송 성공");
		} catch (MessagingException e) {
			System.out.println("[MailController(auth())] 메일 발송 실패");
			e.printStackTrace();
		}
		
		// 인증번호 일치 여부 확인 (인증번호 전송된 이메일인지도 확인)
		return code;
	}
	
	// 비밀번호 찾기 (이메일 전송)
	@ResponseBody
	public String forgotPw(String email) {
		String code="";
		System.out.println("[MailController(forgotPw())]");
		to=email;
		System.out.println("[MailController(forgotPw())] to: "+to);
			
		try {
			// 인증번호 메일 보내기
			code=mailService.sendMail(to);
			System.out.println("[MailController(forgotPw())] code: "+code);
			System.out.println("[MailController(forgotPw())] 인증번호 발송 성공");
			// 비밀번호 변경 링크 전송
			mailService.sendMail(to);
			System.out.println("[MailController(forgotPw())] code: "+code);
			System.out.println("[MailController(forgotPw()] 메일 발송 성공");
		} catch (MessagingException e) {
			System.out.println("[MailController(forgotPw()] 메일 발송 실패");
			e.printStackTrace();
		}
		return code;
	}
}