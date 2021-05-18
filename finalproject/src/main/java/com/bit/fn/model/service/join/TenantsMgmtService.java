package com.bit.fn.model.service.join;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.join.TenantsMgmtMapper;
import com.bit.fn.model.vo.join.TenantsMgmtVo;


@Service
public class TenantsMgmtService {
	@Autowired
	TenantsMgmtMapper tenantsMgmtMapper;
	
	public List<TenantsMgmtVo> selectAllTenants(){
		return tenantsMgmtMapper.selectAllTenants();
	}
	
	public int editSpaceInfo(String officeSelected, String contractDateInput, String MoveInDateInput, String MoveOutDateInput, String branchSelected, String comCode) {
		return tenantsMgmtMapper.editSpaceInfo(officeSelected, contractDateInput, MoveInDateInput, MoveOutDateInput, branchSelected, comCode);
	}
	
	public List<TenantsMgmtVo> selectFloor(String branchName){
		return tenantsMgmtMapper.selectFloor(branchName);
	}
	
	public List<TenantsMgmtVo> selectOffices(String floor, String branchName){
		return tenantsMgmtMapper.selectOffices(floor, branchName);
	}
	
	public List<TenantsMgmtVo> dateCheck(String officeName, String branchName, String floor){
		return tenantsMgmtMapper.dateCheck(officeName, branchName, floor);
	}
}