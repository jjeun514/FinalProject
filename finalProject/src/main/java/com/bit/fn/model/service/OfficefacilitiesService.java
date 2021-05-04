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
	
	public List<OfficeFacilitiesVo> officeFacilities(String officeName){
		return officeFacilitiesMapper.officeFacilities(officeName);
	}
}
