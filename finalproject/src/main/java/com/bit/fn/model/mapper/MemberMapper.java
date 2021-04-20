package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.BoardVo;
import com.bit.fn.model.vo.NoticeVo;

@Repository
@Mapper
public interface MemberMapper {
	
	// 멤버 페이지 게시판 리스트
	public List<BoardVo> memberBoardList();
	
	// 멤버 페이지 공지사항 리스트
	public List<NoticeVo> noticeList();

}
