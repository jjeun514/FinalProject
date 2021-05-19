package com.bit.fn.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.fn.model.service.ReservationService;
import com.bit.fn.model.service.join.ReservationListService;
import com.bit.fn.model.vo.ReservationVo;
import com.bit.fn.model.vo.join.ReservationListVo;

@Controller
@ComponentScan
public class MeetingRoomMgmtController {
	@Autowired
	ReservationListService reservationListService;
	
	@RequestMapping("meetingRoomMgmt")
	public String meetingRoomMgmt(Model model) {
		//System.out.println(reservationListService.selectAllJoin());
		List<ReservationListVo> revList = reservationListService.selectAllJoin();
		for(ReservationListVo list : revList){
		    list.getReservation().setUseStartTime(list.getReservation().getUseStartTime().substring(11,16));
		    list.getReservation().setUseFinishTime(list.getReservation().getUseFinishTime().substring(11,16));
		}
		
		model.addAttribute("revList",revList);
		return "meetingRoomMgmt";
	}
}
