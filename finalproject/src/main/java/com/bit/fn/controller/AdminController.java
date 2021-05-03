package com.bit.fn.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.fn.model.service.MemberinfoService;
import com.bit.fn.model.service.OfficeService;
import com.bit.fn.model.service.ReservationService;
import com.bit.fn.model.vo.MemberInfoVo;
import com.bit.fn.model.vo.OfficeVo;
import com.bit.fn.model.vo.ReservationVo;

@Controller
@ComponentScan
public class AdminController {
	@Autowired
	ReservationService reservationService;
	int roomNum, total;
	List<ReservationVo> room;
	List<ReservationVo> totalReservation;
	
	@Autowired
	MemberinfoService memberInfoService;
	List<MemberInfoVo> pendingList;
	List<MemberInfoVo> memberList;

	@Autowired
	OfficeService officeService;
	List<OfficeVo> spaceInfo;
	
	@RequestMapping("/adminPage")
	public String adminPageGet(HttpServletRequest req) throws Exception {
		System.out.println("[AdminController(adminPageGet())]");
	// 신청서 관리(승인 대기중)
		pendingList=memberInfoService.pending();
		System.out.println("[AdminController(adminPageGet())] 신청서: "+pendingList);
		req.setAttribute("pendingList", pendingList);
		
	// 회원 관리
		memberList=memberInfoService.approved();
		System.out.println("[AdminController(adminPageGet())] 회원: "+memberList);
		req.setAttribute("memberList", memberList);
		
	// 공간 관리
		spaceInfo=officeService.spaceInfo();
		System.out.println("[AdminController(adminPageGet())] 공간: "+spaceInfo);
		req.setAttribute("spaceInfo", spaceInfo);
		
	// 회의실 예약 현황
		room=reservationService.selectAllRoomNum();
		System.out.println("[AdminController(adminPageGet())] roomNum list: "+room);
		req.setAttribute("roomNum", room);
		
		Date date=new Date();
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		String today=sf.format(date);
		req.setAttribute("today", today);
		
		for(int i=0; i<room.size(); i++) {
			roomNum=room.get(i).getRoomNum();
			System.out.println("[AdminController(adminPageGet())] roomNum: "+roomNum+", today: "+today);
			
			try {
				totalReservation=reservationService.countReservation(today);
				req.setAttribute("totalReservation", totalReservation);
				System.out.println("[AdminController(adminPageGet())] totalReservation list: "+totalReservation);
				System.out.println("[AdminController(adminPageGet())] totalReservationSize: "+totalReservation.size());
				for(int j=0; j<totalReservation.size(); j++) {
					total=totalReservation.get(j).getTotalReservation();
					System.out.println("[AdminController(adminPageGet())] totalReservation: "+total);
				}
			}catch (Exception e) {}
		}
		return "adminPage";
	}
}