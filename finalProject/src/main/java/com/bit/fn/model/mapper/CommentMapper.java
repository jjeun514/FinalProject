package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.CommentVo;


@Repository
@Mapper
public interface CommentMapper {
	public List<CommentVo> selectAll();
}
