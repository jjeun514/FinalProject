package com.bit.fn.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.OfficeFacilitiesMapper;
import com.bit.fn.model.vo.OfficeFacilitiesVo;


@Service
public class OfficefacilitiesService {
	@Autowired
	OfficeFacilitiesMapper officeFacilitiesMapper;
	
	public List<OfficeFacilitiesVo> selectAll(){
		return officeFacilitiesMapper.selectAll();
	}
	
	public List<OfficeFacilitiesVo> officeFacilities(String officeName, int floorInput){
		return officeFacilitiesMapper.officeFacilities(officeName, floorInput);
	}
	
	public int addFacilities(int officeNum, int deskInput, int chairInput, int modemInput, int fireExtinguisherInput, int airConditionerInput, int radiatorInput, int descendingLifeLineInput, int powerSocketInput){
		return officeFacilitiesMapper.addFacilities(officeNum, deskInput, chairInput, modemInput, fireExtinguisherInput, airConditionerInput, radiatorInput, descendingLifeLineInput, powerSocketInput);
	}
	
	public int updateSpaceInfo(int deskInput, int chairInput, int modemInput, int fireExtinguisherInput, int airConditionerInput, int radiatorInput, int descendingLifeLineInput, int powerSocketInput, int officeNum){
		return officeFacilitiesMapper.updateSpaceInfo(deskInput, chairInput, modemInput, fireExtinguisherInput, airConditionerInput, radiatorInput, descendingLifeLineInput, powerSocketInput, officeNum);
	}
	
	public int deleteSpace(int officeNum) {
		return officeFacilitiesMapper.deleteSpace(officeNum);
	}
}