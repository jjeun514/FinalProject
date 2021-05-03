package com.bit.fn.model.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.AccountMapper;
import com.bit.fn.security.model.Account;


@Service
public class UserAccountService {
	@Autowired
	AccountMapper accountMapper;
	
	public Account selectOne(String id){
		return accountMapper.selectOne(id);
	}
	public int deleteOne(String id){
		return accountMapper.deleteOne(id);
	}
	
	public int updatePw(String password, String username) {
		return accountMapper.updatePw(password, username);
	};
}
