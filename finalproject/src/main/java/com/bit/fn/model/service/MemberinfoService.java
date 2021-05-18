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
	
	public int idCount(String id) {
		return memberInfoMapper.idCount(id);
	}
	
	public MemberInfoVo selectId(String name, String phone) {
		return memberInfoMapper.selectId(name, phone);
	}
	
	public MemberInfoVo checkInfo(String name, String id, String phone) {
		return memberInfoMapper.checkInfo(name, id, phone);
	}
	
	public List<MemberInfoVo> pending() {
		return memberInfoMapper.pending();
	}
	public List<MemberInfoVo> approved() {
		return memberInfoMapper.approved();
	}
	
	public int nicknameCount(String memNickName) {
		return memberInfoMapper.nicknameCount(memNickName);
	}
	
	public int insertOne(String memName, String memNickName, String id,int comCode,String dept, String memPhone ) {
		return memberInfoMapper.insertOne(memName, memNickName, id, comCode, dept, memPhone);
	}
	
	public int deleteOne(String id) {
		return memberInfoMapper.deleteOne(id);
	}
	
	public List<MemberInfoVo> comMemberList(int comCode) {
		return memberInfoMapper.comMemberList(comCode);
	}
	
	public String searchCompanyName(int memNum) {
		return memberInfoMapper.searchCompanyName(memNum);
	}
	
	public MemberInfoVo searchUserByMemNum(int memNum) {
		return memberInfoMapper.searchUserByMemNum(memNum);
	}
}
