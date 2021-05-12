package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.MemberMapper;
import com.bit.fn.model.vo.BoardVo;
import com.bit.fn.model.vo.NoticeVo;
import com.bit.fn.model.vo.PaginationVo;
import com.bit.fn.model.vo.ReservationVo;

@Service
public class MemberService {

	@Autowired
	MemberMapper memberMapper;
	
	public List<BoardVo> memberBoardList(){
		return memberMapper.memberBoardList();
	}
	
	public List<PaginationVo> memberBoardPaginationList(PaginationVo pagination){
		return memberMapper.memberBoardPaginationList(pagination);
	}
	
	public BoardVo selectOneContent(int num) {
		return memberMapper.selectOneContent(num);
	}
	
	public int countBoardList() {
		return memberMapper.countBoardList();
	}
	
	public int countMyBoardList(String id) {
		return memberMapper.countMyBoardList(id);
	}
	
	public List<NoticeVo> noticeList(PaginationVo pagination){
		return memberMapper.noticeList(pagination);
	}
	
	public List<NoticeVo> selectNoticeList(){
		return memberMapper.selectNoticeList();
	}
	
	public NoticeVo selectOneNotice(int num) {
		return memberMapper.selectOneNotice(num);
	}
	
	public int countNoticeList() {
		return memberMapper.countNoticeList();
	}
	
	public List<ReservationVo> meetingRoomList(){
		return memberMapper.meetingRoomList();
	}
	
	public int checkReservaion(int roomNum, String useStartTime, String reservationDay) {
		return memberMapper.checkReservaion(roomNum, useStartTime, reservationDay);
	}
	
	public List<ReservationVo> reservationList(int branchCode, String reservationDay){
		return memberMapper.reservationList(branchCode, reservationDay);
	}
	
	public int roomReservationTemp(ReservationVo reservation) {
		return memberMapper.roomReservationTemp(reservation);
	}
	
	public int meetingRoomRent(int roomNum) {
		return memberMapper.meetingRoomRent(roomNum);
	}
	
	public List<ReservationVo> myReservationList(int memNum) {
		return memberMapper.myReservationList(memNum);
	}
	
	public int fixReservation(ReservationVo reservation) {
		return memberMapper.fixReservation(reservation);
	}
	
	public int cancleReservation(int roomNum, String useStartTime, String reservationDay) {
		return memberMapper.cancleReservation(roomNum, useStartTime, reservationDay);
	}
	
	public List<PaginationVo> memberOneBoardPaginationList(String id, PaginationVo pagination){
		return memberMapper.memberOneBoardPaginationList(id, pagination);
	}
}
