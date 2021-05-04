package com.bit.fn.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bit.fn.model.service.BranchService;
import com.bit.fn.model.service.OfficeService;
import com.bit.fn.model.service.OfficefacilitiesService;
import com.bit.fn.model.vo.BranchVo;
import com.bit.fn.model.vo.OfficeFacilitiesVo;
import com.bit.fn.model.vo.OfficeVo;

@Controller
@ComponentScan
public class SpaceMgmtController {
	@Autowired
	OfficeService officeService;
	List<OfficeVo> spaceInfo;
	List<OfficeVo> spaceInfoInput;
	
	@Autowired
	OfficefacilitiesService officeFacilitiesService;
	List<OfficeVo> spaceDetail;
	List<OfficeFacilitiesVo> officeFacilities;
	
	@Autowired
	BranchService branchService;
	List<BranchVo> branchNameList;
	List<Map<String, Object>> branchCodeList;
	int branchCode;
	
	
	@RequestMapping("/spaceMgmt")
	public String spaceMgmtGet(HttpServletRequest req) throws Exception {
		System.out.println("[SpaceMgmtController(spaceMgmtGet())]");
	// 공간 관리
		spaceInfo=officeService.spaceInfo();
		System.out.println("[SpaceMgmtController(spaceMgmtGet())] 공간: "+spaceInfo);
		req.setAttribute("spaceInfo", spaceInfo);

	// 공간 추가
		branchNameList=branchService.selectAllBranchName();
		req.setAttribute("branchList", branchNameList);
		System.out.println("[SpaceMgmtController(addSpace())] branchList: "+branchNameList);
		
		return "spaceMgmt";
	}

	@RequestMapping(path="/spaceDetail", method = RequestMethod.POST)
	public ResponseEntity spaceDetail(String officeName, HttpServletResponse resp) throws Exception {
		System.out.println("[SpaceMgmtController(spaceDetail())]");
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
	// 공간 상세 페이지
			spaceDetail=officeService.officeDetail(officeName);
			System.out.println("[SpaceMgmtController(spaceDetail())] 특정 공간: "+spaceDetail);
			
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				jobj.put("spaceDetail", spaceDetail);
				out = resp.getWriter();
				out.print(jobj.toString());
				System.out.println("list:"+spaceDetail);
			} catch (IOException e) {
				System.out.println("[SpaceMgmtController(spaceDetail())] json 오류");
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			System.out.println("[SpaceMgmtController(spaceDetail())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[SpaceMgmtController(spaceDetail())] null");
		}
		return new ResponseEntity(status);
	}
	
	@RequestMapping(path="/officeFacilities", method = RequestMethod.POST)
	public ResponseEntity officeFacilities(String officeName, HttpServletResponse resp) throws Exception {
		System.out.println("[SpaceMgmtController(officeFacilities())]");
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			// 공간 상세 페이지
			officeFacilities=officeFacilitiesService.officeFacilities(officeName);
			System.out.println("[SpaceMgmtController(officeFacilities())] 특정 시설: "+officeFacilities);
			
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				jobj.put("officeFacilities", officeFacilities);
				out = resp.getWriter();
				out.print(jobj.toString());
				System.out.println("list:"+officeFacilities);
			} catch (IOException e) {
				System.out.println("[SpaceMgmtController(officeFacilities())] json 오류");
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			System.out.println("[SpaceMgmtController(officeFacilities())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[SpaceMgmtController(officeFacilities())] null");
		}
		return new ResponseEntity(status);
	}
	
	@RequestMapping(path="/addSpace", method = RequestMethod.POST)
	public String addSpace(String branchInput, int floorInput, int acreagesInput, int rentInput, String officeNameInput, int maxInput) {
		System.out.println("[SpaceMgmtController(addSpace())]");
		System.out.println("[SpaceMgmtController(addSpace())] branchName: "+branchInput+", floor: "+floorInput+", acreages: "+acreagesInput+", rent: "+rentInput+", officeName: "+officeNameInput+", max: "+maxInput);
		branchCodeList=branchService.selectBranchCode(branchInput);
		System.out.println("[SpaceMgmtController(addSpace())] branchCodeList: "+branchCodeList);
		branchCode=(int) branchCodeList.get(0).get("branchCode");
		System.out.println("[SpaceMgmtController(addSpace())] branchCode: "+branchCode);
		officeService.addSpaceInfo(branchCode, floorInput, acreagesInput, rentInput, officeNameInput, maxInput);
		System.out.println("[SpaceMgmtController(addSpace())] insert완료");
		
		return "redirect:/spaceMgmt";
	}
}