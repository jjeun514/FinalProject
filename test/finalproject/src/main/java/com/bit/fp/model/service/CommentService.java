package com.bit.fp.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fp.model.vo.CommentVo;

@Service
public class CommentService {
	@Autowired
	CommentService commentService;
	
	public List<CommentVo> selectAll(){
		return commentService.selectAll();
	}
}
