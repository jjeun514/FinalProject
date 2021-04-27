package com.bit.fn.model.mapper.join;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.MemberInfoAndCompanyInfoVo;


@Repository
@Mapper
public interface MemberInfoAndCompanyInfoMapper {
	public MemberInfoAndCompanyInfoVo memberOne(@Param("id") String id);
}
