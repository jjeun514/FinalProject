package com.bit.fn.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.fn.model.service.BoardService;
import com.bit.fn.model.vo.BoardVo;

@Controller
public class MemberController {

	@Autowired
	private BoardService service;
	
	@RequestMapping("/intro")
	public String intro() {
		return "memberIntro";
	}
	
	// 멤버 페이지 게시판
	@RequestMapping("/board")
	public String bbs(Model model) { // 스프링이 자동으로 모델 객체를 참조해줌
		
		List<BoardVo> boardList = service.memberBoardList();
		model.addAttribute("boardList", boardList);
		
		return "memberBoard";
	}
	
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