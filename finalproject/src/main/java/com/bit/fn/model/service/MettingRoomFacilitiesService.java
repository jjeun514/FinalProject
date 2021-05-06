package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.MettingRoomFacilitiesMapper;
import com.bit.fn.model.vo.MettingRoomFacilitiesVo;


@Service
public class MettingRoomFacilitiesService {
	@Autowired
	MettingRoomFacilitiesMapper mettingRoomFacilitiesMapper;
	
	public List<MettingRoomFacilitiesVo> selectAll(){
		return mettingRoomFacilitiesMapper.selectAll();
	}
}
