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
		System.out.println("[SpaceMgmtController(spaceMgmtGet())]");
	// 공간 관리
		spaceInfo=officeService.spaceInfo();
		System.out.println("[SpaceMgmtController(spaceMgmtGet())] 공간: "+spaceInfo);
		req.setAttribute("spaceInfo", spaceInfo);

	// 공간 추가
		branchNameList=branchService.selectAllBranchName();
		req.setAttribute("branchList", branchNameList);
		System.out.println("[SpaceMgmtController(addSpace())] branchList: "+branchNameList);
		
	// 공간 수정
		req.setAttribute("companyList", companyService.selectAllCompany());
		
		return "spaceMgmt";
	}

	@RequestMapping(path="/spaceDetail", method = RequestMethod.POST)
	public ResponseEntity spaceDetail(String officeName, int floorInput, HttpServletResponse resp) throws Exception {
		System.out.println("[SpaceMgmtController(spaceDetail())]");
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
	// 공간 상세 페이지
			spaceDetail=officeService.officeDetail(officeName, floorInput);
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
	public ResponseEntity officeFacilities(String officeName, int floorInput, HttpServletResponse resp) throws Exception {
		System.out.println("[SpaceMgmtController(officeFacilities())]");
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			// 공간 상세 페이지
			officeFacilities=officeFacilitiesService.officeFacilities(officeName, floorInput);
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
	
	@RequestMapping(path="/addSpace", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public @ResponseBody String addSpace(String branchInput, int floorInput, int acreagesInput, int rentInput, String officeNameInput, int maxInput, HttpServletResponse resp) {
		System.out.println("[SpaceMgmtController(addSpace())]");
		System.out.println("[SpaceMgmtController(addSpace())] branchName: "+branchInput+", floor: "+floorInput+", acreages: "+acreagesInput+", rent: "+rentInput+", officeName: "+officeNameInput+", max: "+maxInput);
		branchCodeList=branchService.selectBranchCode(branchInput);
		System.out.println("[SpaceMgmtController(addSpace())] branchCodeList: "+branchCodeList);
		branchCode=(int) branchCodeList.get(0).get("branchCode");
		System.out.println("[SpaceMgmtController(addSpace())] branchCode: "+branchCode);
		
		branchAndOfficeList=branchAndOfficeService.duplicationCheck(branchInput, floorInput, officeNameInput);
		System.out.println("[SpaceMgmtController(addSpace())] branch & office: "+branchAndOfficeList);

		if(branchAndOfficeList.isEmpty()) {
			officeService.addSpaceInfo(branchCode, floorInput, acreagesInput, rentInput, officeNameInput, maxInput);
			System.out.println("[SpaceMgmtController(addSpace())] insert완료");
			return "가능";
		} else {
			return "중복";
		}
	}
	
	@RequestMapping(path="/updateSpaceDetail", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public void updateSpace(String officeName, int floorInput, int acreagesInput, int rentInput, int maxInput, int deskInput, int chairInput, int modemInput, int fireExtinguisherInput, int airConditionerInput, int radiatorInput, int descendingLifeLineInput, int powerSocketInput, HttpServletResponse resp) {
		System.out.println("[SpaceMgmtController(updateSpace())]");
		System.out.println("[SpaceMgmtController(updateSpace())] acreagesInput: "+acreagesInput+", rentInput: "+rentInput+", maxInput: "+maxInput+", deskInput: "+deskInput+", chairInput: "+chairInput+", modemInput: "+modemInput+", fireExtinguisherInput: "+fireExtinguisherInput+", airConditionerInput: "+airConditionerInput+", radiatorInput: "+radiatorInput+", descendingLifeLineInput: "+descendingLifeLineInput+", powerSocketInput: "+powerSocketInput);
		
		// officeFacilities 업데이트
		int officeNum=officeService.selectOfficeNum(officeName, floorInput);
		System.out.println("[SpaceMgmtController(updateSpace())] officeNum: "+officeNum);
		officeFacilitiesService.updateSpaceInfo(deskInput, chairInput, modemInput, fireExtinguisherInput, airConditionerInput, radiatorInput, descendingLifeLineInput, powerSocketInput, officeNum);
		System.out.println("[SpaceMgmtController(updateSpace())] officeFacilities 업데이트 완료");
		
		// office 업데이트
		officeService.updateOffice(acreagesInput, rentInput, maxInput, officeNum);
		System.out.println("[SpaceMgmtController(updateSpace())] office 업데이트 완료");
	}
}