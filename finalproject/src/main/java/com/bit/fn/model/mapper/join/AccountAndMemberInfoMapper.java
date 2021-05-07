package com.bit.fn.model.mapper.join;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface AccountAndMemberInfoMapper {
	public int updateMemberAdmission(@Param("enabled") int enabled, 
									 @Param("admission") int admission, 
									 @Param("id") String id
									 );
}
