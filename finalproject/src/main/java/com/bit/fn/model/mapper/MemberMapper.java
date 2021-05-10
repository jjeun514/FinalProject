package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.BoardVo;
import com.bit.fn.model.vo.NoticeVo;
import com.bit.fn.model.vo.PaginationVo;
import com.bit.fn.model.vo.ReservationVo;

@Repository
@Mapper
public interface MemberMapper {
	
	// 멤버 페이지 게시판 리스트
	public List<BoardVo> memberBoardList();
	
	// 멤버 페이지 페이징
	public List<PaginationVo> memberBoardPaginationList(PaginationVo pagination);
	
	// 멤버 페이지 게시글 카운팅
	public int countBoardList();
	
	// 멤버 페이지 공지사항 리스트
	public List<NoticeVo> noticeList();
	
	// 멤버 페이지 게시판 내 공지사항 리스트
	public List<NoticeVo> selectNoticeList();

	// 회의실 리스트
	public List<ReservationVo> meetingRoomList();
	
	// 회의실 예약 여부 조회(멤버 코드 인자로 받아야 함)
	public int checkReservaion(int roomNum, String useStartTime, String reservationDay);
	
	// 회의실 예약 현황 리스트 조회
	public List<ReservationVo> reservationList(int branchCode, String reservationDay);
	
	// 회의실 예약 신청(reservationHistory 테이블)
	public int roomReservationTemp(ReservationVo reservaion);
	
	// 나의 예약 현황 조회
	public List<ReservationVo> myReservationList();
	
	// 결제 후 최종 예약 테이블 저장(reservation 테이블)
	public int fixReservation(ReservationVo reservaion);
	
	// 회의실 예약 취소
	public int cancleReservation(int roomNum, String useStartTime, String reservationDay);
	
}
