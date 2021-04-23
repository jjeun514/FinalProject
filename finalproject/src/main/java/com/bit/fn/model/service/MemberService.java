package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.MemberMapper;
import com.bit.fn.model.vo.BoardVo;
import com.bit.fn.model.vo.NoticeVo;
import com.bit.fn.model.vo.ReservationVo;


@Service
public class MemberService {

	@Autowired
	MemberMapper memberMapper;
	
	public List<BoardVo> memberBoardList(){
		return memberMapper.memberBoardList();
	}
	
	public List<NoticeVo> noticeList(){
		return memberMapper.noticeList();
	}
	
	public List<ReservationVo> mettingRoomList(){
		return memberMapper.mettingRoomList();
	}
	
	public int selectReservaionList() {
		return 0;
	}
	
	public int roomReservationApply() {
		return 0;
	}
}
