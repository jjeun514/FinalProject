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
	
}
