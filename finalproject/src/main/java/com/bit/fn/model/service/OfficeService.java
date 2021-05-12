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
	
	public List<OfficeVo> officeDetail(String officeName, int floorInput){
		return officeMapper.officeDetail(officeName, floorInput);
	}
	
	public int selectOfficeNum(String officeName, int floorInput){
		return officeMapper.selectOfficeNum(officeName, floorInput);
	}
	
	public int addSpaceInfo(int branchCode, int floorInput, int acreagesInput, int rentInput, String officeName, int maxInput){
		return officeMapper.addSpaceInfo(branchCode, floorInput, acreagesInput, rentInput, officeName, maxInput);
	}
	
	public int updateOffice(int acreagesInput, int rentInput, int maxInput, int officeNum) {
		return officeMapper.updateOffice(acreagesInput, rentInput, maxInput, officeNum);
	}
}