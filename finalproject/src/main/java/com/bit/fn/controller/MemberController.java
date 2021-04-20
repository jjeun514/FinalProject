package com.bit.fn.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.fn.model.service.MemberService;
import com.bit.fn.model.vo.BoardVo;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	@RequestMapping("/intro")
	public String intro() {
		return "memberIntro";
	}
	
	// 멤버 페이지 게시판
	@RequestMapping("/board")
	public String bbs(Model model) {
		
		List<BoardVo> boardList = service.memberBoardList();
		model.addAttribute("boardList", boardList);
		
		return "memberBoard";
	}
	
	// 멤버 페이지 공지 게시판
	@RequestMapping("/notice")
	public String notice() {
		
		
		
		return "memberNotice";
	}
	
	@RequestMapping("/reservation")
	public String roomREZ() {
		return "memberREZ";
	}
	
	@RequestMapping("/schedule")
	public String schedule() {
		return "memberSchedule";
	}
	
}