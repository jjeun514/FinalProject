package com.bit.fn.model.vo;

import java.sql.Date;

public class ReservationVo {
	
	private int roomNum, memNum, userCount, fee, rent;
	private String etc, memName, comName, useStartTime, useFinishTime;
	private Date reservationDay;
	
	public ReservationVo() {
	}

	public ReservationVo(int roomNum, int memNum, int userCount, int fee, int rent, String etc, String memName,
			String comName, Date reservationDay, String useStartTime, String useFinishTime) {
		super();
		this.roomNum = roomNum;
		this.memNum = memNum;
		this.userCount = userCount;
		this.fee = fee;
		this.rent = rent;
		this.etc = etc;
		this.memName = memName;
		this.comName = comName;
		this.reservationDay = reservationDay;
		this.useStartTime = useStartTime;
		this.useFinishTime = useFinishTime;
	}

	public int getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}

	public int getMemNum() {
		return memNum;
	}

	public void setMemNum(int memNum) {
		this.memNum = memNum;
	}

	public int getUserCount() {
		return userCount;
	}

	public void setUserCount(int userCount) {
		this.userCount = userCount;
	}

	public int getFee() {
		return fee;
	}

	public void setFee(int fee) {
		this.fee = fee;
	}

	public int getRent() {
		return rent;
	}

	public void setRent(int rent) {
		this.rent = rent;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getComName() {
		return comName;
	}

	public void setComName(String comName) {
		this.comName = comName;
	}

	public Date getReservationDay() {
		return reservationDay;
	}

	public void setReservationDay(Date reservationDay) {
		this.reservationDay = reservationDay;
	}

	public String getUseStartTime() {
		return useStartTime;
	}

	public void setUseStartTime(String useStartTime) {
		this.useStartTime = useStartTime;
	}

	public String getUseFinishTime() {
		return useFinishTime;
	}

	public void setUseFinishTime(String useFinishTime) {
		this.useFinishTime = useFinishTime;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((comName == null) ? 0 : comName.hashCode());
		result = prime * result + ((etc == null) ? 0 : etc.hashCode());
		result = prime * result + fee;
		result = prime * result + ((memName == null) ? 0 : memName.hashCode());
		result = prime * result + memNum;
		result = prime * result + rent;
		result = prime * result + ((reservationDay == null) ? 0 : reservationDay.hashCode());
		result = prime * result + roomNum;
		result = prime * result + ((useFinishTime == null) ? 0 : useFinishTime.hashCode());
		result = prime * result + ((useStartTime == null) ? 0 : useStartTime.hashCode());
		result = prime * result + userCount;
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
		ReservationVo other = (ReservationVo) obj;
		if (comName == null) {
			if (other.comName != null)
				return false;
		} else if (!comName.equals(other.comName))
			return false;
		if (etc == null) {
			if (other.etc != null)
				return false;
		} else if (!etc.equals(other.etc))
			return false;
		if (fee != other.fee)
			return false;
		if (memName == null) {
			if (other.memName != null)
				return false;
		} else if (!memName.equals(other.memName))
			return false;
		if (memNum != other.memNum)
			return false;
		if (rent != other.rent)
			return false;
		if (reservationDay == null) {
			if (other.reservationDay != null)
				return false;
		} else if (!reservationDay.equals(other.reservationDay))
			return false;
		if (roomNum != other.roomNum)
			return false;
		if (useFinishTime == null) {
			if (other.useFinishTime != null)
				return false;
		} else if (!useFinishTime.equals(other.useFinishTime))
			return false;
		if (useStartTime == null) {
			if (other.useStartTime != null)
				return false;
		} else if (!useStartTime.equals(other.useStartTime))
			return false;
		if (userCount != other.userCount)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ReservationVo [roomNum=" + roomNum + ", memNum=" + memNum + ", userCount=" + userCount + ", fee=" + fee
				+ ", rent=" + rent + ", etc=" + etc + ", memName=" + memName + ", comName=" + comName
				+ ", reservationDay=" + reservationDay + ", useStartTime=" + useStartTime + ", useFinishTime="
				+ useFinishTime + "]";
	}


}
