package com.bit.fp.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fp.model.mapper.AdminAccountMapper;
import com.bit.fp.model.vo.AdminAccountVo;

@Service
public class AdminAccountService {
	@Autowired
	AdminAccountMapper accountMapper;
	
	public List<AdminAccountVo> selectAll(){
		return accountMapper.selectAll();
	}
}
