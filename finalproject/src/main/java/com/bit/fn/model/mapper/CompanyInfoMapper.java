package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.CompanyInfoVo;


@Repository
@Mapper
public interface CompanyInfoMapper {
	public List<CompanyInfoVo> selectAll();

	public int addNewCompany(int comCode, int officeNum, String comName, String ceo, String manager, String comPhone, String contractDateInput, String moveInDateInput, String moveOutDateInput, int occupancy);
	public List<CompanyInfoVo> selectAllCompany();
	public int updateCompanyInfo(String ceoValue, String managerValue, String comPhoneValue, int comCode, String comName);
	public List<CompanyInfoVo> selectComPhone(String comPhone, int comCode);
	public List<CompanyInfoVo> comCodeCheck(int comCode);
	public List<CompanyInfoVo> comNameCheck(String comName);
	public List<CompanyInfoVo> comPhoneCheck(String comPhone);
	public int deleteCompanyInfo(int officeNum);
	public int selectOfficeNum(int comCode);
	public int updateOccupancy(int officeNum);
}
