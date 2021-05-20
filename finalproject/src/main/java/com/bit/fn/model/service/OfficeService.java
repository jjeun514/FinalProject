package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.OfficeMapper;
import com.bit.fn.model.vo.OfficeVo;


@Service
public class OfficeService implements OfficeMapper{
	@Autowired
	OfficeMapper officeMapper;
	
	public List<OfficeVo> selectAll(){
		return officeMapper.selectAll();
	}
	
	public List<OfficeVo> selectAllFloors(){
		return officeMapper.selectAllFloors();
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
	
	public List<OfficeVo> selectOfficeNum(String officeName, int floorInput, String branchName){
		return officeMapper.selectOfficeNum(officeName, floorInput, branchName);
	}
	
	public int addSpaceInfo(int branchCode, int floorInput, int acreagesInput, int rentInput, String officeName, int maxInput, int occupancy){
		return officeMapper.addSpaceInfo(branchCode, floorInput, acreagesInput, rentInput, officeName, maxInput, occupancy);
	}
	
	public int updateOffice(int acreagesInput, int rentInput, int maxInput, int officeNum) {
		return officeMapper.updateOffice(acreagesInput, rentInput, maxInput, officeNum);
	}
	
	public int updateOccupancy(int occupancy, int officeNum) {
		return officeMapper.updateOccupancy(occupancy, officeNum);
	}
	
	public int deleteSpace(int officeNum) {
		return officeMapper.deleteSpace(officeNum);
	}
	
	public List<OfficeVo> officeNum(int floor, String branchName, String officeName) {
		return officeMapper.officeNum(floor, branchName, officeName);
	}
}