package com.bit.fn.model.service.join;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.join.BranchAndAdminMapper;
import com.bit.fn.model.vo.join.BranchAndAdminVo;


@Service
public class BranchAndAdminService {
	@Autowired
	BranchAndAdminMapper branchAndAdminMapper;
	
	public BranchAndAdminVo adminOne(String id) {
		return branchAndAdminMapper.adminOne(id);
	}
	
}
