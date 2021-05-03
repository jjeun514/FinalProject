package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.CompanyInfoMapper;
import com.bit.fn.model.vo.CompanyInfoVo;


@Service
public class CompanyinfoService {
	@Autowired
	CompanyInfoMapper companyInfoMapper;
	
	public List<CompanyInfoVo> selectAll(){
		return companyInfoMapper.selectAll();
	}
}
