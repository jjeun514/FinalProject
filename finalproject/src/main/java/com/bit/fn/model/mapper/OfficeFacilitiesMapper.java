package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.OfficeFacilitiesVo;


@Repository
@Mapper
public interface OfficeFacilitiesMapper {
	public List<OfficeFacilitiesVo> selectAll();

	public List<OfficeFacilitiesVo> officeFacilities(String officeName, int floorInput);
	public int addFacilities(int officeNum, int deskInput, int chairInput, int modemInput, int fireExtinguisherInput, int airConditionerInput, int radiatorInput, int descendingLifeLineInput, int powerSocketInput);
	public int updateSpaceInfo(int deskInput, int chairInput, int modemInput, int fireExtinguisherInput, int airConditionerInput, int radiatorInput, int descendingLifeLineInput, int powerSocketInput, int officeNum);
}
