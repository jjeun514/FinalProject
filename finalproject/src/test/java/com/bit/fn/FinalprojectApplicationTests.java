package com.bit.fn;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.bit.fn.model.mapper.MasterAccountMapper;
import com.bit.fn.model.service.AdminAccountService;
import com.bit.fn.model.service.BoardService;
import com.bit.fn.model.service.BranchService;
import com.bit.fn.model.service.CommentService;
import com.bit.fn.model.service.CompanyinfoService;
import com.bit.fn.model.service.MemberAccountService;
import com.bit.fn.model.service.MettingRoomFacilitiesService;
import com.bit.fn.model.service.MettingRoomService;
import com.bit.fn.model.service.OfficefacilitiesService;
import com.bit.fn.model.service.OfiiceService;
import com.bit.fn.model.service.ReservationService;
import com.bit.fn.model.service.join.BranchAndAdminService;

@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class FinalprojectApplicationTests {
	
	@Autowired
	AdminAccountService adminAccountService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	BranchService branchService;
	
	@Autowired
	CommentService commentService;
	
	@Autowired
	CompanyinfoService companyinfoService;
	
	@Autowired
	MasterAccountMapper masterAccountMapper;
	
	@Autowired
	MemberAccountService memberAccountService;
	
	@Autowired
	MettingRoomFacilitiesService mettingRoomFacilitiesService;
	
	@Autowired
	MettingRoomService mettingRoomService;
	
	@Autowired
	OfficefacilitiesService officefacilitiesService;
	
	@Autowired
	OfiiceService ofiiceService; 
	
	@Autowired
	ReservationService reservationService;
	
	@Autowired
	BranchAndAdminService branchAndAdminService;
	
	@Order(1)
	@Test
	void contextLoads() {
		assertNotNull(adminAccountService);
		assertNotNull(boardService);
		assertNotNull(branchService);
		assertNotNull(commentService);
		assertNotNull(companyinfoService);
		assertNotNull(masterAccountMapper);
		assertNotNull(memberAccountService);
		assertNotNull(mettingRoomFacilitiesService);
		assertNotNull(mettingRoomService);
		assertNotNull(officefacilitiesService);
		assertNotNull(ofiiceService);
		assertNotNull(reservationService);
		assertNotNull(branchAndAdminService);
	}
	
	@Order(2)
	@Test
	void selectAll() {
		assertNotNull(adminAccountService.selectAll());
		assertNotNull(boardService.selectAll());
		assertNotNull(branchService.selectAll());
		assertNotNull(commentService.selectAll());
		assertNotNull(companyinfoService.selectAll());
		assertNotNull(masterAccountMapper.selectAll());
		assertNotNull(memberAccountService.selectAll());
		assertNotNull(mettingRoomFacilitiesService.selectAll());
		assertNotNull(mettingRoomService.selectAll());
		assertNotNull(officefacilitiesService.selectAll());
		assertNotNull(ofiiceService.selectAll());
		assertNotNull(reservationService.selectAll());
		assertNotNull(branchAndAdminService.selectAll());
		
		System.out.println(reservationService.selectAll());
		System.out.println(branchAndAdminService.selectAll());
	}

}
