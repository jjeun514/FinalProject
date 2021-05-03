package com.bit.fn.model.vo;

public class MettingRoomVo {
	private int roomNum,branchCode,rent,max;
	private String acreages;
	public MettingRoomVo() {}
	public MettingRoomVo(int roomNum, int branchCode, int rent, int max, String acreages) {
		super();
		this.roomNum = roomNum;
		this.branchCode = branchCode;
		this.rent = rent;
		this.max = max;
		this.acreages = acreages;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public int getBranchCode() {
		return branchCode;
	}
	public void setBranchCode(int branchCode) {
		this.branchCode = branchCode;
	}
	public int getRent() {
		return rent;
	}
	public void setRent(int rent) {
		this.rent = rent;
	}
	public int getMax() {
		return max;
	}
	public void setMax(int max) {
		this.max = max;
	}
	public String getAcreages() {
		return acreages;
	}
	public void setAcreages(String acreages) {
		this.acreages = acreages;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((acreages == null) ? 0 : acreages.hashCode());
		result = prime * result + branchCode;
		result = prime * result + max;
		result = prime * result + rent;
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
		MettingRoomVo other = (MettingRoomVo) obj;
		if (acreages == null) {
			if (other.acreages != null)
				return false;
		} else if (!acreages.equals(other.acreages))
			return false;
		if (branchCode != other.branchCode)
			return false;
		if (max != other.max)
			return false;
		if (rent != other.rent)
			return false;
		if (roomNum != other.roomNum)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "MettingRoomVo [roomNum=" + roomNum + ", branchCode=" + branchCode + ", rent=" + rent + ", max=" + max
				+ ", acreages=" + acreages + "]";
	}
	
}
