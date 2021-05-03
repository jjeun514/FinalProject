package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.MasterAccountMapper;
import com.bit.fn.model.vo.MasterAccountVo;


@Service
public class MasterAccountService {
	@Autowired
	MasterAccountMapper masterAccountMapper;
	
	public List<MasterAccountVo> selectAll(){
		return masterAccountMapper.selectAll();
	}
	
	public MasterAccountVo selectOne(String id) {
		return masterAccountMapper.selectOne(id);
	}
	
	public int deleteOne(String id) {
		return masterAccountMapper.deleteOne(id);
	}
}
