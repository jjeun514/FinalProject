package com.bit.fp.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fp.model.vo.BranchVo;

@Service
public class BranchService {
	@Autowired
	BranchService branchService;
	
	public List<BranchVo> selectAll(){
		return branchService.selectAll();
	}
}
