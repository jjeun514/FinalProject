package com.bit.fn.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.fn.model.service.BranchService;
import com.bit.fn.model.service.join.MeetingRoomAndBranchService;
import com.bit.fn.model.service.join.ReservationListService;
import com.bit.fn.model.vo.MeetingRoomMgmtVo;
import com.bit.fn.model.vo.join.ReservationListVo;

@Controller
@ComponentScan
public class MeetingRoomMgmtController {
	@Autowired
	ReservationListService reservationListService;
	
	@Autowired
	MeetingRoomAndBranchService meetingRoomAndBranchService;
	
	@Autowired
	BranchService branchService;
	
	@RequestMapping("meetingRoomMgmt")
	public String meetingRoomMgmt(Model model) {
		List<ReservationListVo> revList = reservationListService.selectAllJoin();
		for(ReservationListVo list : revList){
		    list.getReservation().setUseStartTime(list.getReservation().getUseStartTime().substring(11,16));
		    list.getReservation().setUseFinishTime(list.getReservation().getUseFinishTime().substring(11,16));
		}
		
		model.addAttribute("revList",revList);
		model.addAttribute("mrList",meetingRoomAndBranchService.selectAll());
		model.addAttribute("branchList",branchService.selectAll());
		return "meetingRoomMgmt";
	}
	
	@RequestMapping(value = "selectRevOne", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> selectRevOne(MeetingRoomMgmtVo selectRev) {
		String memNickName = selectRev.getMemNickName();
		String reservationDay = selectRev.getReservationDay();
		String useStartTime = selectRev.getUseStartTime();
		
		ReservationListVo revOne = reservationListService.selectOneJoin(memNickName, reservationDay, useStartTime);
		
		//select할 reservationList를 생성
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("memName", revOne.getMemberInfo().getMemName());
		result.put("id", revOne.getMemberInfo().getId());
		result.put("roomNum", revOne.getReservation().getRoomNum());
		result.put("reservationDay", revOne.getReservation().getReservationDay());
		result.put("useStartTime", revOne.getReservation().getUseStartTime().substring(11,16));
		result.put("useFinishTime", revOne.getReservation().getUseFinishTime().substring(11,16));
		result.put("userCount", revOne.getReservation().getUserCount());
		result.put("fee", revOne.getReservation().getAmount());
		result.put("comCode", revOne.getCompanyInfo().getComCode());
		result.put("comName", revOne.getCompanyInfo().getComName());
		result.put("ceo", revOne.getCompanyInfo().getCeo());
		result.put("manager", revOne.getCompanyInfo().getManager());
		result.put("comPhone", revOne.getCompanyInfo().getComPhone());
		result.put("dept", revOne.getMemberInfo().getDept());
		result.put("memPhone", revOne.getMemberInfo().getMemPhone());
		result.put("merchant_uid", revOne.getReservation().getMerchant_uid());
		
		return result;
	}
	
	@PutMapping("updateReservation")
	@ResponseBody
	public String updateReservation( 
									int updateRoomNum, String updateReservationDay, String updateUseStartTimValue,
									String updateUseFinishTimeValue, int updateUserCountValue, int updateFeeValue,
									String reservationDay, String memNickName, String useStartTime) {
		int result = reservationListService.updateReservation(updateRoomNum, updateReservationDay, updateUseStartTimValue, updateUseFinishTimeValue,
				updateUserCountValue, updateFeeValue, memNickName, reservationDay, useStartTime);
		if(result==1) {
			return "updated";
		}
		
		return "false";
	}

	@DeleteMapping("deleteReservation")
	@ResponseBody
	public String deleteReservation(int roomNum, String reservationDay, String useStartTime) {
		int result = reservationListService.deleteReservation(roomNum,reservationDay, useStartTime);
		if(result==1) {
			return "deleted";
		}
		
		return "false";
	}
	
	@PutMapping("updateMeetingRoom")
	@ResponseBody
	public String updateMeetingRoom(String acreagesValue, int rentValue, int maxValue, int roomNum,  String branchName) {
		int result = meetingRoomAndBranchService.updateMeetingRoom(acreagesValue, rentValue, maxValue, roomNum, branchName);
		if(result==1) {
			return "updated";
		}
		return "false";
	}
	
	@DeleteMapping("deleteMeetingRoom")
	@ResponseBody
	public String deleteMeetingRoom(int roomNum, String branchName) {
		int branchCode=(int) branchService.selectBranchCode(branchName).get(0).get("branchCode");
		int result = meetingRoomAndBranchService.deleteMeetingRoom(roomNum, branchCode);
		if(result==1) {
			return "deleted";
		}
		
		return "false";
	}
	
	@PostMapping("addMeetingRoom")
	@ResponseBody
	public String addMeetingRoom(int branchNameValue, int roomNumValue, String acreagesValue, int rentValue, int maxValue) {
		int result = meetingRoomAndBranchService.addMeetingRoom(roomNumValue, branchNameValue, acreagesValue, rentValue, maxValue);
		if(result==1) {
			return "added";
		}
		return "false";
	}
}