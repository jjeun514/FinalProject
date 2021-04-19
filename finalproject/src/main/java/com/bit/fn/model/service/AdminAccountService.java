package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.AdminAccountMapper;
import com.bit.fn.model.vo.AdminAccountVo;


@Service
public class AdminAccountService {
	@Autowired
	AdminAccountMapper accountMapper;
	
	public List<AdminAccountVo> selectAll(){
		return accountMapper.selectAll();
	}
}