package com.bit.fn.model.mapper.join;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.BranchAndAdminVo;


@Repository
@Mapper
public interface BranchAndAdminMapper {
	public List<BranchAndAdminVo> selectAll();
	public List<BranchAndAdminVo> selectaa();
}
