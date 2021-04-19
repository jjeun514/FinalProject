package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.MemberAccountMapper;
import com.bit.fn.model.vo.MemberAccountVo;


@Service
public class MemberAccountService {
	@Autowired
	MemberAccountMapper memberAccountMapper;
	
	public List<MemberAccountVo> selectAll(){
		return memberAccountMapper.selectAll();
	}
	
	public MemberAccountVo selectOne(String id){
		return memberAccountMapper.selectOne(id);
	}
}
