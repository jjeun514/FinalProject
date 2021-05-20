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
	
	public int setOccupancy(int officeNum) {
		return tenantsMgmtMapper.setOccupancy(officeNum);
	}
	
	public int occupancyToOne(int officeNum) {
		return tenantsMgmtMapper.occupancyToOne(officeNum);
	}
	
	public int editSpaceInfo(int officeNum, String contractDateInput, String MoveInDateInput, String MoveOutDateInput, int comCode) {
		return tenantsMgmtMapper.editSpaceInfo(officeNum, contractDateInput, MoveInDateInput, MoveOutDateInput, comCode);
	}
	
	public List<TenantsMgmtVo> selectFloor(String branchName){
		return tenantsMgmtMapper.selectFloor(branchName);
	}
	
	public List<TenantsMgmtVo> selectOffices(String floor, String branchName){
		return tenantsMgmtMapper.selectOffices(floor, branchName);
	}
	
	public List<TenantsMgmtVo> dateCheck(String officeName, String branchName, int floor){
		return tenantsMgmtMapper.dateCheck(officeName, branchName, floor);
	}
	
	public int deleteOffice(int officeNum) {
		return tenantsMgmtMapper.deleteOffice(officeNum);
	}
	
	public int deleteCompanyInfo(int comCode) {
		return tenantsMgmtMapper.deleteCompanyInfo(comCode);
	}
	
	public int deleteMasterAccount(int comCode) {
		return tenantsMgmtMapper.deleteMasterAccount(comCode);
	}
}