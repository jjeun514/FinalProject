package com.bit.fn.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.fn.model.mapper.AccountMapper;
import com.bit.fn.model.service.BranchService;
import com.bit.fn.model.service.CompanyinfoService;
import com.bit.fn.model.service.MasterAccountService;
import com.bit.fn.model.service.OfficeService;
import com.bit.fn.model.service.join.MasteraccountAndCompanyInfoService;
import com.bit.fn.model.vo.join.MasteraccountAndCompanyInfoVo;
import com.bit.fn.security.model.Account;
import com.bit.fn.security.service.AccountService;

@Controller
@ComponentScan
public class MasterMgmtController {
	@Autowired
	MasteraccountAndCompanyInfoService masterAndComService;
	List<MasteraccountAndCompanyInfoVo> mastAccountList;
	private String id;
	
	@Autowired
	CompanyinfoService companyInfoService;
	
	@Autowired
	OfficeService officeService;
	private int officeNum;
	
	@Autowired
	BranchService branchService;
	@Autowired
	MasterAccountService masterAccountService;
	@Autowired
	AccountMapper accountMapper;
	@Autowired
	AccountService s_accountService;
	
	@RequestMapping("/masterMgmt")
	public String masterMgmtGet(HttpServletRequest req) throws Exception {
		System.out.println("[MasterMgmtController(masterMgmtGet())]");
	// 마스터 계정 리스트
		req.setAttribute("masterList",masterAndComService.selectAllMasterAccounts());
		
		return "masterMgmt";
	}
	
	// 마스터 계정 추가(get)
	@RequestMapping("/addMasterAccount")
	public String addMasterAccountGet(Model model) {
		System.out.println("[MasterMgmtController(addMasterAccountGet())]");
		model.addAttribute("officeInfoList", officeService.selectAll());
		model.addAttribute("branchList", branchService.selectAllBranchName());
		return "addMasterAccount";
	}
	
	// 마스터 계정 아이디 중복 체크
	@RequestMapping(path="/masterIdCheck", method=RequestMethod.POST)
	@ResponseBody
	public String masterIdCheck(@RequestBody String username) {
		System.out.println("[MasterMgmtController(masterIdCheck())]");
		System.out.println("[MasterMgmtController(masterIdCheck())] username: "+username);
		String id=username.replace("%40", "@").split("username=")[1];
		System.out.println("[MasterMgmtController(masterIdCheck())] id: "+id);
		int count=accountMapper.idCount(id);
		System.out.println("[MasterMgmtController(masterIdCheck())] count: "+count);
		   
		if(count != 0) {
			System.out.println("[MasterMgmtController(masterIdCheck())] 아이디 중복");
			 id="notallowed";
			 System.out.println("[MasterMgmtController(masterIdCheck())] id: "+id);
		}else {
			System.out.println("[MasterMgmtController(masterIdCheck())] 아이디 사용 가능");
			System.out.println("[MasterMgmtController(masterIdCheck())] id: "+id);
		}
		return id;
	}
	
