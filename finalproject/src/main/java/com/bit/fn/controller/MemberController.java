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
	public HashMap<String, Object> roomReservaionApply(Model model, ReservationVo applyContent) {
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		// 예약 날짜, 예약자 정보도 받아와야 함
		
		int roomNum = applyContent.getRoomNum();
		String useStartTime = applyContent.getUseStartTime();
		String useFinishTime = applyContent.getUseFinishTime();
		int userCount = applyContent.getUserCount();
		System.out.println("회의실 번호 : "+roomNum);
		System.out.println("사용 시작 시간 : "+useStartTime);
		System.out.println("사용 종료 시간 : "+useFinishTime);
		System.out.println("사용 인원 : "+userCount);
		
		ReservationVo reservation = new ReservationVo();
		reservation.setRoomNum(applyContent.getRoomNum());
		reservation.setUseStartTime(applyContent.getUseStartTime());
		reservation.setUseFinishTime(applyContent.getUseFinishTime());
		reservation.setUserCount(applyContent.getUserCount());
		
		/*
		 * 주요한 문제 : 파라미터로 사용 시간을 받아올 때 1시간 / 2시간 이렇게 받아올텐데
		 * 이걸 쿼리에 어떻게 심을건지 고민해봐야 함
		 * 왜냐하면 현재 useFinishTime은 DATA 타입으로 설정되어 있기 때문에
		 * 시작 시간에서 파라미터로 받아온 사용 시간을 어떻게 더해서 쿼리로 날릴지 확인해야 하기 때문
		 */
		
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
			System.out.println("신청 쿼리의 수행 결과 : "+insertReservaion);
			
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