package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.ReservationVo;


@Repository
@Mapper
public interface ReservationMapper {
	public List<ReservationVo> selectAll();
	public List<ReservationVo> selectAllRoomNum();
	public List<ReservationVo> countReservation(String today);
}