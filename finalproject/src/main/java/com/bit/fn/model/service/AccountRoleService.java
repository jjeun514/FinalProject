package com.bit.fn.model.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.AccountRoleMapper;


@Service
public class AccountRoleService {
	@Autowired
	AccountRoleMapper accountRoleMapper;
	
	public int deleteOne(int account_num) {
		return accountRoleMapper.deleteOne(account_num);
	}
}
