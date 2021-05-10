package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.MasterAccountVo;


@Repository
@Mapper
public interface MasterAccountMapper {
	public List<MasterAccountVo> selectAll();
	public MasterAccountVo selectOne(String id);	
	public int insertOne(String id, int comCode);
	public int deleteOne(String id);
	public int idCount(String id);
}
