package com.bit.fn.model.mapper.join;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.MasteraccountAndCompanyInfoVo;


@Repository
@Mapper
public interface MasteraccountAndCompanyInfoMapper {
	public MasteraccountAndCompanyInfoVo masterOne(@Param("id") String id);
	public int updateInfo(
						  @Param("comName") String comName, 
						  @Param("ceo") String ceo, 
						  @Param("manager") String manager, 
						  @Param("comPhone") String comPhone, 
						  @Param("id") String id
						 );
	
	public List<MasteraccountAndCompanyInfoVo> selectAllMasterAccounts();
}