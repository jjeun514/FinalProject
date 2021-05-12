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
	
	public int selectOfficeNum(String branchInput, int floorInput, String officeNameInput) {
		return branchAndOfficeMapper.selectOfficeNum(branchInput, floorInput, officeNameInput);
	}
	
	public List<BranchAndOfficeVo> OccupancyCheck(String branchSelected, int floorSelected, String officeSelected) {
		return branchAndOfficeMapper.OccupancyCheck(branchSelected, floorSelected, officeSelected);
	}
	
	public List<BranchAndOfficeVo> selectFloors(String branchSelected) {
		return branchAndOfficeMapper.selectFloors(branchSelected);
	}
	
	public List<BranchAndOfficeVo> selectOffices(String branchSelected, int floorSelected) {
		return branchAndOfficeMapper.selectOffices(branchSelected, floorSelected);
	}
}