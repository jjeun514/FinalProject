package com.bit.fn.model.mapper.join;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.ReservationListVo;


@Repository
@Mapper
public interface ReservationListMapper {
	public List<ReservationListVo> selectAllJoin();
}
