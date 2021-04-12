package com.bit.fn.model.vo;

import java.sql.Date;

public class ReservationVo {
	private int roomNum,userCount,fee;
	private String memId,etc;
	private Date reservationDate,useStartDay,useFinishDay;
	public ReservationVo() {}
	public ReservationVo(int roomNum, int userCount, int fee, String memId, String etc, Date reservationDate,
			Date useStartDay, Date useFinishDay) {
		super();
		this.roomNum = roomNum;
		this.userCount = userCount;
		this.fee = fee;
		this.memId = memId;
		this.etc = etc;
		this.reservationDate = reservationDate;
		this.useStartDay = useStartDay;
		this.useFinishDay = useFinishDay;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
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
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public Date getReservationDate() {
		return reservationDate;
	}
	public void setReservationDate(Date reservationDate) {
		this.reservationDate = reservationDate;
	}
	public Date getUseStartDay() {
		return useStartDay;
	}
	public void setUseStartDay(Date useStartDay) {
		this.useStartDay = useStartDay;
	}
	public Date getUseFinishDay() {
		return useFinishDay;
	}
	public void setUseFinishDay(Date useFinishDay) {
		this.useFinishDay = useFinishDay;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((etc == null) ? 0 : etc.hashCode());
		result = prime * result + fee;
		result = prime * result + ((memId == null) ? 0 : memId.hashCode());
		result = prime * result + ((reservationDate == null) ? 0 : reservationDate.hashCode());
		result = prime * result + roomNum;
		result = prime * result + ((useFinishDay == null) ? 0 : useFinishDay.hashCode());
		result = prime * result + ((useStartDay == null) ? 0 : useStartDay.hashCode());
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
		if (etc == null) {
			if (other.etc != null)
				return false;
		} else if (!etc.equals(other.etc))
			return false;
		if (fee != other.fee)
			return false;
		if (memId == null) {
			if (other.memId != null)
				return false;
		} else if (!memId.equals(other.memId))
			return false;
		if (reservationDate == null) {
			if (other.reservationDate != null)
				return false;
		} else if (!reservationDate.equals(other.reservationDate))
			return false;
		if (roomNum != other.roomNum)
			return false;
		if (useFinishDay == null) {
			if (other.useFinishDay != null)
				return false;
		} else if (!useFinishDay.equals(other.useFinishDay))
			return false;
		if (useStartDay == null) {
			if (other.useStartDay != null)
				return false;
		} else if (!useStartDay.equals(other.useStartDay))
			return false;
		if (userCount != other.userCount)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "reservationVo [roomNum=" + roomNum + ", userCount=" + userCount + ", fee=" + fee + ", memId=" + memId
				+ ", etc=" + etc + ", reservationDate=" + reservationDate + ", useStartDay=" + useStartDay
				+ ", useFinishDay=" + useFinishDay + "]";
	}
	
}
