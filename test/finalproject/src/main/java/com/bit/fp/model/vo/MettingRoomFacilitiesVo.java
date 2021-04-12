package com.bit.fp.model.vo;

public class MettingRoomFacilitiesVo {
	private int roomNum;
	private String desk,chair,modem;
	public MettingRoomFacilitiesVo() {}
	public MettingRoomFacilitiesVo(int roomNum, String desk, String chair, String modem) {
		super();
		this.roomNum = roomNum;
		this.desk = desk;
		this.chair = chair;
		this.modem = modem;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public String getDesk() {
		return desk;
	}
	public void setDesk(String desk) {
		this.desk = desk;
	}
	public String getChair() {
		return chair;
	}
	public void setChair(String chair) {
		this.chair = chair;
	}
	public String getModem() {
		return modem;
	}
	public void setModem(String modem) {
		this.modem = modem;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((chair == null) ? 0 : chair.hashCode());
		result = prime * result + ((desk == null) ? 0 : desk.hashCode());
		result = prime * result + ((modem == null) ? 0 : modem.hashCode());
		result = prime * result + roomNum;
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
		MettingRoomFacilitiesVo other = (MettingRoomFacilitiesVo) obj;
		if (chair == null) {
			if (other.chair != null)
				return false;
		} else if (!chair.equals(other.chair))
			return false;
		if (desk == null) {
			if (other.desk != null)
				return false;
		} else if (!desk.equals(other.desk))
			return false;
		if (modem == null) {
			if (other.modem != null)
				return false;
		} else if (!modem.equals(other.modem))
			return false;
		if (roomNum != other.roomNum)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "MettingRoomFacilitiesVo [roomNum=" + roomNum + ", desk=" + desk + ", chair=" + chair + ", modem="
				+ modem + "]";
	}
	
}
