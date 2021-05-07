package com.bit.fn.model.service.join;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.join.AccountAndMemberInfoMapper;

@Service
public class AccountAndMemberInfoService {
	@Autowired
	AccountAndMemberInfoMapper accountAndMemberInfoMapper;
	
	public int updateMemberAdmission(int enabled, int admission, String id) {
		return accountAndMemberInfoMapper.updateMemberAdmission(enabled, admission, id);
	}
	
	
}
