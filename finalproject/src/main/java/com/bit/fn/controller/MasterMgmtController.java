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
import com.bit.fn.model.service.BranchService;
import com.bit.fn.model.service.CompanyinfoService;
import com.bit.fn.model.service.MasterAccountService;
import com.bit.fn.model.service.OfficeService;
import com.bit.fn.model.service.join.BranchAndOfficeAndCompanyInfoService;
import com.bit.fn.model.service.join.BranchAndOfficeService;
import com.bit.fn.model.service.join.MasteraccountAndCompanyInfoService;
import com.bit.fn.model.vo.join.BranchAndOfficeVo;
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
	
	@Autowired
	BranchAndOfficeService branchAndOfficeService;
	List<BranchAndOfficeVo> occupancyCheck;
	
	@Autowired
	BranchAndOfficeAndCompanyInfoService branchOfficeCompanyInfoService;
	
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
		model.addAttribute("floorList", officeService.selectAllFloors());
		
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
	public @ResponseBody String addMasterAccount(Account account, String username,
			int comCode, String comName, String ceo, String manager, String comPhone,
			String branchSelected, int floorSelected, String officeSelected,
			String contractDateInput, String MoveInDateInput, String MoveOutDateInput) {
		System.out.println("[MasterMgmtController(addMasterAccountPost())]");
		System.out.println("[MasterMgmtController(addMasterAccountPost())]\n"
				+ " account: "+account+"\n id: "+username+"\n"
				+ " comCode: "+comCode+"\n comName: "+comName+"\n ceo: "+ceo+"\n manager: "+manager+"\n comPhone: "+comPhone+"\n"
				+ " contractDateInput: "+contractDateInput+"\n MoveInDateInput: "+MoveInDateInput+"\n MoveOutDateInput: "+MoveOutDateInput);
		occupancyCheck=branchAndOfficeService.OccupancyCheck(branchSelected, floorSelected, officeSelected);
		System.out.println("[MasterMgmtController(addMasterAccountPost())] occupancyCheck: "+occupancyCheck);
		System.out.println("★★★★★"+occupancyCheck.get(0).getOffice().getOccupancy());
		System.out.println("★★★★★"+occupancyCheck.get(0).getOffice().getComName());
		if(occupancyCheck.get(0).getOffice().getOccupancy()==0 && occupancyCheck.get(0).getOffice().getComName()==null) {
			// companyInfo 추가
			officeNum=officeService.selectOfficeNum(officeSelected, floorSelected);
			System.out.println("[MasterMgmtController(addMasterAccountPost())] officeNum: "+officeNum);
			companyInfoService.addNewCompany(comCode, officeNum, comName, ceo, manager, comPhone, contractDateInput, MoveInDateInput, MoveOutDateInput, 1);
			// 마스터 계정 추가
			id=username;
			masterAccountService.insertOne(id, comCode);
			s_accountService.masterSave(account);
			return "가능";
		} else {
			System.out.println("[MasterMgmtController(addMasterAccountPost())] 입주중복");
			return "중복";
		}
		/*
		try {
			// companyInfo 추가
			officeNum=officeService.selectOfficeNum(officeSelected, floorSelected);
			System.out.println("[MasterMgmtController(addMasterAccountPost())] officeNum: "+officeNum);
			companyInfoService.addNewCompany(comCode, officeNum, comName, ceo, manager, comPhone, contractDateInput, MoveInDateInput, MoveOutDateInput, 1);
			// 마스터 계정 추가
			id=username;
			masterAccountService.insertOne(id, comCode);
			s_accountService.masterSave(account);
		}catch (Exception e) {
			e.printStackTrace();
			return "redirect:/jungbok";
		}
		return "redirect:/masterMgmt";
		*/
	}

	@RequestMapping(path="/branchSelected", method=RequestMethod.POST)
	public ResponseEntity branchSelected(String branchSelected, HttpServletResponse resp) throws Exception {
		System.out.println("[MasterMgmtController(branchSelected())]");
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
				System.out.println("list: "+branchAndOfficeService.selectFloors(branchSelected));
			} catch (IOException e) {
				System.out.println("[MasterMgmtController(branchSelected())] json 오류");
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			System.out.println("[MasterMgmtController(branchSelected())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[MasterMgmtController(branchSelected())] null");
		}
		return new ResponseEntity(status);
	}
	
	@RequestMapping(path="/floorSelected", method=RequestMethod.POST)
	public ResponseEntity floorSelected(String branchSelected, int floorSelected, HttpServletResponse resp) throws Exception {
		System.out.println("[MasterMgmtController(officeSelected())]");
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
				System.out.println("list: "+branchAndOfficeService.selectOffices(branchSelected, floorSelected));
			} catch (IOException e) {
				System.out.println("[MasterMgmtController(floorSelected())] json 오류");
				e.printStackTrace();
			}
		} catch(NullPointerException e) {
			System.out.println("[MasterMgmtController(floorSelected())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[MasterMgmtController(floorSelected())] null");
		}
		return new ResponseEntity(status);
	}
}