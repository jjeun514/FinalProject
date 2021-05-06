package com.bit.fn.model.mapper;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;




@Repository
@Mapper
public interface AccountRoleMapper {
	public int deleteOne(int account_num);
}
