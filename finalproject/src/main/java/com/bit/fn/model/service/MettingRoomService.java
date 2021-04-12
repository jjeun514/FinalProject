package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.MettingRoomMapper;
import com.bit.fn.model.vo.MettingRoomVo;


@Service
public class MettingRoomService {
	@Autowired
	MettingRoomMapper mettingRoomMapper;
	
	public List<MettingRoomVo> selectAll(){
		return mettingRoomMapper.selectAll();
	}
}
