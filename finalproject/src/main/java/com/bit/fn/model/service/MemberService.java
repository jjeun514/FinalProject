package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.MemberMapper;
import com.bit.fn.model.vo.BoardVo;
import com.bit.fn.model.vo.CommentVo;
import com.bit.fn.model.vo.NoticeVo;
import com.bit.fn.model.vo.PaginationVo;
import com.bit.fn.model.vo.ReservationVo;

@Service
public class MemberService {

	@Autowired
	MemberMapper memberMapper;
	
	public List<BoardVo> boardListForIntro(){
		return memberMapper.boardListForIntro();
	}
	
	public List<NoticeVo> noticeListForIntro(){
		return memberMapper.noticeListForIntro();
	}
	
	public List<ReservationVo> reservationListForIntro(int memNum){
		return memberMapper.reservationListForIntro(memNum);
	}
	
	public List<BoardVo> memberBoardList(){
		return memberMapper.memberBoardList();
	}
	
	public int savePost(BoardVo post) {
		return memberMapper.savePost(post);
	}
	
	public List<PaginationVo> memberBoardPaginationList(PaginationVo pagination){
		return memberMapper.memberBoardPaginationList(pagination);
	}
	
	public BoardVo selectOneContent(int num) {
		return memberMapper.selectOneContent(num);
	}
	
	public int deletePost(int num) {
		return memberMapper.deletePost(num);
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
	
	public ReservationVo checkReservaion(int roomNum, String useStartTime, String reservationDay) {
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