package com.bit.fn.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bit.fn.model.service.MemberinfoService;
import com.bit.fn.model.vo.MemberInfoVo;

@Controller
@ComponentScan
public class ForgotIdPwController {
	@Autowired
	MemberinfoService memberInfoService;
	@Autowired
	MailController mailController;
	
	private String memberId;
	
	@RequestMapping("forgotIdPw")
	public String forgotIdPw(Model model) {
		System.out.println("[ForgotIdPwController(forgotIdPw())] forgotIdPw");
		return "forgotIdPw";
	}
	// 아이디 찾기
	@RequestMapping(path="forgotId", method = RequestMethod.POST)
	public ResponseEntity forgotId(String name, String phone, HttpServletResponse resp, Model model) throws NullPointerException {
		System.out.println("[ForgotIdPwController(forgotId())] forgotId");
		System.out.println("[ForgotIdPwController(forgotId())] name: "+name+", phone: "+phone);
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			memberId=memberInfoService.selectId(name, phone).getId();
			System.out.println("[ForgotIdPwController(forgotId())] id: "+memberId);
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				jobj.put("id", memberId);
				out = resp.getWriter();
				out.print(jobj.toString());
			} catch (IOException e) {
				System.out.println("[ForgotIdPwController(forgotId())] json 오류");
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			System.out.println("[ForgotIdPwController(forgotId())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[ForgotIdPwController(forgotId())] null");
		}
		return new ResponseEntity(status);
	}
	
	// 비밀번호 찾기
	@RequestMapping(path="forgotPw", method = RequestMethod.POST)
	public ResponseEntity forgotPw(String name, String id, String phone, HttpServletResponse resp, Model model) throws NullPointerException {
		System.out.println("[ForgotIdPwController(forgotPw())] forgotPw");
		System.out.println("[ForgotIdPwController(forgotPw())] name: "+name+", id: "+id+", phone: "+phone);
		// 일치하는 name, id, phone 정보가 db에 있는지 확인해야함
		MemberInfoVo checkInfo=memberInfoService.checkInfo(name, id, phone);
		System.out.println("[ForgotIdPwController(forgotPw())] member정보: "+checkInfo);
		HttpStatus status;
		String code="";
		try {
			status=HttpStatus.OK;
			System.out.println("[ForgotIdPwController(forgotPw())] checkInfo: "+memberInfoService.checkInfo(name, id, phone));
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
//				resp.setContentType("text/html;charset=UTF-8"); 
//				jobj.put("checkInfo", checkInfo);
//				out = resp.getWriter();
//				out.print(jobj.toString());
				if(checkInfo!=null) {
					System.out.println("[ForgotIdPwController(forgotPw())] member정보: "+checkInfo);
					code=mailController.forgotPw(id);
					jobj.put("code", code);
					out = resp.getWriter();
					out.print(jobj.toString());
				} else {
					System.out.println("[ForgotIdPwController(forgotPw())] member정보(null): "+checkInfo);
				}
			} catch (IOException e) {
				System.out.println("[ForgotIdPwController(forgotPw())] json 오류");
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			System.out.println("[ForgotIdPwController(forgotPw())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[ForgotIdPwController(forgotPw())] null");
		}
		return new ResponseEntity(status);
	}
}