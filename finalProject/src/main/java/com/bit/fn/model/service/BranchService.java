package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.BranchMapper;
import com.bit.fn.model.vo.BranchVo;


@Service
public class BranchService {
	@Autowired
	BranchMapper branchMapper;
	
	public List<BranchVo> selectAll(){
		return branchMapper.selectAll();
	}
}
