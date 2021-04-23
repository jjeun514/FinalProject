package com.bit.fn.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.cassandra.CassandraProperties.Request;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.fn.model.service.MemberService;
import com.bit.fn.model.vo.BoardVo;
import com.bit.fn.model.vo.NoticeVo;
import com.bit.fn.model.vo.ReservationVo;

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
	public String roomREZ(Model model) {
		
		List<ReservationVo> roomList = service.mettingRoomList();
		model.addAttribute("roomList", roomList);
		
		return "memberREZ";
	}
	
	// 멤버 파트 회의실 예약 신청에 필요한 정보 전달
	@RequestMapping(value = "/reservation/apply")
	@ResponseBody
	public Map<String, Object> roomInfo() {
		
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		
		Map<String, String> data = null;
		List<ReservationVo> roomList = service.mettingRoomList();
		
		for(ReservationVo REZ : roomList) {
			data = new HashMap<String, String>();
			data.put("roomNum", Integer.toString(REZ.getRoomNum()));
			dataList.add(data);
		}
		
		Map<String, Object> roomData = new HashMap<String, Object>();
		roomData.put("roomData", dataList);
		// 예약날짜 예약자 정보도 전달해줘야 함
		
		return roomData;
	}
	
	// 멤버 파트 회의실 예약 신청
	@RequestMapping(value = "/reservation/applySubmit", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> roomReservaionApply(Model model, HttpServletRequest request) {
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		// 여기서 request parameter를 한꺼번에 받을 수 있는 방법..뭐가 좋을까?
		// 예약 날짜, 예약자 정보도 받아와야 함
		int roomNum = Integer.parseInt(request.getParameter("roomNum"));
		String useStartTime = request.getParameter("useStartTime");
		String useFinishTime = request.getParameter("useFinishTime");
		int useCount = Integer.parseInt(request.getParameter("useCount"));
		
		ReservationVo reservation = new ReservationVo();
		reservation.setRoomNum(roomNum);
		reservation.setUseStartTime(useStartTime);
		reservation.setUseFinishTime(useFinishTime);
		reservation.setUserCount(useCount);
		
		// 제대로 isert가 되는지(쿼리 정상 수행 여부 / 메소드 정상 수행 여부 / ajax 수행 여부) 확인 후 주석 풀어서 조회 메소드 수행되는지 확인
//		int checkReservation = service.checkReservaion(roomNum, useStartTime, useFinishTime);
//		
//		if ( checkReservation > 0 ) { // 여기서 조회한 값이 있는 것을 먼저 처리하는 것이 나을지? 아니면 지금대로 해도 될지?
//			
//			String resultMessage = "이미 예약된 내용입니다. 예약 현황을 확인 후 다시 신청해주세요.";
//			String resultCode = "-1";
//			
//			result.put("resultMessage", resultMessage);
//			result.put("resultCode",resultCode);
//			
//			return result;
//			
//		} else {
		
			int insertReservaion = service.roomReservationApply(reservation);
			
			if ( insertReservaion > 0 ) {
				String resultMessage = "예약 신청이 완료되었습니다. 결제창으로 이동하시겠습니까?";
				String resultCode = "0";
				
				result.put("resultMessage", resultMessage);
				result.put("resultCode", resultCode);
				
				return result;
				
			} else {
				String resultMessage = "예약 신청에 실패했습니다. 다시 시도해주세요.";
				String resultCode = "1";
				
				result.put("resultMessage", resultMessage);
				result.put("resultCode", resultCode);
				
				return result;
			}
//		}
	}
	
	// 멤버 파트 내 스케쥴 관리 인트로 페이지 ... 구현할 수 있을까?
	@RequestMapping("/schedule")
	public String schedule() {
		return "memberSchedule";
	}
	
}