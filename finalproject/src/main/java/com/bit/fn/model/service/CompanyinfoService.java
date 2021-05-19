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
	
	public int updateOccupancy(int officeNum) {
		return companyInfoMapper.updateOccupancy(officeNum);
	}
	
	public List<CompanyInfoVo> selectAllCompany(){
		return companyInfoMapper.selectAllCompany();
	}
	
	public List<CompanyInfoVo> comCodeCheck(int comCode) {
		return companyInfoMapper.comCodeCheck(comCode);
	}
	
	public List<CompanyInfoVo> comPhoneCheck(String comPhone) {
		return companyInfoMapper.comPhoneCheck(comPhone);
	}
	
	public List<CompanyInfoVo> comNameCheck(String comName) {
		return companyInfoMapper.comNameCheck(comName);
	}
	
	public int updateCompanyInfo(String ceoValue, String managerValue, String comPhoneValue, int comCode, String comName) {
		return companyInfoMapper.updateCompanyInfo(ceoValue, managerValue, comPhoneValue, comCode, comName);
	}
	
	public List<CompanyInfoVo> selectComPhone(String comPhone, int comCode) {
		return companyInfoMapper.selectComPhone(comPhone, comCode);
	}
	
	public int deleteCompanyInfo(int officeNum) {
		return companyInfoMapper.deleteCompanyInfo(officeNum);
	}
	public int selectOfficeNum(int comCode) {
		return companyInfoMapper.selectOfficeNum(comCode);
	}
	
}
