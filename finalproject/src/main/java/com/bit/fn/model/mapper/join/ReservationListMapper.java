package com.bit.fn.model.mapper.join;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.ReservationListVo;


@Repository
@Mapper
public interface ReservationListMapper {
	public List<ReservationListVo> selectAllJoin();
	public ReservationListVo selectOneJoin(@Param("memNickName") String memNickName,@Param("reservationDay") String reservationDay,@Param("useStartTime") String useStartTime);
	public int updateReservation(@Param("roomNum") int roomNum, @Param("updateReservationDay") String updateReservationDay,
								 @Param("updateUseStartTime") String updateUseStartTime,
								 @Param("useFinishTime") String useFinishTime,
								 @Param("userCount")int userCount,
								 @Param("fee") int fee, @Param("memNickName") String memNickName,
								 @Param("reservationDay") String reservationDay, @Param("useStartTime") String useStartTime);
	public int deleteReservation(@Param("roomNum") int roomNum , @Param("reservationDay") String reservationDay, @Param("useStartTime") String useStartTime);
	
}
