package com.bit.fp.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fp.model.vo.BranchVo;

@Repository
@Mapper
public interface BranchMapper {
	public List<BranchVo> selectAll();
}
