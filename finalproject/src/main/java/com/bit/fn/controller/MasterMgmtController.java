package com.bit.fn.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.fn.model.mapper.AccountMapper;
import com.bit.fn.model.service.AccountRoleService;
import com.bit.fn.model.service.BranchService;
import com.bit.fn.model.service.CompanyinfoService;
import com.bit.fn.model.service.MasterAccountService;
import com.bit.fn.model.service.OfficeService;
import com.bit.fn.model.service.join.BranchAndOfficeAndCompanyInfoService;
import com.bit.fn.model.service.join.BranchAndOfficeService;
import com.bit.fn.model.service.join.MasteraccountAndCompanyInfoService;
import com.bit.fn.model.vo.OfficeVo;
import com.bit.fn.model.vo.join.BranchAndOfficeVo;
import com.bit.fn.model.vo.join.MasteraccountAndCompanyInfoVo;
import com.bit.fn.security.model.Account;
import com.bit.fn.security.service.AccountService;

@Controller
@ComponentScan	// [관리자페이지] 마스터계정관리
public class MasterMgmtController {
	@Autowired
	MasteraccountAndCompanyInfoService masterAndComService;
	List<MasteraccountAndCompanyInfoVo> mastAccountList;
	private String id;
	
	@Autowired
	CompanyinfoService companyInfoService;
	int comPhoneCheck;
	
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
	
	@Autowired
	BranchAndOfficeService branchAndOfficeService;
	List<BranchAndOfficeVo> occupancyCheck;
	
	@Autowired
	BranchAndOfficeAndCompanyInfoService branchOfficeCompanyInfoService;
	
	@Autowired
	AccountRoleService accountRoleService;
	
	@RequestMapping("/masterMgmt")
	public String masterMgmtGet(HttpServletRequest req) throws Exception {
	// 마스터 계정 리스트
		req.setAttribute("masterList",masterAndComService.selectAllMasterAccounts());
		return "masterMgmt";
	}
	
	// 마스터 계정 추가(get)
	@RequestMapping("/addMasterAccount")
	public String addMasterAccountGet(Model model) {
		model.addAttribute("officeInfoList", officeService.selectAll());
		model.addAttribute("branchList", branchService.selectAllBranchName());
		model.addAttribute("floorList", officeService.selectAllFloors());
		return "addMasterAccount";
	}
	
	// 마스터 계정 아이디 중복 체크
	@RequestMapping(path="/masterIdCheck", method=RequestMethod.POST)
	@ResponseBody
	public String masterIdCheck(@RequestBody String username) {
		String id=username.replace("%40", "@").split("username=")[1];
		int count=accountMapper.idCount(id);
		   
		if(count != 0) {
			 id="notallowed";
		}
		return id;
	}
	
	// 마스터 계정 추가(post)
	@PostMapping("/addMasterAccount")
	public @ResponseBody String addMasterAccount(Account account, String username,
			int comCode, String comName, String ceo, String manager, String comPhone,
			String branchSelected, int floorSelected, String officeSelected,
			String contractDateInput, String MoveInDateInput, String MoveOutDateInput) {
		occupancyCheck=branchAndOfficeService.OccupancyCheck(branchSelected, floorSelected, officeSelected);
		
		// 회사코드 & 회사명 중복 체크
		if(companyInfoService.comCodeCheck(comCode).isEmpty()) {
			if(companyInfoService.comNameCheck(comName).isEmpty()) {
				if(companyInfoService.comPhoneCheck(comPhone).isEmpty()) {
					if(occupancyCheck.get(0).getOffice().getOccupancy()==0 && occupancyCheck.get(0).getOffice().getComName()==null) {
						// companyInfo 추가
						List<OfficeVo> Num=officeService.selectOfficeNum(officeSelected, floorSelected, branchSelected);
						officeNum=Num.get(0).getOfficeNum();
						companyInfoService.addNewCompany(comCode, officeNum, comName, ceo, manager, comPhone, contractDateInput, MoveInDateInput, MoveOutDateInput, 1);
						companyInfoService.updateOccupancy(officeNum);						
						// 마스터 계정 추가
						id=username;
						masterAccountService.insertOne(id, comCode);
						s_accountService.masterSave(account);
						return "가능";
					} else {
						return "중복";
					}
				} else {
					return "회사전화중복";
				}
			} else {
				return "회사명중복";
			}
		} else {
			return "회사코드중복";
		}
	}

	@RequestMapping(path="/branchSelected", method=RequestMethod.POST)
	public ResponseEntity branchSelected(String branchSelected, HttpServletResponse resp) throws Exception {
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				// 해당 지점의 층
				jobj.put("floorsByBranch", branchAndOfficeService.selectFloors(branchSelected));
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
	
	@RequestMapping(path="/floorSelected", method=RequestMethod.POST)
	public ResponseEntity floorSelected(String branchSelected, int floorSelected, HttpServletResponse resp) throws Exception {
		resp.setCharacterEncoding("utf-8");
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			try {
				JSONObject jobj=new JSONObject();
				PrintWriter out;
				// 해당 지점의 입주공간
				jobj.put("offices", branchAndOfficeService.selectOffices(branchSelected, floorSelected));
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
	
	// 마스터계정 수정
	@RequestMapping(path="/updateCompanyInfo", method=RequestMethod.POST)
	public ResponseEntity updateCompanyInfo(String ceoValue, String managerValue, String comPhoneValue, int comCode, String comName) {
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			if(companyInfoService.selectComPhone(comPhoneValue, comCode).isEmpty()) {
				companyInfoService.updateCompanyInfo(ceoValue, managerValue, comPhoneValue, comCode, comName);
			} else {
				status=HttpStatus.NOT_ACCEPTABLE;
			}
		} catch(NullPointerException e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return new ResponseEntity(status);
	}
	
	// 마스터계정 삭제
	@RequestMapping(path="/deleteMaster", method=RequestMethod.POST)
	public ResponseEntity deleteMaster(int comCode, String id) {
		HttpStatus status;
		
		try {
			status=HttpStatus.OK;
			// 마스터 계정 삭제
			masterAccountService.deleteMaster(id);
			int num=masterAccountService.selectNum(id);
			accountRoleService.deleted(num);
			masterAccountService.enabledToZero(id);
			
			// 회사 정보 삭제
			officeNum=companyInfoService.selectOfficeNum(comCode);
			companyInfoService.deleteCompanyInfo(officeNum);
			
			// 입주공간 공실 처리
			officeService.updateOccupancy(0, officeNum);
			
		} catch(NullPointerException e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return new ResponseEntity(status);
	}
}