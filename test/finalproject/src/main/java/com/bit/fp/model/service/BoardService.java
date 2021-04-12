package com.bit.fp.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fp.model.mapper.BoardMapper;
import com.bit.fp.model.vo.BoardVo;

@Service
public class BoardService {
	@Autowired
	BoardMapper boardMapper;
	
	public List<BoardVo> selectAll(){
		return boardMapper.selectAll();
	}
}
