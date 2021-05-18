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
			String branchSelected, int comCode);
	
	public List<TenantsMgmtVo> selectOffices();
}