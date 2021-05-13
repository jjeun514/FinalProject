package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.CompanyInfoMapper;
import com.bit.fn.model.vo.CompanyInfoVo;


@Service
public class CompanyinfoService {
	@Autowired
	CompanyInfoMapper companyInfoMapper;
	
	public List<CompanyInfoVo> selectAll(){
		return companyInfoMapper.selectAll();
	}
	
	public int addNewCompany(int comCode, int officeNum, String comName, String ceo, String manager, String comPhone, String contractDateInput, String moveInDateInput, String moveOutDateInput, int occupancy) {
		return companyInfoMapper.addNewCompany(comCode, officeNum, comName, ceo, manager, comPhone, contractDateInput, moveInDateInput, moveOutDateInput, occupancy);
	}
	
	public List<CompanyInfoVo> selectAllCompany(){
		return companyInfoMapper.selectAllCompany();
	}
	
	public int updateCompanyInfo(String ceoValue, String managerValue, String comPhoneValue, int comCode, String comName) {
		return companyInfoMapper.updateCompanyInfo(ceoValue, managerValue, comPhoneValue, comCode, comName);
	}
	
	public List<CompanyInfoVo> selectComPhone(String comPhone, int comCode) {
		return companyInfoMapper.selectComPhone(comPhone, comCode);
	}
}
