package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.MemberInfoVo;


@Repository
@Mapper
public interface MemberInfoMapper {
	public List<MemberInfoVo> selectAll();
	public MemberInfoVo selectOne(String id);
}
