package com.bit.fn.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.fn.model.service.ReservationService;
import com.bit.fn.model.vo.ReservationVo;

@Controller
@ComponentScan
public class AdminController {
	@Autowired
	ReservationService reservationService;
	int roomNum, total;
	List<ReservationVo> room;
	List<ReservationVo> totalReservation;
	
	@RequestMapping("/adminPage")
	public String adminPageGet(HttpServletRequest req) throws Exception {
		System.out.println("[AdminController(adminPageGet()]");
		room=reservationService.selectAllRoomNum();
		System.out.println("[AdminController(adminPageGet()] roomNum list: "+room);
		req.setAttribute("roomNum", room);
		
		Date date=new Date();
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		String today=sf.format(date);
		req.setAttribute("today", today);
		
		for(int i=0; i<room.size(); i++) {
			roomNum=room.get(i).getRoomNum();
			System.out.println("[AdminController(adminPageGet()] roomNum: "+roomNum+", today: "+today);
			
			try {
				totalReservation=reservationService.countReservation(today);
				req.setAttribute("totalReservation", totalReservation);
				System.out.println("[AdminController(adminPageGet()] totalReservation list: "+totalReservation);
				System.out.println("[AdminController(adminPageGet()] totalReservationSize: "+totalReservation.size());
				for(int j=0; j<totalReservation.size(); j++) {
					total=totalReservation.get(j).getTotalReservation();
					System.out.println("[AdminController(adminPageGet()] totalReservation: "+total);
				}
			}catch (Exception e) {}
		}
		return "adminPage";
	}
}