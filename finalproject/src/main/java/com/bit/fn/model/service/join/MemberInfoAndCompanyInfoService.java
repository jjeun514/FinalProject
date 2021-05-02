package com.bit.fn.model.service.join;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.join.MemberInfoAndCompanyInfoMapper;
import com.bit.fn.model.vo.join.MemberInfoAndCompanyInfoVo;


@Service
public class MemberInfoAndCompanyInfoService {
	@Autowired
	MemberInfoAndCompanyInfoMapper memberInfoAndCompanyInfoMapper;
	
	public MemberInfoAndCompanyInfoVo memberOne(String id){
		return memberInfoAndCompanyInfoMapper.memberOne(id);
	}
	
	public int updateInfo(String memNickName, String memPhone, String dept, String id) {
		return memberInfoAndCompanyInfoMapper.updateInfo(memNickName, memPhone, dept, id);
	}
	
}
