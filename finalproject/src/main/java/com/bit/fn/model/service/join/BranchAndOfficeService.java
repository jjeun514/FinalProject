package com.bit.fn.model.service.join;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.join.BranchAndOfficeMapper;
import com.bit.fn.model.vo.join.BranchAndOfficeVo;


@Service
public class BranchAndOfficeService {
	@Autowired
	BranchAndOfficeMapper branchAndOfficeMapper;
	
	public List<BranchAndOfficeVo> duplicationCheck(String branchInput, int floorInput, String officeNameInput) {
		return branchAndOfficeMapper.duplicationCheck(branchInput, floorInput, officeNameInput);
	}
	
}