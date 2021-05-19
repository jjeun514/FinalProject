package com.bit.fn.model.mapper.join;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.TenantsMgmtVo;


@Repository
@Mapper
public interface TenantsMgmtMapper {
	public List<TenantsMgmtVo> selectAllTenants();

	public int setOccupancy(int officeNum);
	public int occupancyToOne(int officeNum);
	public int editSpaceInfo(int officeNum, String contractDateInput, String MoveInDateInput, String MoveOutDateInput, int comCode);
	public List<TenantsMgmtVo> selectFloor(String branchName);
	public List<TenantsMgmtVo> selectOffices(String floor, String branchName);
	public List<TenantsMgmtVo> dateCheck(String officeName, String branchName, int floor);
	public int deleteOffice(int officeNum);
	public int deleteCompanyInfo(int comCode);
	public int deleteMasterAccount(int comCode);

}