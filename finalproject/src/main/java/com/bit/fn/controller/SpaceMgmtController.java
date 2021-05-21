package com.bit.fn.controller;

import java.io.PrintWriter;
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
import com.bit.fn.model.vo.OfficeVo;

@Controller
@ComponentScan
public class SpaceMgmtController {
// [관리자페이지] 공간관리
	@Autowired
	OfficeService officeService;
	@Autowired
	OfficefacilitiesService officeFacilitiesService;
	@Autowired
	BranchService branchService;
	@Autowired
	CompanyinfoService companyService;
	@Autowired
	BranchAndOfficeService branchAndOfficeService;
	
	List<Map<String, Object>> branchCodeList;
	JSONObject jobj;
	PrintWriter out;
	HttpStatus status;
	
	// Get - 목록/추가/수정
	@RequestMapping("/spaceMgmt")
	public String spaceMgmtGet(HttpServletRequest req) throws Exception {
		req.setAttribute("spaceInfo", officeService.spaceInfo());
		req.setAttribute("branchList", branchService.selectAllBranchName());
		req.setAttribute("companyList", companyService.selectAllCompany());
		
		return "spaceMgmt";
	}
	
	// 상세 정보 (Modal) - Office
	@RequestMapping(path="/spaceDetail", method = RequestMethod.POST)
	public ResponseEntity spaceDetail(String officeName, int floorInput, HttpServletResponse resp) throws Exception {
		JSONdata("spaceDetail", officeService.officeDetail(officeName, floorInput), resp);
		return new ResponseEntity(status);
	}
	
	// 상세 정보 (Modal) - OfficeFacilities
	@RequestMapping(path="/officeFacilities", method = RequestMethod.POST)
	public ResponseEntity officeFacilities(String officeName, int floorInput, HttpServletResponse resp) throws Exception {
		JSONdata("officeFacilities", officeFacilitiesService.officeFacilities(officeName, floorInput), resp);
		return new ResponseEntity(status);
	}
	
	// 추가
	@RequestMapping(path="/addSpace", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public @ResponseBody String addSpace(String branchInput, int floorInput, int acreagesInput, int rentInput, String officeNameInput, int maxInput, int deskInput, int chairInput, int modemInput, int fireExtinguisherInput, int airConditionerInput, int radiatorInput, int descendingLifeLineInput, int powerSocketInput, HttpServletResponse resp) throws Exception {
		branchCodeList=branchService.selectBranchCode(branchInput);
		int branchCode=(int) branchCodeList.get(0).get("branchCode");
		
		// 중복값이 없으면 office & facilities 추가
		if(branchAndOfficeService.duplicationCheck(branchInput, floorInput, officeNameInput).isEmpty()) {
			officeService.addSpaceInfo(branchCode, floorInput, acreagesInput, rentInput, officeNameInput, maxInput, 0);
			int officeNum=branchAndOfficeService.selectOfficeNum(branchInput, floorInput, officeNameInput);
			officeFacilitiesService.addFacilities(officeNum, deskInput, chairInput, modemInput, fireExtinguisherInput, airConditionerInput, radiatorInput, descendingLifeLineInput, powerSocketInput);
			return "가능";
		} else {
			return "중복";
		}
	}
	
	// 수정
	@RequestMapping(path="/updateSpaceDetail", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public void updateSpace(String officeName, int floorInput, String branchName, int acreagesInput, int rentInput, int maxInput, int deskInput, int chairInput, int modemInput, int fireExtinguisherInput, int airConditionerInput, int radiatorInput, int descendingLifeLineInput, int powerSocketInput, HttpServletResponse resp) throws Exception {
		List<OfficeVo> Num=officeService.selectOfficeNum(officeName, floorInput, branchName);
		int officeNum=0;
		if(Num.size()>0) {
			officeNum=Num.get(0).getOfficeNum();
		}
		officeFacilitiesService.updateSpaceInfo(deskInput, chairInput, modemInput, fireExtinguisherInput, airConditionerInput, radiatorInput, descendingLifeLineInput, powerSocketInput, officeNum);
		officeService.updateOffice(acreagesInput, rentInput, maxInput, officeNum);
	}
	
	// 삭제 (officeFacilities(delete), companyInfo(update), office(update))
	@RequestMapping(path="/deleteSpace", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public void deleteSpace(String branchName, String officeName, int floor, HttpServletResponse resp) throws Exception {
		List<OfficeVo> Num=officeService.officeNum(floor, branchName, officeName);
		int officeNum=Num.get(0).getOfficeNum();
		officeFacilitiesService.deleteSpace(officeNum);
		companyService.deleteCompanyInfo(officeNum);
		officeService.deleteSpace(officeNum);
	}
	
	private HttpStatus JSONdata (String name, Object data, HttpServletResponse resp) throws Exception {
		resp.setCharacterEncoding("utf-8");
		try {
			jobj=new JSONObject();
			jobj.put(name, data);
			out=resp.getWriter();
			out.print(jobj.toString());
			status=HttpStatus.OK;
		} catch (Exception e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return status;
	}
}