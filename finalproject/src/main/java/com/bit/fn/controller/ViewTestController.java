package com.bit.fn.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.fn.model.service.AdminAccountService;
import com.bit.fn.model.service.MasterAccountService;
import com.bit.fn.model.service.MemberService;
import com.bit.fn.model.service.MemberinfoService;
import com.bit.fn.model.service.ReservationService;
import com.bit.fn.model.service.join.BranchAndAdminService;
import com.bit.fn.model.service.join.MasteraccountAndCompanyInfoService;
import com.bit.fn.model.service.join.MemberInfoAndCompanyInfoService;
import com.bit.fn.model.vo.PaginationVo;
import com.bit.fn.model.vo.ReservationVo;

@Controller
public class ViewTestController {
	@Autowired
	BranchAndAdminService branchAndAdminService;
	
	@Autowired
	MasterAccountService masterAccountService;
	
	@Autowired
	MemberinfoService memberinfoService;
	
	@Autowired
	MemberInfoAndCompanyInfoService memberInfoAndCompanyInfoService;
	
	@Autowired
	MasteraccountAndCompanyInfoService masteraccountAndCompanyInfoService;
	
	@Autowired
	AdminAccountService adminAccountService;
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private ReservationService reservationService;
	
	@RequestMapping("/index")
	public String main() {
		return "index";
	}
	
	@RequestMapping("/bbs")
	public String bbs() {
		return "bbs";
	} 
	
	//마이페이지
	@RequestMapping("/mypage")
	public String myPage(Principal  principal,Model model,
						 HttpServletRequest request,
						 @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			             @RequestParam(value = "countPerPage", required = false, defaultValue = "7") int countPerPage,
			             @RequestParam(value = "pageSize", required = false, defaultValue = "7") int pageSize) {
		
		//아이디
		String id = principal.getName();
		
		//권한 여부
		int admin=principal.toString().indexOf("ROLE_ADMIN");
		int master=principal.toString().indexOf("ROLE_MASTER");
		int member=principal.toString().indexOf("ROLE_MEMBER");
		
		//값이 잘 불러오는지 프로필 불러와봄
		
		
		//여기서 중점! 권한 여부에 따라 불러오는 테이블 값을 다르게 줄 수 있다!
		if(admin != -1) {
			model.addAttribute("admin",branchAndAdminService.adminOne(id));
		}else if(master != -1) {
			masteraccountAndCompanyInfoService.masterOne(id).getMasteraccount().getId();
			model.addAttribute("master",masteraccountAndCompanyInfoService.masterOne(id));
			int comCode=masteraccountAndCompanyInfoService.masterOne(id).getMasteraccount().getComCode();
			model.addAttribute("comMemberList",memberinfoService.comMemberList(comCode));
		}else if(member != -1) {
			model.addAttribute("member",memberInfoAndCompanyInfoService.memberOne(id));
			
			int listCount = service.countMyBoardList(id);
	        PaginationVo pagination = new PaginationVo(currentPage, countPerPage, pageSize);
	        pagination.setTotalRecordCount(listCount);
	        pagination.calculation();
			// 게시판에 보여줄 게시글 불러오기
	        List<PaginationVo> myBoardList = service.memberOneBoardPaginationList(id, pagination);
	        
			// 페이징 값 보내기
			model.addAttribute("pagination", pagination);
			
			// 모델 객체에 리스트 담아서 뷰로 전달
			model.addAttribute("boardList", myBoardList);
			
			//예약 내역 리스트 전달
			int memNum = memberInfoAndCompanyInfoService.memberOne(id).getMemberInfo().getMemNum();
			List<ReservationVo> mrevList=reservationService.selectOne(memNum);
			for(ReservationVo list : mrevList){
			    list.setUseStartTime(list.getUseStartTime().substring(11,16));
			    list.setUseFinishTime(list.getUseFinishTime().substring(11,16));
			}

			model.addAttribute("myReservation",mrevList);
		}else {
			return "redirect:/index";
		}
		
		return "myPage";
	}
	
	//마이페이지 정보수정
	@PutMapping("/modifyInfo")
	public String modifyInfo(Principal  principal, @RequestParam Map<String, String> allParameters) {
		
		//아이디
		String id = principal.getName();
		
		//권한 여부
		int admin=principal.toString().indexOf("ROLE_ADMIN");
		int master=principal.toString().indexOf("ROLE_MASTER");
		int member=principal.toString().indexOf("ROLE_MEMBER");
		
		
		//여기서 중점! 권한 여부에 따라 불러오는 테이블 값을 다르게 줄 수 있다!
		if(admin != -1) {
			if(1!=adminAccountService.updateInfo(allParameters.get("adminNickName"),id)) {
			}
			
		}else if(master != -1) {
			masteraccountAndCompanyInfoService.masterOne(id).getMasteraccount().getId();
			
			String comName=allParameters.get("comName");
			String ceo=allParameters.get("ceo");
			String manager=allParameters.get("manager");
			String comPhone=allParameters.get("comPhone");
			
			masteraccountAndCompanyInfoService.updateInfo(comName, ceo, manager, comPhone, id);
		}else if(member != -1) {
			String memNickName=allParameters.get("memNickName");
			String memPhone=allParameters.get("memPhone");
			String dept=allParameters.get("dept");
			memberInfoAndCompanyInfoService.updateInfo(memNickName, memPhone, dept, id);
		}
		
		
		return "redirect:/mypage";
	}
	
	@RequestMapping("/test")
	public String sample() {
		return "test";
	}
	
	@RequestMapping("/privacy")
	public String privacy() {
		return "privacy";
	}
	
}