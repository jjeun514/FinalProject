package com.bit.fn.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.fn.model.service.MemberService;
import com.bit.fn.model.vo.BoardVo;
import com.bit.fn.model.vo.NoticeVo;
import com.bit.fn.model.vo.PaginationVo;
import com.bit.fn.model.vo.ReservationVo;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	// 결제 기능 객체 생성
	private IamportClient api;
	
	
	
	// 아임포트 결제 토큰 생성
	public MemberController() {
		this.api = new IamportClient("2685051238690929", "7Qmf22eaAAMqEnDEnqXB5yRprnWSZG56xsmzuBK4bxuPV8uizrUE0L3s90l9GqgeTCNneyrp6Wf15JjE");
	}
	
	
	
	// 멤버 파트 인트로 페이지
	@RequestMapping("/intro")
	public String intro() {
		return "memberIntro";
	}
	
	
	
	// 멤버 파트 게시판 인트로 페이지
	@RequestMapping("/board")
	public String bbs(Model model, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "countPerPage", required = false, defaultValue = "10") int countPerPage,
            @RequestParam(value = "pageSize", required = false, defaultValue = "7") int pageSize) {
		
		int listCount = service.countBoardList();
        PaginationVo pagination = new PaginationVo(currentPage, countPerPage, pageSize);
        pagination.setTotalRecordCount(listCount);
        pagination.calculation();
		
		// 게시판에 보여줄 게시글 불러오기
		List<PaginationVo> boardList = service.memberBoardPaginationList(pagination);
		List<NoticeVo> selectNotice = service.selectNoticeList();
		
		// 페이징 값 보내기
		model.addAttribute("pagination", pagination);
		
		// 모델 객체에 리스트 담아서 뷰로 전달
		model.addAttribute("boardList", boardList);
		model.addAttribute("NoticeList", selectNotice);
		
		return "memberBoard";
	}
	
	
	
	// 멤버 파트 게시판 디테일
	@RequestMapping(value = "/board/detail", method = RequestMethod.GET)
	public String boardDetail(Model model, @RequestParam(value = "selectNum") int selectNum) {
		
		BoardVo detail = service.selectOneContent(selectNum);
		
		model.addAttribute("detail", detail);
		
		return "memberBoardDetail";
	}
	
	
	
	// 멤버 파트 공지 게시판 인트로 페이지
	@RequestMapping("/notice")
	public String notice(Model model, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "countPerPage", required = false, defaultValue = "10") int countPerPage,
            @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize) {
		
		int listCount = service.countNoticeList();
        PaginationVo pagination = new PaginationVo(currentPage, countPerPage, pageSize);
        pagination.setTotalRecordCount(listCount);
        pagination.calculation();
		
		// 게시판에 보여줄 공지 게시글 불러오기
		List<NoticeVo> noticeList = service.noticeList(pagination);
		
		// 페이징 값 보내기
		model.addAttribute("pagination", pagination);
		
		// 모델 객체에 리스트 담아서 뷰로 전달
		model.addAttribute("noticeList", noticeList);
		
		return "memberNotice";
	}
	
	
	
	// 멤버 파트 공지게시판 디테일
	@RequestMapping(value = "/notice/detail", method = RequestMethod.GET)
	public String noticeDetail(Model model, @RequestParam(value = "selectNum") int selectNum) {
		
		NoticeVo detail = service.selectOneNotice(selectNum);
		
		model.addAttribute("detail", detail);
		
		return "memberNoticeDetail";
	}
	
	
	
	// 멤버 파트 회의실 예약 인트로 페이지
	@RequestMapping("/reservation")
	public String roomREZ(Model model) {
		
		List<ReservationVo> roomList = service.meetingRoomList();
		model.addAttribute("roomList", roomList);
		
		return "memberREZ";
	}
	
	
	
	// 멤버 파트 회의실 예약 신청에 필요한 정보 전달
	@RequestMapping(value = "/reservation/apply")
	@ResponseBody
	public Map<String, Object> roomInfo() {
		
		// 데이터 담을 객체 생성
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		Map<String, String> data = null;
		
		// 해당 브런치에 필요한 회의실 리스트 불러오기
		List<ReservationVo> roomList = service.meetingRoomList();
		
		// 반복문을 돌면서 리스트를 데이터 객체에 담음
		for( ReservationVo REZ : roomList ) {
			data = new HashMap<String, String>();
			data.put("roomNum", Integer.toString(REZ.getRoomNum()));
			dataList.add(data);
		}
		
		// 담겨진 리스트를 뷰로 전달
		Map<String, Object> roomData = new HashMap<String, Object>();
		roomData.put("roomData", dataList);
		// 예약날짜 예약자 정보도 전달해줘야 함
		
		return roomData;
	}
	
	
	
	// 나의 회의실 예약 정보 전달
	@RequestMapping(value = "/reservation/myReservationList", method = RequestMethod.GET)
	@ResponseBody
	/*
	 * 뷰에서 ajax로 받아온 멤버 넘버를 인자로 전달해줘야 함
	 * 아직 뷰에서 사용자의 정보를 어떻게 받아오는지 몰라서 처리 안됨
	 */
	public Map<String, Object> myREZList(){

		// 데이터 담을 객체 생성
		List<Map<String, String>> REZList = new ArrayList<Map<String, String>>();
		Map<String, String> data = null;
		
		// 나의 예약 정보 불러오기
		List<ReservationVo> myREZ = service.myReservationList();
		
		// 반복문 돌면서 객체에 데이터 담기
		for ( ReservationVo reservation : myREZ ) {
			data = new HashMap<String, String>();
			data.put("roomNum", Integer.toString(reservation.getRoomNum()));
			data.put("reservationDay", reservation.getReservationDay());
			data.put("useStartTime", reservation.getUseStartTime().substring(11, 13));
			data.put("originStartTime", reservation.getUseStartTime());
			data.put("useFinishTime", reservation.getUseFinishTime());
			REZList.add(data);
		}
		
		// 데이터 담아서 뷰로 전달
		Map<String, Object> myList = new HashMap<String, Object>();
		myList.put("myList", REZList);
		
		return myList;
	}
	
	
	
	// 회의실 페이지에 보여줄 회의실 예약 현황
	@RequestMapping(value = "/reservation/reservationList", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> reservationList(HttpServletRequest request) {
		
		// 뷰에서 브랜치 코드와 날짜를 받아옴
		int branchCode = Integer.parseInt(request.getParameter("branchCode"));
		String dateText = request.getParameter("dateText");
		
		// 데이터 담을 객체 생성
		List<Map<String, String>> REZList = new ArrayList<Map<String, String>>();
		Map<String, String> data = null;
		
		// 회의실 예약 현황을 불러옴
		List<ReservationVo> selectList = service.reservationList(branchCode, dateText);
		
		// 반복문을 돌면서 객체에 데이터 담음
		for ( ReservationVo reservation : selectList ) {
			data = new HashMap<String, String>();
			data.put("roomNum", Integer.toString(reservation.getRoomNum()));
			data.put("memNum", Integer.toString(reservation.getMemNum()));
			data.put("reservationDay", reservation.getReservationDay());
			data.put("startT", reservation.getUseStartTime().substring(11,13));
			data.put("finishT", reservation.getUseFinishTime().substring(11,13));
			REZList.add(data);
		}
		
		// 담겨진 데이터 뷰로 전달
		Map<String, Object> allList = new HashMap<String, Object>();
		allList.put("allList", REZList);
		
		return allList;
	} // 이 로직 다시 공부해야 할 듯
	
	
	
	// 멤버 파트 회의실 예약 전 가능여부 조회
	@RequestMapping(value = "/reservation/applySubmit", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> roomReservaionApply(ReservationVo applyContent) {
		
		// 뷰로 전달할 결과값을 담을 객체 생성
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		// 종료 시간을 위해 파라미터 변환
		int startTime = Integer.parseInt(applyContent.getUseStartTime());
		int useTime = Integer.parseInt(applyContent.getUseFinishTime());
		
		// 예약자 정보도 받아와야 함
		int roomNum = applyContent.getRoomNum();
		String useStartTime = applyContent.getUseStartTime();
		String calFinishTime = Integer.toString(startTime+useTime); // 종료 시간 계산
		String reservationDay = applyContent.getReservationDay();
		int userCount = applyContent.getUserCount();
		
		// 파라미터를 객체에 담음
		ReservationVo reservation = new ReservationVo();
		reservation.setRoomNum(roomNum);
		reservation.setUseStartTime(useStartTime);
		reservation.setUseFinishTime(calFinishTime);
		reservation.setReservationDay(reservationDay);
		reservation.setUserCount(userCount);
		
		// 신청하기 전에 해당 내역으로 예약이 있는지 여부를 조회
		int checkReservation = service.checkReservaion(roomNum, useStartTime, reservationDay);
		
		// 조회 결과에 따른 신청 로직
		if ( checkReservation > 0 ) { // 이미 예약된 내역이므로 신청안됨
			
			String resultMessage = "이미 예약된 내용입니다. 예약 현황을 확인 후 다시 신청해주세요.";
			String resultCode = "-1";
			
			result.put("resultMessage", resultMessage);
			result.put("resultCode",resultCode);
			
			return result;
			
		} else { // 조회된 내역이 없다면 신청 로직을 태움

			// 결제 전 history 테이블에 저장
			int insertReservaion = service.roomReservationTemp(reservation);
			
			// 가격 정보 조회
			int amount = service.meetingRoomRent(roomNum); 
			
			// insert 결과에 따른 로직
			if ( insertReservaion > 0 ) { // 신청이 정상적으로 수행되었을 때
				String resultMessage = "예약 신청이 완료되었습니다. 결제창으로 이동하시겠습니까?";
				String resultCode = "0";
				
				result.put("resultMessage", resultMessage);
				result.put("resultCode", resultCode);
				result.put("roomNum", roomNum);
				result.put("reservationDay", reservationDay);
				result.put("useStartTime", useStartTime);
				result.put("useFinishTime", useTime);
				result.put("userCount", userCount);
				result.put("amount", amount);
				
				return result;
				
			} else { // 통신, 환경에 따른 insert 오류
				String resultMessage = "예약 신청에 실패했습니다. 다시 시도해주세요.";
				String resultCode = "1";
				
				result.put("resultMessage", resultMessage);
				result.put("resultCode", resultCode);
				
				return result;
			}
		}
	}
	
	
	
	// 회의실 예약 취소
	@RequestMapping(value = "/reservation/cancleReservation", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> cancleReservation(Model model, HttpServletRequest request) {
		
		// 결과를 담을 객체 생성
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		// 뷰에서 파라미터로 취소하고자 하는 나의 예약 내역을 받아옴
		String cancleContent = request.getParameter("myREZ");
		
		// 받아온 파라미터 변환
		String[] cancle = cancleContent.split("/");
		int roomNum = Integer.parseInt(cancle[0]);
		String reservationDay = cancle[1];
		String useStartTime = cancle[2];
		
		// 취소하기 전에 해당 내역으로 예약이 있는지 여부를 조회
		int checkReservation = service.checkReservaion(roomNum, useStartTime, reservationDay);
		
		if ( checkReservation > 0 ) {
			// 취소 쿼리 메소드 실행
			int cancleResult = service.cancleReservation(roomNum, useStartTime, reservationDay);
			
			// 취소 쿼리 메소드의 결과에 따른 로직
			if ( cancleResult == 1 ) { // 취소가 정상적으로 실행
				String resultMessage = "예약이 정상적으로 취소되었습니다.";
				String resultCode = "1";
				
				result.put("resultMessage", resultMessage);
				result.put("resultCode", resultCode);
				
				return result;
			} else { // 취소가 정상적으로 실행되지 않았을 때
				String resultMessage = "예약이 정상적으로 취소되지 않았습니다. 다시 시도해주세요.";
				String resultCode = "0";
				
				result.put("resultMessage", resultMessage);
				result.put("resultCode", resultCode);
				
				return result;
			}
		} else {
			String resultMessage = "취소하실 회의실 예약 내역이 존재하지 않습니다. 다시 확인해주세요.";
			String resultCode = "-1";
			
			result.put("resultMessage", resultMessage);
			result.put("resultCode", resultCode);
			
			return result;
		}
		
	}
	
	
	
	// 결제 페이지
	@RequestMapping(value = "/reservation/payment", method = RequestMethod.POST)
	public String payment(Model model, ReservationVo applyContent) {
		
		int roomNum = applyContent.getRoomNum();
		String reservationDay = applyContent.getReservationDay();
		String useStartTime = applyContent.getUseStartTime();
		String useFinishTime = applyContent.getUseFinishTime();
		int amount = applyContent.getAmount();
		
		if ( useFinishTime.equals("2") ) { amount = amount * 2; }
		
		ReservationVo content = new ReservationVo();
		content.setRoomNum(roomNum);
		content.setUseStartTime(useStartTime);
		content.setUseFinishTime(useFinishTime);
		content.setReservationDay(reservationDay);
		content.setAmount(amount);
		
		model.addAttribute("content", content);
		
		return "reservationPayment";
	}
	
	
	
	// 결제 페이지에서 결제 요청
	@ResponseBody
	@RequestMapping(value = "/reservation/payment/{imp_uid}", method = RequestMethod.POST)
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session, @PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException  {

		return api.paymentByImpUid(imp_uid);
	}
	
	
	
	// 결제 성공 후 최종 예약
	@RequestMapping("/reservation/success")
	@ResponseBody
	public HashMap<String, Object> fixReservation(ReservationVo payContent) {

		// 뷰로 전달할 결과값을 담을 객체 생성
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		// 결제 요청된 파라미터 받음
		String useStartTime = payContent.getUseStartTime();
		int roomNum = payContent.getRoomNum();
		String reservationDay = payContent.getReservationDay();

		// 쿼리를 위한 파라미터 변환
		int startT = Integer.parseInt(useStartTime);
		int finishT = Integer.parseInt(payContent.getUseFinishTime());
		String useFinishTime = Integer.toString(startT+finishT);
		
		// 예약 메소드에 데이터 넣을 객체 생성 후 파라미터 받음
		ReservationVo content = new ReservationVo();
		content.setRoomNum(roomNum);
		content.setUseStartTime(useStartTime);
		content.setUseFinishTime(useFinishTime);
		content.setReservationDay(reservationDay);
		content.setMerchant_uid(payContent.getMerchant_uid());
		content.setAmount(payContent.getAmount());
		content.setUserCount(payContent.getUserCount());
		
		// 결제하기 전에 해당 내역으로 예약이 있는지 여부를 최종 조회
		int checkReservation = service.checkReservaion(roomNum, useStartTime, reservationDay);
		
		// 결제하는 도중에 다른 사람이 이미 예약/결제를 모두 마친 케이스
		// 이렇게 되면 결제도 취소해줘야 함
		if ( checkReservation > 0 ) {
			
			String resultMessage = "결제 후 예약이 정상적으로 처리되지 않았습니다. 다시 시도해주세요.";
			String resultCode = "1";
			
			result.put("resultMessage", resultMessage);
			result.put("resultCode", resultCode);
			
			return result;
			
		} else {
			
			// reservation 테이블에 insert
			int reservationResult = service.fixReservation(content);
			
			// reservation 테이블에 insert가 정상적으로 처리되었다면
			if ( reservationResult > 0 ) {
				String resultMessage = "결제 후 예약이 정상적으로 처리되었습니다. 감사합니다.";
				String resultCode = "0";
				
				result.put("resultMessage", resultMessage);
				result.put("resultCode", resultCode);
				
				return result;
			} else {
				String resultMessage = "결제 후 예약이 정상적으로 처리되지 않았습니다. 관리자에게 문의해주세요.";
				String resultCode = "-1";
				
				result.put("resultMessage", resultMessage);
				result.put("resultCode", resultCode);
				
				return result;
			}
			
		}
		
	}
	
	
	
	// 멤버 파트 내 스케쥴 관리 인트로 페이지
	@RequestMapping("/schedule")
	public String schedule() {

		return "memberSchedule";
	}
	
}