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
	
	public List<PaginationVo> memberBoardList2(PaginationVo pagination){
		return memberMapper.memberBoardList2(pagination);
	}
	
	public int countBoardList() {
		return memberMapper.countBoardList();
	}
	
	public List<NoticeVo> noticeList(){
		return memberMapper.noticeList();
	}
	
	public List<NoticeVo> selectNoticeList(){
		return memberMapper.selectNoticeList();
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
	
	public List<ReservationVo> myReservationList() {
		return memberMapper.myReservationList();
	}
	
	public int fixReservation(ReservationVo reservation) {
		return memberMapper.fixReservation(reservation);
	}
	
	public int cancleReservation(int roomNum, String useStartTime, String reservationDay) {
		return memberMapper.cancleReservation(roomNum, useStartTime, reservationDay);
	}
}
