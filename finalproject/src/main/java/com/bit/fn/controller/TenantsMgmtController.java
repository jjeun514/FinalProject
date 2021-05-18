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
	
	List<TenantsMgmtVo> officeList;
	
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
	
	@RequestMapping(path="/selectOffices", method = RequestMethod.POST)
	public ResponseEntity selectOffices(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		System.out.println("[SpaceMgmtController(selectOffices())]");
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			officeList=tenantsMgmtService.selectOffices();
			System.out.println("[SpaceMgmtController(selectOffices())] officeList: "+officeList);
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				jobj.put("officeList", officeList);
				for(int index=0; index<officeList.size(); index++) {
					System.out.println("i: "+index);
					System.out.println("branchName: "+officeList.get(index).getBranch().getBranchName());
					System.out.println("officeName: "+officeList.get(index).getOffice().getOfficeName());
					System.out.println("rentStartDate: "+officeList.get(index).getCompanyInfo().getRentStartDate());
					System.out.println("rentFinishDate: "+officeList.get(index).getCompanyInfo().getRentFinishDate());
				}
				out = resp.getWriter();
				out.print(jobj.toString());
			} catch (IOException e) {
				System.out.println("[MasterMgmtController(branchSelected())] json 오류");
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
}