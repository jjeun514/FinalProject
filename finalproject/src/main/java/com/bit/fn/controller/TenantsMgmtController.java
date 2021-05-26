package com.bit.fn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bit.fn.model.service.BranchService;
import com.bit.fn.model.service.join.TenantsMgmtService;

@Controller
@ComponentScan	// [관리자페이지] 입주사관리
public class TenantsMgmtController {
	@Autowired
	TenantsMgmtService tenantsMgmtService;
	@Autowired
	BranchService branchService;
	HttpStatus status;
	
	// 목록
	@RequestMapping("/tenantsMgmt")
	public String tenantsMgmtGet(HttpServletRequest req) throws Exception {
		req.setAttribute("tenantsList", tenantsMgmtService.selectAllTenants());
		req.setAttribute("branchList", branchService.selectAllBranchName());
		return "tenantsMgmt";
	}

	// 수정 - 층 (select box)
	@RequestMapping(path="/selectFloor", method = RequestMethod.POST)
	public ResponseEntity selectFloor(String branchName, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		status=tenantsMgmtService.floorSelectBox(branchName, resp);
		return new ResponseEntity(status);
	}
	
	// 수정 - 공간 (select box)
	@RequestMapping(path="/selectOffices", method = RequestMethod.POST)
	public ResponseEntity selectOffices(String floor, String branchName, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		status=tenantsMgmtService.officeSelectBox(floor, branchName, resp);
		return new ResponseEntity(status);
	}
	
	// 수정 - 중복체크 후 수정사항 반영
	@RequestMapping(path="/editSpaceInfo", method = RequestMethod.POST)
	public ResponseEntity spaceDetail(int comCode, String branchSelected, String officeSelected, String contractDateInput, String MoveInDateInput, String MoveOutDateInput, int floor, HttpServletResponse resp) throws Exception {
		status=tenantsMgmtService.editTenantsSpace(comCode, branchSelected, officeSelected, contractDateInput, MoveInDateInput, MoveOutDateInput, floor, resp);
		return new ResponseEntity(status);
	}
	
	// 삭제
	@RequestMapping(path="/deleteOffices", method = RequestMethod.POST)
	public ResponseEntity deleteOffices(String branchInput, int floorInput, String officeNameInput, int comCode, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		status=tenantsMgmtService.delete(branchInput, floorInput, officeNameInput, comCode, resp);
		return new ResponseEntity(status);
	}
}