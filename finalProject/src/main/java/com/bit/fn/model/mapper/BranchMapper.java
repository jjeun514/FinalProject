package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.BranchVo;


@Repository
@Mapper
public interface BranchMapper {
	public List<BranchVo> selectAll();

	public List<BranchVo> selectAllBranchName();
}
