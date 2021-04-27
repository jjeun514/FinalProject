package com.bit.fn.model.mapper.join;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.MasteraccountAndCompanyInfoVo;


@Repository
@Mapper
public interface MasteraccountAndCompanyInfoMapper {
	public MasteraccountAndCompanyInfoVo masterOne(@Param("id") String id);
}
