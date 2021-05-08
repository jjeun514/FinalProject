package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.OfficeMapper;
import com.bit.fn.model.vo.OfficeVo;


@Service
public class OfficeService {
	@Autowired
	OfficeMapper officeMapper;
	
	public List<OfficeVo> selectAll(){
		return officeMapper.selectAll();
	}
	
	public List<OfficeVo> selectPriceInfo(){
		return officeMapper.selectPriceInfo();
	}
	
	public List<OfficeVo> spaceInfo(){
		return officeMapper.spaceInfo();
	}
	
	public List<OfficeVo> officeDetail(String officeName){
		return officeMapper.officeDetail(officeName);
	}
	
	public int selectOfficeNum(String officeName){
		return officeMapper.selectOfficeNum(officeName);
	}
	
	public int addSpaceInfo(int branchCode, int floor, int acreages, int rent, String officeName, int max){
		return officeMapper.addSpaceInfo(branchCode, floor, acreages, rent, officeName, max);
	}
}