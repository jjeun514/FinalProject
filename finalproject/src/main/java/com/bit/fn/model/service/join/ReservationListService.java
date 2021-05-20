package com.bit.fn.model.service.join;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.join.ReservationListMapper;
import com.bit.fn.model.vo.join.ReservationListVo;

@Service
public class ReservationListService {
	@Autowired
	ReservationListMapper reservationListMapper;
	
	public List<ReservationListVo> selectAllJoin(){
		return reservationListMapper.selectAllJoin();
	}
	public ReservationListVo selectOneJoin(String memNickName, String reservationDay, String useStartTime){
		return reservationListMapper.selectOneJoin(memNickName, reservationDay, useStartTime);
	}
	public int updateReservation(int roomNum, String updateReservationDay,String updateUseStartTime,
			String useFinishTime,int userCount, int fee, String memNickName,
			  					 String reservationDay,  String useStartTime) {
		return reservationListMapper.updateReservation(roomNum, updateReservationDay, updateUseStartTime,
								 useFinishTime, userCount, fee, memNickName, reservationDay, useStartTime);
	}
	
	public int deleteReservation(int roomNum,String reservationDay, String useStartTime) {
		return reservationListMapper.deleteReservation(roomNum, reservationDay, useStartTime);
	}
	
}
