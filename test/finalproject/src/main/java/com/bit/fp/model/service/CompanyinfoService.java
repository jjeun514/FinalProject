package com.bit.fp.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fp.model.vo.CompanyInfoVo;

@Service
public class CompanyinfoService {
	@Autowired
	CompanyinfoService companyinfoService;
	
	public List<CompanyInfoVo> selectAll(){
		return companyinfoService.selectAll();
	}
}
