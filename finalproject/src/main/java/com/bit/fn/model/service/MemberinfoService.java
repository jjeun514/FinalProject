package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.MemberInfoMapper;
import com.bit.fn.model.vo.MemberInfoVo;


@Service
public class MemberinfoService {
	@Autowired
	MemberInfoMapper memberInfoMapper;
	
	public List<MemberInfoVo> selectAll(){
		return memberInfoMapper.selectAll();
	}
	public MemberInfoVo selectOne(String id) {
		return memberInfoMapper.selectOne(id);
	}
	public int insertOne(String memName, String memNickName, String id,int comCode,String dept, String memPhone ) {
		return memberInfoMapper.insertOne(memName, memNickName, id, comCode, dept, memPhone);
	}
}
