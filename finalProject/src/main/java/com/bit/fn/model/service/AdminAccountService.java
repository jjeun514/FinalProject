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
	
	public AdminAccountVo selectOne(String id) {
		return accountMapper.selectOne(id);
	}
	
	public int deleteOne(String id) {
		return accountMapper.deleteOne(id);
	}
	public int updateInfo(String nickName, String id) {
		return accountMapper.updateInfo(nickName,id);
	}
}
