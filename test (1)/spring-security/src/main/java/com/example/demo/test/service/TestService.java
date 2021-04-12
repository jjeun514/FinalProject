package com.example.demo.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.test.mapper.TestMapper;
import com.example.demo.test.vo.TestVo;

@Service
public class TestService {
	@Autowired
	public TestMapper mapper;
	
	public List<TestVo> selectTest(){
		return mapper.selectAll();
	}
}
