package com.bit.fn.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.fn.model.service.MemberService;
import com.bit.fn.model.vo.BoardVo;
import com.bit.fn.model.vo.NoticeVo;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	@RequestMapping("/intro")
	public String intro() {
		return "memberIntro";
	}
	
	// 멤버 파트 게시판 인트로 페이지
	@RequestMapping("/board")
	public String bbs(Model model) {
		
		List<BoardVo> boardList = service.memberBoardList();
		model.addAttribute("boardList", boardList);
		
		return "memberBoard";
	}
	
	// 멤버 파트 공지 게시판 인트로 페이지
	@RequestMapping("/notice")
	public String notice(Model model) {
		
		List<NoticeVo> noticeList = service.noticeList();
		model.addAttribute("noticeList", noticeList);
		
		return "memberNotice";
	}
	
	// 멤버 파트 회의실 예약 인트로 페이지
	@RequestMapping("/reservation")
	public String roomREZ() {
		return "memberREZ";
	}
	
	// 멤버 파트 내 스케쥴 관리 인트로 페이지
	@RequestMapping("/schedule")
	public String schedule() {
		return "memberSchedule";
	}
	
}