	// 마스터 계정 추가(post)
	@PostMapping("/addMasterAccount")
	public String addMasterAccount(Account account, String username,
			int comCode, String comName, String ceo, String manager, String comPhone,
			String branchSelected, String officeSelected,
			String contractDateInput, String MoveInDateInput, String MoveOutDateInput) {
		System.out.println("[MasterMgmtController(addMasterAccountPost())]");
		System.out.println("[MasterMgmtController(addMasterAccountPost())]\n"
				+ " account: "+account+"\n id: "+username+"\n"
				+ " comCode: "+comCode+"\n comName: "+comName+"\n ceo: "+ceo+"\n manager: "+manager+"\n comPhone: "+comPhone+"\n"
				+ " contractDateInput: "+contractDateInput+"\n MoveInDateInput: "+MoveInDateInput+"\n MoveOutDateInput: "+MoveOutDateInput);
		try {
			// companyInfo 추가
			officeNum=officeService.selectOfficeNum(officeSelected);
			System.out.println("[MasterMgmtController(addMasterAccountPost())] officeNum: "+officeNum);
			companyInfoService.addNewCompany(comCode, officeNum, comName, ceo, manager, comPhone, contractDateInput, MoveInDateInput, MoveOutDateInput);
			// 마스터 계정 추가
			id=username;
			masterAccountService.insertOne(id, comCode);
			s_accountService.masterSave(account);
		}catch (Exception e) {
			e.printStackTrace();
			return "redirect:/jungbok";
		}
		return "redirect:/masterMgmt";
	}

//	@RequestMapping(path="/spaceDetail", method = RequestMethod.POST)
//	public ResponseEntity spaceDetail(String officeName, HttpServletResponse resp) throws Exception {
//		System.out.println("[SpaceMgmtController(spaceDetail())]");
//		resp.setCharacterEncoding("utf-8");
//		HttpStatus status;
//		try {
//			status=HttpStatus.OK;
//	// 공간 상세 페이지
//			spaceDetail=officeService.officeDetail(officeName);
//			System.out.println("[SpaceMgmtController(spaceDetail())] 특정 공간: "+spaceDetail);
//			
//			try {
//				JSONObject jobj=new JSONObject();
//				PrintWriter out;
//				jobj.put("spaceDetail", spaceDetail);
//				out = resp.getWriter();
//				out.print(jobj.toString());
//				System.out.println("list:"+spaceDetail);
//			} catch (IOException e) {
//				System.out.println("[SpaceMgmtController(spaceDetail())] json 오류");
//				e.printStackTrace();
//			}
//		} catch(NullPointerException e) {
//			System.out.println("[SpaceMgmtController(spaceDetail())] bad request");
//			status=HttpStatus.BAD_REQUEST;
//			e.printStackTrace();
//			System.out.println("[SpaceMgmtController(spaceDetail())] null");
//		}
//		return new ResponseEntity(status);
//	}
	
//	@RequestMapping(path="/officeFacilities", method = RequestMethod.POST)
//	public ResponseEntity officeFacilities(String officeName, HttpServletResponse resp) throws Exception {
//		System.out.println("[SpaceMgmtController(officeFacilities())]");
//		resp.setCharacterEncoding("utf-8");
//		HttpStatus status;
//		try {
//			status=HttpStatus.OK;
//			// 공간 상세 페이지
//			officeFacilities=officeFacilitiesService.officeFacilities(officeName);
//			System.out.println("[SpaceMgmtController(officeFacilities())] 특정 시설: "+officeFacilities);
//			
//			try {
//				JSONObject jobj=new JSONObject();
//				PrintWriter out;
//				jobj.put("officeFacilities", officeFacilities);
//				out = resp.getWriter();
//				out.print(jobj.toString());
//				System.out.println("list:"+officeFacilities);
//			} catch (IOException e) {
//				System.out.println("[SpaceMgmtController(officeFacilities())] json 오류");
//				e.printStackTrace();
//			}
//		} catch(NullPointerException e) {
//			System.out.println("[SpaceMgmtController(officeFacilities())] bad request");
//			status=HttpStatus.BAD_REQUEST;
//			e.printStackTrace();
//			System.out.println("[SpaceMgmtController(officeFacilities())] null");
//		}
//		return new ResponseEntity(status);
//	}
	
//	@RequestMapping(path="/addSpace", method = RequestMethod.POST)
//	public String addSpace(String branchInput, int floorInput, int acreagesInput, int rentInput, String officeNameInput, int maxInput) {
//		System.out.println("[SpaceMgmtController(addSpace())]");
//		System.out.println("[SpaceMgmtController(addSpace())] branchName: "+branchInput+", floor: "+floorInput+", acreages: "+acreagesInput+", rent: "+rentInput+", officeName: "+officeNameInput+", max: "+maxInput);
//		branchCodeList=branchService.selectBranchCode(branchInput);
//		System.out.println("[SpaceMgmtController(addSpace())] branchCodeList: "+branchCodeList);
//		branchCode=(int) branchCodeList.get(0).get("branchCode");
//		System.out.println("[SpaceMgmtController(addSpace())] branchCode: "+branchCode);
//		officeService.addSpaceInfo(branchCode, floorInput, acreagesInput, rentInput, officeNameInput, maxInput);
//		System.out.println("[SpaceMgmtController(addSpace())] insert완료");
//		
//		return "redirect:/spaceMgmt";
//	}
}