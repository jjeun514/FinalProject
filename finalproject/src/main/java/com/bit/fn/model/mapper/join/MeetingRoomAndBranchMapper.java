package com.bit.fn.model.mapper.join;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.MeetingRoomAndBranchVo;


@Repository
@Mapper
public interface MeetingRoomAndBranchMapper {
	public List<MeetingRoomAndBranchVo> selectAll();
	int updateMeetingRoom(@Param("acreages") String acreages, @Param("rent") int rent, @Param("max") int max,
						  @Param("roomNum") int roomNum, @Param("branchName") String branchName);
	int deleteMeetingRoom(@Param("roomNum") int roomNum, @Param("branchCode") int branchCode);
	int addMeetingRoom(@Param("roomNum") int roomNum, @Param("branchCode") int branchCode, @Param("acreages") String acreages,
					   @Param("rent") int rent, @Param("max") int max);
				
}
