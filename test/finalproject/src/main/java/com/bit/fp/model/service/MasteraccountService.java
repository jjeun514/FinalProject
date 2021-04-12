package com.bit.fp.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fp.model.vo.MasterAccountVo;

@Service
public class MasteraccountService {
	@Autowired
	MasteraccountService masteraccountService;
	
	public List<MasterAccountVo> selectAll(){
		return masteraccountService.selectAll();
	}
}
