package com.bit.fn.model.service.join;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.CompanyInfoMapper;
import com.bit.fn.model.mapper.join.BranchAndOfficeMapper;
import com.bit.fn.model.mapper.join.TenantsMgmtMapper;
import com.bit.fn.model.vo.join.TenantsMgmtVo;

@Service
public class TenantsMgmtService implements TenantsMgmtMapper {
	@Autowired
	TenantsMgmtMapper tenantsMgmtMapper;
	@Autowired
	CompanyInfoMapper companyInfoMapper;
	@Autowired
	BranchAndOfficeMapper branchAndOfficeMapper;
	HttpStatus status;

	// 입주사 목록
	public List<TenantsMgmtVo> selectAllTenants(){
		return tenantsMgmtMapper.selectAllTenants();
	}
	
	// 수정 - 층 (select box)
	public HttpStatus floorSelectBox(String branchName, HttpServletResponse resp) throws Exception {
		JSONdata("floorList", tenantsMgmtMapper.selectFloor(branchName), resp);
		return status;
	}
	
	// 수정 - 공간 (select box)
	public HttpStatus officeSelectBox(String floor, String branchName, HttpServletResponse resp) throws Exception {
		JSONdata("officeList", tenantsMgmtMapper.selectOffices(floor, branchName), resp);
		return status;
	}
	
	// 수정 - 중복 체크
	public HttpStatus editTenantsSpace(int comCode, String branchSelected, String officeSelected, String contractDateInput, String MoveInDateInput, String MoveOutDateInput, int floor, HttpServletResponse resp) throws Exception {
		List<TenantsMgmtVo> dateList=tenantsMgmtMapper.dateCheck(officeSelected, branchSelected, floor);
		System.out.println(dateList);
		if(dateList.isEmpty()) {
			int officeNum=companyInfoMapper.selectOfficeNum(comCode);
			tenantsMgmtMapper.setOccupancy(officeNum);
			int newOfficeNum=branchAndOfficeMapper.selectOfficeNum(branchSelected, floor, officeSelected);
			tenantsMgmtMapper.occupancyToOne(newOfficeNum);
			tenantsMgmtMapper.editSpaceInfo(newOfficeNum, contractDateInput, MoveInDateInput, MoveOutDateInput, comCode);
			status=HttpStatus.OK;
		} else {
			status=HttpStatus.NOT_ACCEPTABLE;
		}
		return status;
	}
	
	// 삭제
	public HttpStatus delete(String branchInput, int floorInput, String officeNameInput, int comCode, HttpServletResponse resp) throws Exception {
		try {
			status=HttpStatus.OK;
			int officeNum=branchAndOfficeMapper.selectOfficeNum(branchInput, floorInput, officeNameInput);
			tenantsMgmtMapper.deleteOffice(officeNum);
			tenantsMgmtMapper.deleteCompanyInfo(comCode);
			companyInfoMapper.deleteCompanyInfo(officeNum);
			tenantsMgmtMapper.deleteMasterAccount(comCode);
		} catch(NullPointerException e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return status;
	}
	
	public HttpStatus JSONdata (String name, Object data, HttpServletResponse resp) {
		resp.setCharacterEncoding("utf-8");
		try {
			JSONObject jobj=new JSONObject();
			PrintWriter out;
			jobj.put(name, data);
			out = resp.getWriter();
			out.print(jobj.toString());
			status=HttpStatus.OK;
		} catch (Exception e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return status;
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