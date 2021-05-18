package com.bit.fn.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
	
	@RequestMapping("/tenantsMgmt")
	public String tenantsMgmtGet(HttpServletRequest req) throws Exception {
		System.out.println("[TenantsMgmtController(tenantsMgmtGet())]");
	// 입주사 관리
		tenantsList=tenantsMgmtService.selectAllTenants();
		System.out.println("[TenantsMgmtController(tenantsMgmtGet())] tenantsList: "+tenantsList);
		req.setAttribute("tenantsList", tenantsList);
		req.setAttribute("branchList", branchService.selectAllBranchName());
		
		return "tenantsMgmt";
	}

	@RequestMapping(path="/editSpaceInfo", method = RequestMethod.POST)
	public ResponseEntity spaceDetail(int comCode, String branchSelected, String officeSelected, String contractDateInput, String MoveInDateInput, String MoveOutDateInput, HttpServletResponse resp) throws Exception {
		System.out.println("[SpaceMgmtController(editSpaceInfo())]");
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			tenantsMgmtService.editSpaceInfo(officeSelected, contractDateInput, MoveInDateInput, MoveOutDateInput, branchSelected, comCode);
		} catch(NullPointerException e) {
			System.out.println("[SpaceMgmtController(editSpaceInfo())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[SpaceMgmtController(editSpaceInfo())] null");
		}
		return new ResponseEntity(status);
	}
	
	@RequestMapping(path="/selectFloor", method = RequestMethod.POST)
	public ResponseEntity selectFloor(String branchName, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		System.out.println("[SpaceMgmtController(selectFloor())]");
		System.out.println("[SpaceMgmtController(selectFloor())] branchName: "+branchName);
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			floorList=tenantsMgmtService.selectFloor(branchName);
			System.out.println("[SpaceMgmtController(selectFloor())] floorList: "+floorList);
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				jobj.put("floorList", floorList);
				out = resp.getWriter();
				out.print(jobj.toString());
			} catch (IOException e) {
				System.out.println("[MasterMgmtController(selectFloor())] json 오류");
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			System.out.println("[SpaceMgmtController(selectFloor())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[SpaceMgmtController(selectFloor())] null");
		}
		return new ResponseEntity(status);
	}
	
	@RequestMapping(path="/selectOffices", method = RequestMethod.POST)
	public ResponseEntity selectOffices(String floor, String branchName, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		System.out.println("[SpaceMgmtController(selectOffices())]");
		System.out.println("[SpaceMgmtController(selectOffices())] floor: "+floor+", branchName: "+branchName);
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			//floorList=tenantsMgmtService.selectFloor(branchName);
			//System.out.println("[SpaceMgmtController(selectFloor())] floorList: "+floorList);
			officeList=tenantsMgmtService.selectOffices(floor, branchName);
			System.out.println("[SpaceMgmtController(selectOffices())] officeList: "+officeList);
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
//				jobj.put("floorList", floorList);
//				for(int index=0; index<floorList.size(); index++) {
//					System.out.println("i: "+index);
//					System.out.println("branchName: "+officeList.get(index).getBranch().getBranchName());
//					System.out.println("floorList: "+floorList.get(index).getOffice().getFloor());
//				}
				jobj.put("officeList", officeList);
				out = resp.getWriter();
				out.print(jobj.toString());
			} catch (IOException e) {
				System.out.println("[MasterMgmtController(selectOffices())] json 오류");
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			System.out.println("[SpaceMgmtController(selectOffices())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[SpaceMgmtController(selectOffices())] null");
		}
		return new ResponseEntity(status);
	}
	
	@RequestMapping(path="/dateCheck", method = RequestMethod.POST)
	public ResponseEntity dateCheck(String officeName, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		System.out.println("[SpaceMgmtController(dateCheck())]");
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			dateList=tenantsMgmtService.dateCheck(officeName);
			System.out.println("[SpaceMgmtController(dateCheck())] dateList: "+dateList);
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				jobj.put("dateList", dateList);
				for(int index=0; index<dateList.size(); index++) {
					System.out.println("i: "+index);
					System.out.println("officeNum: "+officeList.get(index).getOffice().getOfficeNum());
					System.out.println("branchName: "+officeList.get(index).getBranch().getBranchName());
					System.out.println("officeName: "+officeList.get(index).getOffice().getOfficeName());
					System.out.println("rentStartDate: "+officeList.get(index).getCompanyInfo().getRentStartDate());
					System.out.println("rentFinishDate: "+officeList.get(index).getCompanyInfo().getRentFinishDate());
				}
				out = resp.getWriter();
				out.print(jobj.toString());
			} catch (IOException e) {
				System.out.println("[MasterMgmtController(dateList())] json 오류");
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			System.out.println("[SpaceMgmtController(dateList())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[SpaceMgmtController(dateList())] null");
		}
		return new ResponseEntity(status);
	}
}