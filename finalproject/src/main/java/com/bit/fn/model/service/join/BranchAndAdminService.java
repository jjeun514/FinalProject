package com.bit.fn.model.service.join;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.join.BranchAndAdminMapper;
import com.bit.fn.model.vo.join.BranchAndAdminVo;


@Service
public class BranchAndAdminService {
	@Autowired
	BranchAndAdminMapper branchAndAdminMapper;
	
	public List<BranchAndAdminVo> selectAll(){
		return branchAndAdminMapper.selectAll();
	}
}
