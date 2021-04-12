package com.bit.nam.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.nam.model.vo.DeptVo;

@Repository
@Mapper
public interface DeptMapper {
	public List<DeptVo> selectAll();
}
