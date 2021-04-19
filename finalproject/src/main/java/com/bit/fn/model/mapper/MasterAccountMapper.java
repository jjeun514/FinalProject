package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.MasterAccountVo;


@Repository
@Mapper
public interface MasterAccountMapper {
	public List<MasterAccountVo> selectAll();
}
