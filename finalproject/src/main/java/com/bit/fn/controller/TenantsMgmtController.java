package com.bit.fn.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bit.fn.model.service.BranchService;
import com.bit.fn.model.service.CompanyinfoService;
import com.bit.fn.model.service.join.BranchAndOfficeService;
import com.bit.fn.model.service.join.TenantsMgmtService;
import com.bit.fn.model.vo.BranchVo;
import com.bit.fn.model.vo.join.TenantsMgmtVo;

@Controller
@ComponentScan
public class TenantsMgmtController {
	@Autowired
	TenantsMgmtService tenantsMgmtService;
	List<TenantsMgmtVo> tenantsList;
	
	@Autowired
	BranchService branchService;
	
	List<TenantsMgmtVo> floorList;
	List<TenantsMgmtVo> officeList;
	List<TenantsMgmtVo> dateList;
	
	@Autowired
	BranchAndOfficeService branchAndOfficeService;
	
	@Autowired
	CompanyinfoService companyInfoService;
	
	@RequestMapping("/tenantsMgmt")
	public String tenantsMgmtGet(HttpServletRequest req) throws Exception {
	// 입주사 관리
		tenantsList=tenantsMgmtService.selectAllTenants();
		req.setAttribute("tenantsList", tenantsList);
		req.setAttribute("branchList", branchService.selectAllBranchName());
		
		return "tenantsMgmt";
	}

	@RequestMapping(path="/editSpaceInfo", method = RequestMethod.POST)
	public ResponseEntity spaceDetail(int comCode, String branchSelected, String officeSelected, String contractDateInput, String MoveInDateInput, String MoveOutDateInput, int floor, HttpServletResponse resp) throws Exception {
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			dateList=tenantsMgmtService.dateCheck(officeSelected, branchSelected, floor);
			if(dateList.isEmpty()) {
				int officeNum=companyInfoService.selectOfficeNum(comCode);
				tenantsMgmtService.setOccupancy(officeNum);
				
				int newOfficeNum=branchAndOfficeService.selectOfficeNum(branchSelected, floor, officeSelected);
				tenantsMgmtService.occupancyToOne(newOfficeNum);
				tenantsMgmtService.editSpaceInfo(newOfficeNum, contractDateInput, MoveInDateInput, MoveOutDateInput, comCode);
			} else {
				status=HttpStatus.NOT_ACCEPTABLE;
				SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
				for(int index=0; index<dateList.size(); index++) {
					String dbRentStart=dateFormat.format(dateList.get(index).getCompanyInfo().getRentStartDate());
					String dbRentEnd=dateFormat.format(dateList.get(index).getCompanyInfo().getRentFinishDate());

					if(MoveInDateInput.compareTo(dbRentStart)<0 && MoveOutDateInput.compareTo(dbRentStart)<0
							|| MoveInDateInput.compareTo(dbRentEnd)>0 && MoveOutDateInput.compareTo(dbRentEnd)>0) {
						int officeNum=companyInfoService.selectOfficeNum(comCode);
						tenantsMgmtService.setOccupancy(officeNum);
						
						int newOfficeNum=branchAndOfficeService.selectOfficeNum(branchSelected, floor, officeSelected);
						tenantsMgmtService.occupancyToOne(newOfficeNum);
						tenantsMgmtService.editSpaceInfo(newOfficeNum, contractDateInput, MoveInDateInput, MoveOutDateInput, comCode);
					} else {
						status=HttpStatus.FORBIDDEN;
					}
				}
				
				try {
					JSONObject jobj=new JSONObject();
					PrintWriter out;
					jobj.put("dateList", dateList);
					out = resp.getWriter();
					out.print(jobj.toString());
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} catch(NullPointerException e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return new ResponseEntity(status);
	}
	
	@RequestMapping(path="/selectFloor", method = RequestMethod.POST)
	public ResponseEntity selectFloor(String branchName, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			floorList=tenantsMgmtService.selectFloor(branchName);
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				jobj.put("floorList", floorList);
				out = resp.getWriter();
				out.print(jobj.toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return new ResponseEntity(status);
	}
	
	@RequestMapping(path="/selectOffices", method = RequestMethod.POST)
	public ResponseEntity selectOffices(String floor, String branchName, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			officeList=tenantsMgmtService.selectOffices(floor, branchName);
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				jobj.put("officeList", officeList);
				out = resp.getWriter();
				out.print(jobj.toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return new ResponseEntity(status);
	}
	
	@RequestMapping(path="/deleteOffices", method = RequestMethod.POST)
	public ResponseEntity deleteOffices(String branchInput, int floorInput, String officeNameInput, int comCode, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			int officeNum=branchAndOfficeService.selectOfficeNum(branchInput, floorInput, officeNameInput);
			tenantsMgmtService.deleteOffice(officeNum);
			tenantsMgmtService.deleteCompanyInfo(comCode);
			tenantsMgmtService.deleteMasterAccount(comCode);
		} catch(NullPointerException e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return new ResponseEntity(status);
	}
}