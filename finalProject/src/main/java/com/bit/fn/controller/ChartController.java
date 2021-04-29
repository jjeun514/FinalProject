package com.bit.fn.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

import com.bit.fn.model.service.ReservationService;
import com.bit.fn.model.vo.ReservationVo;

@Controller
@ComponentScan
public class ChartController {
	@Autowired
	ReservationService reservationService;
	
	int roomNum;
	int total;
	List<ReservationVo> room;
	List<ReservationVo> totalReservation;
	int[] count;
	
	@RequestMapping("/chart")
	public String chartGet(HttpServletRequest req) throws Exception{
		System.out.println("[ChartController(chartGet())]");
		room=reservationService.selectAllRoomNum();
		System.out.println("[ChartController(chartGet())] roomNum list: "+room);
		req.setAttribute("roomNum", room);
		
		Date date=new Date();
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		String today=sf.format(date);
		req.setAttribute("today", today);
		
		for(int i=0; i<room.size(); i++) {
			roomNum=room.get(i).getRoomNum();
			System.out.println("[ChartController(chartGet())] roomNum: "+roomNum+", today: "+today);
			
			try {
				totalReservation=reservationService.countReservation(today);
				req.setAttribute("totalReservation", totalReservation);
				System.out.println("[ChartController(chartGet())] totalReservation list: "+totalReservation);
				System.out.println("[ChartController(chartGet())] totalReservationSize: "+totalReservation.size());
				for(int j=0; j<totalReservation.size(); j++) {
					total=totalReservation.get(j).getTotalReservation();
					System.out.println("[ChartController(chartGet())] totalReservation: "+total);
				}
			}catch (Exception e) {}
		}
		return "chart";
	}
	
	@RequestMapping(path="/chart", method = RequestMethod.POST)
	public ResponseEntity chartPost(HttpServletRequest req, HttpServletResponse resp, String dateSelected) throws Exception {
		System.out.println("[ChartController(chartPost())]");
		System.out.println("[ChartController(chartPost())] dateSelected: "+dateSelected);
		
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			try {
				totalReservation=reservationService.countReservation(dateSelected);
				
				count=new int[totalReservation.size()];
				for(int j=0; j<totalReservation.size(); j++) {
					total=totalReservation.get(j).getTotalReservation();
					System.out.println("index: "+j);
					System.out.println("total: "+total);
					count[j]=total;
					System.out.println("count: "+count.toString());
				}
				System.out.println("count: "+count[0]);
				
				try {
					JSONObject jobj=new JSONObject();
					PrintWriter out;
					jobj.put("updatedTotalReservation", count);
					out = resp.getWriter();
					out.print(jobj.toString());
				} catch (IOException e) {
					System.out.println("[ChartController(chartPost())] json 오류");
					e.printStackTrace();
				}
				System.out.println("[ChartController(chartPost())] totalReservation list: "+totalReservation);
				System.out.println("totalSize: "+totalReservation.size());
			}catch (Exception e) {}
		} catch(NullPointerException e) {
			System.out.println("[ForgotIdPwController(forgotId())] bad request");
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
			System.out.println("[ForgotIdPwController(forgotId())] null");
		}
		return new ResponseEntity(status);
	}
}