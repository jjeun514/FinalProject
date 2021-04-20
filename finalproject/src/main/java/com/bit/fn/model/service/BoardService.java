package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.BoardMapper;
import com.bit.fn.model.vo.BoardVo;


@Service
public class BoardService {
	@Autowired
	BoardMapper boardMapper;
	
	public List<BoardVo> memberBoardList(){
		return boardMapper.memberBoardList();
	}
}
