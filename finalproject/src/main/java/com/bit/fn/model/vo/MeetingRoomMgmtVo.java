package com.bit.fn.model.vo;

//미팅룸,회의실 관리 ajax 전용 Vo
public class MeetingRoomMgmtVo {
	private String reservationDay, memNickName ,useStartTime;
	
	public MeetingRoomMgmtVo() {}

	public MeetingRoomMgmtVo(String reservationDay, String memNickName, String useStartTime) {
		super();
		this.reservationDay = reservationDay;
		this.memNickName = memNickName;
		this.useStartTime = useStartTime;
	}

	public String getReservationDay() {
		return reservationDay;
	}

	public void setReservationDay(String reservationDay) {
		this.reservationDay = reservationDay;
	}

	public String getMemNickName() {
		return memNickName;
	}

	public void setMemNickName(String memNickName) {
		this.memNickName = memNickName;
	}

	public String getUseStartTime() {
		return useStartTime;
	}

	public void setUseStartTime(String useStartTime) {
		this.useStartTime = useStartTime;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((memNickName == null) ? 0 : memNickName.hashCode());
		result = prime * result + ((reservationDay == null) ? 0 : reservationDay.hashCode());
		result = prime * result + ((useStartTime == null) ? 0 : useStartTime.hashCode());
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
		MeetingRoomMgmtVo other = (MeetingRoomMgmtVo) obj;
		if (memNickName == null) {
			if (other.memNickName != null)
				return false;
		} else if (!memNickName.equals(other.memNickName))
			return false;
		if (reservationDay == null) {
			if (other.reservationDay != null)
				return false;
		} else if (!reservationDay.equals(other.reservationDay))
			return false;
		if (useStartTime == null) {
			if (other.useStartTime != null)
				return false;
		} else if (!useStartTime.equals(other.useStartTime))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "MeetingRoomMgmtVo [reservationDay=" + reservationDay + ", memNickName=" + memNickName
				+ ", useStartTime=" + useStartTime + "]";
	}
	
	
}
