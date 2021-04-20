package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.MemberMapper;
import com.bit.fn.model.vo.BoardVo;
import com.bit.fn.model.vo.NoticeVo;


@Service
public class MemberService {
	@Autowired
	MemberMapper boardMapper;
	
	public List<BoardVo> memberBoardList(){
		return boardMapper.memberBoardList();
	}
	
	public List<NoticeVo> noticeList(){
		return boardMapper.noticeList();
	}
}
