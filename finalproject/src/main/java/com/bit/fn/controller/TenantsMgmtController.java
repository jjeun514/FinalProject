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
		System.out.println("[TenantsMgmtController(tenantsMgmtGet())]");
	// 입주사 관리
		tenantsList=tenantsMgmtService.selectAllTenants();
		System.out.println("[TenantsMgmtController(tenantsMgmtGet())] tenantsList: "+tenantsList);
		req.setAttribute("tenantsList", tenantsList);
		req.setAttribute("branchList", branchService.selectAllBranchName());
		
		return "tenantsMgmt";
	}

	@RequestMapping(path="/editSpaceInfo", method = RequestMethod.POST)
	public ResponseEntity spaceDetail(int comCode, String branchSelected, String officeSelected, String contractDateInput, String MoveInDateInput, String MoveOutDateInput, int floor, HttpServletResponse resp) throws Exception {
		System.out.println("[SpaceMgmtController(editSpaceInfo())]");
		System.out.println("[SpaceMgmtController(editSpaceInfo())] comCode: "+comCode+", branchSelected: "+branchSelected+", officeSelected: "+officeSelected+", contractDateInput: "+contractDateInput+", MoveInDateInput: "+MoveInDateInput+", MoveOutDateInput: "+MoveOutDateInput+", floor: "+floor);
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			dateList=tenantsMgmtService.dateCheck(officeSelected, branchSelected, floor);
			System.out.println("[SpaceMgmtController(editSpaceInfo())] dateList: "+dateList);
			if(dateList.isEmpty()) {
				System.out.println("[SpaceMgmtController(editSpaceInfo())] dateList null");
				int officeNum=companyInfoService.selectOfficeNum(comCode);
				tenantsMgmtService.setOccupancy(officeNum);
				System.out.println("[SpaceMgmtController(editSpaceInfo())] 기존 공간 공실 처리 완료");
				
				int newOfficeNum=branchAndOfficeService.selectOfficeNum(branchSelected, floor, officeSelected);
				System.out.println("[SpaceMgmtController(editSpaceInfo())] 새로운 공간: "+newOfficeNum);
				tenantsMgmtService.occupancyToOne(newOfficeNum);
				System.out.println("[SpaceMgmtController(editSpaceInfo())] 새로운 공간 occupancy=1 처리 완료");
				tenantsMgmtService.editSpaceInfo(newOfficeNum, contractDateInput, MoveInDateInput, MoveOutDateInput, comCode);
				System.out.println("[SpaceMgmtController(editSpaceInfo())] 새로운 공간 입주 처리 완료");
			} else {
				status=HttpStatus.NOT_ACCEPTABLE;
				System.out.println("[SpaceMgmtController(editSpaceInfo())] dateList null 아님");
				SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
				for(int index=0; index<dateList.size(); index++) {
					System.out.println("i: "+index);
					System.out.println("["+index+"]"+"rentStartDate: "+dateList.get(index).getCompanyInfo().getRentStartDate());
					System.out.println("["+index+"]"+"rentFinishDate: "+dateList.get(index).getCompanyInfo().getRentFinishDate());
					
					String dbRentStart=dateFormat.format(dateList.get(index).getCompanyInfo().getRentStartDate());
					String dbRentEnd=dateFormat.format(dateList.get(index).getCompanyInfo().getRentFinishDate());
					System.out.println("dbRentStart= "+dbRentStart+", dbRentEnd= "+dbRentEnd);
					System.out.println("contractDateInput/dbRentStart: "+contractDateInput.compareTo(dbRentStart));
					
					if(MoveInDateInput.compareTo(dbRentStart)<0 && MoveOutDateInput.compareTo(dbRentStart)<0
							|| MoveInDateInput.compareTo(dbRentEnd)>0 && MoveOutDateInput.compareTo(dbRentEnd)>0) {
						System.out.println("[O]입주일<DB입주일 && 퇴소일<DB입주일 || 입주일>DB퇴소일 && 퇴소일>DB퇴소일");
						int officeNum=companyInfoService.selectOfficeNum(comCode);
						tenantsMgmtService.setOccupancy(officeNum);
						System.out.println("[SpaceMgmtController(editSpaceInfo())] 기존 공간 공실 처리 완료");
						
						int newOfficeNum=branchAndOfficeService.selectOfficeNum(branchSelected, floor, officeSelected);
						System.out.println("[SpaceMgmtController(editSpaceInfo())] 새로운 공간: "+newOfficeNum);
						tenantsMgmtService.occupancyToOne(newOfficeNum);
						System.out.println("[SpaceMgmtController(editSpaceInfo())] 새로운 공간 occupancy=1 처리 완료");
						tenantsMgmtService.editSpaceInfo(newOfficeNum, contractDateInput, MoveInDateInput, MoveOutDateInput, comCode);
						System.out.println("[SpaceMgmtController(editSpaceInfo())] 새로운 공간 입주 처리 완료");
					} else {
						System.out.println("입주일/퇴소일 확인 필요");
						status=HttpStatus.FORBIDDEN;
					}
					
					System.out.println("[SpaceMgmtController(editSpaceInfo())] contractDateInput: "+contractDateInput+", dbRentStart: "+dbRentStart+", dbRentEnd: "+dbRentEnd);
				}
				
				try {
					JSONObject jobj=new JSONObject();
					PrintWriter out;
					jobj.put("dateList", dateList);
					out = resp.getWriter();
					out.print(jobj.toString());
				} catch (IOException e) {
					System.out.println("[MasterMgmtController(editSpaceInfo())] json 오류");
					e.printStackTrace();
				}
			}
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
			officeList=tenantsMgmtService.selectOffices(floor, branchName);
			System.out.println("[SpaceMgmtController(selectOffices())] officeList: "+officeList);
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
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
	
	@RequestMapping(path="/deleteOffices", method = RequestMethod.POST)
	public ResponseEntity deleteOffices(String branchInput, int floorInput, String officeNameInput, int comCode, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		System.out.println("[SpaceMgmtController(deleteOffices())]");
		System.out.println("[SpaceMgmtController(deleteOffices())] branchInput: "+branchInput+", floorInput: "+floorInput+", officeNameInput: "+officeNameInput+", comCode: "+comCode);
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			int officeNum=branchAndOfficeService.selectOfficeNum(branchInput, floorInput, officeNameInput);
			tenantsMgmtService.deleteOffice(officeNum);
			tenantsMgmtService.deleteCompanyInfo(comCode);
			tenantsMgmtService.deleteMasterAccount(comCode);
		} catch(NullPointerException e) {
			System.out.println("[SpaceMgmtController(deleteOffices())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[SpaceMgmtController(deleteOffices())] null");
		}
		return new ResponseEntity(status);
	}
}