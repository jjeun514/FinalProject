package com.bit.fn.model.mapper.join;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.BranchAndAdminVo;


@Repository
@Mapper
public interface BranchAndAdminMapper {
	public BranchAndAdminVo adminOne(@Param("id") String id);
}
