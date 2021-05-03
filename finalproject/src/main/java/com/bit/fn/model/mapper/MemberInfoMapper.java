package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.MemberInfoVo;


@Repository
@Mapper
public interface MemberInfoMapper {
	public List<MemberInfoVo> selectAll();
	public MemberInfoVo selectOne(String id);
	public MemberInfoVo selectId(@Param("name") String name, @Param("phone") String phone);
	public MemberInfoVo checkInfo(String name, String id, String phone);
	public List<MemberInfoVo> admissionMgmt();
	public List<MemberInfoVo> pending();
	public List<MemberInfoVo> approved();
}