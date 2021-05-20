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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	
	@RequestMapping(path="/chart", method = RequestMethod.POST)
	public ResponseEntity chartPost(HttpServletRequest req, HttpServletResponse resp, String dateSelected) throws Exception {
		HttpStatus status;
		try {
			status=HttpStatus.OK;
			try {
				totalReservation=reservationService.countReservation(dateSelected);
				
				count=new int[totalReservation.size()];
				for(int j=0; j<totalReservation.size(); j++) {
					total=totalReservation.get(j).getTotalReservation();
					count[j]=total;
				}
				
				try {
					JSONObject jobj=new JSONObject();
					PrintWriter out;
					jobj.put("updatedTotalReservation", count);
					out = resp.getWriter();
					out.print(jobj.toString());
				} catch (IOException e) {
					e.printStackTrace();
				}
			}catch (Exception e) {}
		} catch(NullPointerException e) {
			status=HttpStatus.BAD_REQUEST;
			e.printStackTrace();
		}
		return new ResponseEntity(status);
	}
}