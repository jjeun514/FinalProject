package com.bit.fn.model.service.join;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.join.MeetingRoomAndBranchMapper;
import com.bit.fn.model.vo.join.MeetingRoomAndBranchVo;


@Service
public class MeetingRoomAndBranchService {
	@Autowired
	MeetingRoomAndBranchMapper meetingRoomAndBranchMapper;
	
	public List<MeetingRoomAndBranchVo> selectAll() {
		return meetingRoomAndBranchMapper.selectAll();
	}
	public int updateMeetingRoom(String acreages, int rent, int max, int roomNum,  String branchName) {
		return meetingRoomAndBranchMapper.updateMeetingRoom(acreages, rent, max, roomNum, branchName);
	}
	public int deleteMeetingRoom(int roomNum, int branchCode) {
		return meetingRoomAndBranchMapper.deleteMeetingRoom(roomNum, branchCode);
	}
	public int addMeetingRoom(int roomNum, int branchCode, String acreage, int rent, int max) {
		return meetingRoomAndBranchMapper.addMeetingRoom(roomNum, branchCode, acreage, rent, max);
	}
}

