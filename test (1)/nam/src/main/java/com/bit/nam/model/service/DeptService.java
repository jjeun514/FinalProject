package com.bit.nam.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.nam.model.mapper.DeptMapper;
import com.bit.nam.model.vo.DeptVo;

@Service
public class DeptService {
	@Autowired
	DeptMapper deptMapper;
	
	public List<DeptVo> selectAll(){
		return deptMapper.selectAll();
	}
}
