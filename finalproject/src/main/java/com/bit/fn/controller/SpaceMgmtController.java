package com.bit.fn.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.fn.model.service.BranchService;
import com.bit.fn.model.service.CompanyinfoService;
import com.bit.fn.model.service.OfficeService;
import com.bit.fn.model.service.OfficefacilitiesService;
import com.bit.fn.model.service.join.BranchAndOfficeService;
import com.bit.fn.model.vo.BranchVo;
import com.bit.fn.model.vo.OfficeFacilitiesVo;
import com.bit.fn.model.vo.OfficeVo;
import com.bit.fn.model.vo.join.BranchAndOfficeVo;

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
	
	@Autowired
	CompanyinfoService companyService;
	
	@Autowired
	BranchAndOfficeService branchAndOfficeService;
	List<BranchAndOfficeVo> branchAndOfficeList;
	
	
	@RequestMapping("/spaceMgmt")
	public String spaceMgmtGet(HttpServletRequest req) throws Exception {
	// 공간 관리
		spaceInfo=officeService.spaceInfo();
		req.setAttribute("spaceInfo", spaceInfo);

	// 공간 추가
		branchNameList=branchService.selectAllBranchName();
		req.setAttribute("branchList", branchNameList);
		
	// 공간 수정
		req.setAttribute("companyList", companyService.selectAllCompany());
		
		return "spaceMgmt";
	}

	@RequestMapping(path="/spaceDetail", method = RequestMethod.POST)
	public ResponseEntity spaceDetail(String officeName, int floorInput, HttpServletResponse resp) throws Exception {
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			// 공간 상세 페이지
			spaceDetail=officeService.officeDetail(officeName, floorInput);
			
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				jobj.put("spaceDetail", spaceDetail);
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
	
	@RequestMapping(path="/officeFacilities", method = RequestMethod.POST)
	public ResponseEntity officeFacilities(String officeName, int floorInput, HttpServletResponse resp) throws Exception {
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			// 공간 상세 페이지
			officeFacilities=officeFacilitiesService.officeFacilities(officeName, floorInput);
			
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				jobj.put("officeFacilities", officeFacilities);
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
	
	@RequestMapping(path="/addSpace", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public @ResponseBody String addSpace(String branchInput, int floorInput, int acreagesInput, int rentInput, String officeNameInput, int maxInput, int deskInput, int chairInput, int modemInput, int fireExtinguisherInput, int airConditionerInput, int radiatorInput, int descendingLifeLineInput, int powerSocketInput, HttpServletResponse resp) {
		branchCodeList=branchService.selectBranchCode(branchInput);
		branchCode=(int) branchCodeList.get(0).get("branchCode");
		branchAndOfficeList=branchAndOfficeService.duplicationCheck(branchInput, floorInput, officeNameInput);

		if(branchAndOfficeList.isEmpty()) {
			// 공간 추가
			officeService.addSpaceInfo(branchCode, floorInput, acreagesInput, rentInput, officeNameInput, maxInput, 0);
			// 시설 추가
			int officeNum=branchAndOfficeService.selectOfficeNum(branchInput, floorInput, officeNameInput);
			officeFacilitiesService.addFacilities(officeNum, deskInput, chairInput, modemInput, fireExtinguisherInput, airConditionerInput, radiatorInput, descendingLifeLineInput, powerSocketInput);
			return "가능";
		} else {
			return "중복";
		}
	}
	
	@RequestMapping(path="/updateSpaceDetail", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public void updateSpace(String officeName, int floorInput, String branchName, int acreagesInput, int rentInput, int maxInput, int deskInput, int chairInput, int modemInput, int fireExtinguisherInput, int airConditionerInput, int radiatorInput, int descendingLifeLineInput, int powerSocketInput, HttpServletResponse resp) {
		// officeFacilities 업데이트
		List<OfficeVo> Num=officeService.selectOfficeNum(officeName, floorInput, branchName);
		int officeNum=0;
		if(Num.size()>0) {
			officeNum=Num.get(0).getOfficeNum();
		}
		officeFacilitiesService.updateSpaceInfo(deskInput, chairInput, modemInput, fireExtinguisherInput, airConditionerInput, radiatorInput, descendingLifeLineInput, powerSocketInput, officeNum);
		
		// office 업데이트
		officeService.updateOffice(acreagesInput, rentInput, maxInput, officeNum);
	}
	
	@RequestMapping(path="/deleteSpace", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public void deleteSpace(String branchName, String officeName, int floor, HttpServletResponse resp) {
		// officeNum 추출
		List<OfficeVo> Num=officeService.officeNum(floor, branchName, officeName);
		int officeNum=Num.get(0).getOfficeNum();
		
		// officeFacilities 삭제 (delete)
		officeFacilitiesService.deleteSpace(officeNum);
		
		// companyInfo 삭제 (update) 
		companyService.deleteCompanyInfo(officeNum);
		
		// office 삭제 (update)
		officeService.deleteSpace(officeNum);
	}
}