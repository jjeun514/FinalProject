package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.CommentMapper;
import com.bit.fn.model.vo.CommentVo;


@Service
public class CommentService {
	@Autowired
	CommentMapper commentMapper;
	
	public List<CommentVo> selectAll(){
		return commentMapper.selectAll();
	}
}
