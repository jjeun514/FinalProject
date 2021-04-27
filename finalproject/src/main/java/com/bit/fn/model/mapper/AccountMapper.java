package com.bit.fn.model.mapper;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bit.fn.security.model.Account;



@Repository
@Mapper
public interface AccountMapper {
	public Account selectOne(@Param("username") String username);
	public int updatePw(@Param("password")String password ,@Param("username") String username);
}
