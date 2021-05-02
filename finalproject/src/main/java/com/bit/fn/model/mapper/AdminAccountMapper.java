package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.AdminAccountVo;


@Repository
@Mapper
public interface AdminAccountMapper {
	
	public List<AdminAccountVo> selectAll();
	public AdminAccountVo selectOne(String id);
	public int deleteOne(String id);
	public int updateInfo(@Param("nickName") String nickName, @Param("id") String id);
}
