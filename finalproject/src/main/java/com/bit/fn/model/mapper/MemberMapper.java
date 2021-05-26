package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.BoardVo;
import com.bit.fn.model.vo.CommentVo;
import com.bit.fn.model.vo.NoticeVo;
import com.bit.fn.model.vo.PaginationVo;
import com.bit.fn.model.vo.ReservationVo;

@Repository
@Mapper
public interface MemberMapper {
	
	// 인트로 페이지 게시판 리스트
	public List<BoardVo> boardListForIntro();
	
	// 인트로 페이지 공지 리스트
	public List<NoticeVo> noticeListForIntro(); 
	
	// 인트로 페이지 예약 리스트
	public List<ReservationVo> reservationListForIntro(int memNum);
	
	// 인트로 페이지 예약 리스트(멤버 외)
	public List<ReservationVo> reservationListForIntroNotMember();
	
	// 멤버 페이지 게시판 리스트
	public List<BoardVo> memberBoardList();
	
	// 멤버 페이지 게시글 저장
	public int savePost(BoardVo post);
	
	// 멤버 페이지 페이징
	public List<PaginationVo> memberBoardPaginationList(PaginationVo pagination);
	
	// 멤버 페이지 게시글 카운팅
	public int countBoardList();
	
	// 멤버 페이지 나의 게시글 카운팅
	public int countMyBoardList(String id);
	
	// 멤버 페이지 게시글 디테일
	public BoardVo selectOneContent(int num);
	
	// 멤버 페이지 게시글 삭제
	public int deletePost(int num);
	
	// 멤버 페이지 게시글 수정
	public int updatePost(BoardVo modify);
	
	// 멤버 페이지 공지사항 리스트
	public List<NoticeVo> noticeList(PaginationVo pagination);
	
	// 멤버 페이지 게시판 내 공지사항 리스트
	public List<NoticeVo> selectNoticeList();
	
	// 멤버 페이지 공지사항 디테일
	public NoticeVo selectOneNotice(int num);
	
	// 멤버 페이지 공지게시글 카운팅
	public int countNoticeList();

	// 회의실 리스트
	public List<ReservationVo> meetingRoomList();
	
	// 회의실 예약 여부 조회
	public ReservationVo checkReservaion(int roomNum, String useStartTime, String reservationDay);
	
	// 회의실 오늘 전체 예약 건 조회
	public List<ReservationVo> searchAllReservation();
	
	// 회의실 예약 현황 리스트 조회
	public List<ReservationVo> reservationList(int branchCode, String reservationDay);
	
	// 회의실 예약 신청(reservationHistory 테이블)
	public int roomReservationTemp(ReservationVo reservaion);
	
	// 회의실 예약 금액 조회
	public int meetingRoomRent(int roomNum);
	
	// 나의 예약 현황 조회
	public List<ReservationVo> myReservationList(int memNum);
	
	// 결제 후 최종 예약 테이블 저장(reservation 테이블)
	public int fixReservation(ReservationVo reservaion);
	
	// 회의실 예약 취소
	public int cancleReservation(int roomNum, String useStartTime, String reservationDay);
	
	//마이페이지 내가쓴글 리스트
	public List<PaginationVo> memberOneBoardPaginationList(@Param("id") String id, @Param("pagination") PaginationVo pagination);
	
}