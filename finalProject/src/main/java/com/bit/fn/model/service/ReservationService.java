package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.ReservationMapper;
import com.bit.fn.model.vo.OfficeVo;
import com.bit.fn.model.vo.ReservationVo;


@Service
public class ReservationService {
	@Autowired
	ReservationMapper reservationMapper;
	
	public List<ReservationVo> selectAll(){
		return reservationMapper.selectAll();
	}
}
