package com.bit.fp.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fp.model.vo.OfficeFacilitiesVo;

@Repository
@Mapper
public interface OfficeFacilitiesMapper {
	public List<OfficeFacilitiesVo> selectAll();
}
