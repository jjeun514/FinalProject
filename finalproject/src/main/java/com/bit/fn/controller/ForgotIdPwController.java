package com.bit.fn.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
		return "forgotIdPw";
	}
	// 아이디 찾기
	@RequestMapping(path="forgotId", method = RequestMethod.POST)
	public ResponseEntity forgotId(String name, String phone, HttpServletResponse resp, Model model) throws NullPointerException {
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			memberId=memberInfoService.selectId(name, phone).getId();
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				jobj.put("id", memberId);
				out = resp.getWriter();
				out.print(jobj.toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return new ResponseEntity(status);
	}
	
	// 비밀번호 찾기
	@RequestMapping(path="forgotPw", method = RequestMethod.POST)
	public ResponseEntity forgotPw(String name, String id, String phone, HttpServletResponse resp, Model model) throws NullPointerException {
		// 일치하는 name, id, phone 정보가 db에 있는지 확인해야함
		MemberInfoVo checkInfo=memberInfoService.checkInfo(name, id, phone);
		HttpStatus status;
		String code="";
		try {
			status=HttpStatus.OK;
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				if(checkInfo!=null) {
					code=mailController.forgotPw(id);
					jobj.put("code", code);
					out = resp.getWriter();
					out.print(jobj.toString());
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return new ResponseEntity(status);
	}
	
	
	@RequestMapping(path =  "newPw", method = RequestMethod.POST)
	public String newPw() {
		return "newPw";
	}
}