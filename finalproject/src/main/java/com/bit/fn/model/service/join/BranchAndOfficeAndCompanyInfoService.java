package com.bit.fn.model.service.join;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.join.BranchAndOfficeAndCompanyInfoMapper;
import com.bit.fn.model.mapper.join.BranchAndOfficeMapper;
import com.bit.fn.model.vo.join.BranchAndOfficeVo;


@Service
public class BranchAndOfficeAndCompanyInfoService {
	@Autowired
	BranchAndOfficeAndCompanyInfoMapper branchAndOfficeAndCompanyInfoMapper;
	
	public List<BranchAndOfficeVo> officeCheck(String branchSelected, int floorSelected, String officeSelected) {
		return branchAndOfficeAndCompanyInfoMapper.officeCheck(branchSelected, floorSelected, officeSelected);
	}
	
	public List<BranchAndOfficeVo> AvailableOffice(String branchSelected, int floorSelected) {
		return branchAndOfficeAndCompanyInfoMapper.AvailableOffice(branchSelected, floorSelected);
	}
}