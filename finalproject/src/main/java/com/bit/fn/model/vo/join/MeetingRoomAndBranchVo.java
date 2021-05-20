package com.bit.fn.model.vo.join;

import com.bit.fn.model.vo.BranchVo;
import com.bit.fn.model.vo.MettingRoomVo;

public class MeetingRoomAndBranchVo {
	private MettingRoomVo meetingRoom;
	private BranchVo branch;
	
	public MeetingRoomAndBranchVo() {}

	public MeetingRoomAndBranchVo(MettingRoomVo meetingRoom, BranchVo branch) {
		super();
		this.meetingRoom = meetingRoom;
		this.branch = branch;
	}

	public MettingRoomVo getMeetingRoom() {
		return meetingRoom;
	}

	public void setMeetingRoom(MettingRoomVo meetingRoom) {
		this.meetingRoom = meetingRoom;
	}

	public BranchVo getBranch() {
		return branch;
	}

	public void setBranch(BranchVo branch) {
		this.branch = branch;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((branch == null) ? 0 : branch.hashCode());
		result = prime * result + ((meetingRoom == null) ? 0 : meetingRoom.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MeetingRoomAndBranchVo other = (MeetingRoomAndBranchVo) obj;
		if (branch == null) {
			if (other.branch != null)
				return false;
		} else if (!branch.equals(other.branch))
			return false;
		if (meetingRoom == null) {
			if (other.meetingRoom != null)
				return false;
		} else if (!meetingRoom.equals(other.meetingRoom))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "MeetingRoomAndBranchVo [meetingRoom=" + meetingRoom + ", branch=" + branch + "]";
	}
	
}
