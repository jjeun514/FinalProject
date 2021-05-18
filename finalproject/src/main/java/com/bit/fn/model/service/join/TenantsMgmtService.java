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
	
	public int editSpaceInfo(String officeSelected, String contractDateInput, String MoveInDateInput, String MoveOutDateInput, String branchSelected, int comCode) {
		return tenantsMgmtMapper.editSpaceInfo(officeSelected, contractDateInput, MoveInDateInput, MoveOutDateInput, branchSelected, comCode);
	}
	
	public List<TenantsMgmtVo> selectOffices(){
		return tenantsMgmtMapper.selectOffices();
	}
}