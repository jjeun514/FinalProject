package com.bit.fn.model.mapper.join;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.TenantsMgmtVo;


@Repository
@Mapper
public interface TenantsMgmtMapper {
	public List<TenantsMgmtVo> selectAllTenants();

	public int editSpaceInfo(String officeSelected, String contractDateInput, String MoveInDateInput, String MoveOutDateInput,
			String branchSelected, String comCode);
	public List<TenantsMgmtVo> selectFloor(String branchName);
	public List<TenantsMgmtVo> selectOffices(String floor, String branchName);
	public List<TenantsMgmtVo> dateCheck(String officeName, String branchName, String floor);
	public int deleteOffice(int officeNum);
	public int deleteCompanyInfo(int comCode);
	public int deleteMasterAccount(int comCode);
}