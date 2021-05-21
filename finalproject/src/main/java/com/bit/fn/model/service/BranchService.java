package com.bit.fn.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.BranchMapper;
import com.bit.fn.model.vo.BranchVo;


@Service
public class BranchService implements BranchMapper {
	@Autowired
	BranchMapper branchMapper;
	
	public List<BranchVo> selectAll(){
		return branchMapper.selectAll();
	}
	
	@Override
	public List<BranchVo> selectAllBranchName(){
		return branchMapper.selectAllBranchName();
	}
	
	public List<Map<String, Object>> selectBranchCode(String BranchName){
		return branchMapper.selectBranchCode(BranchName);
	}
}