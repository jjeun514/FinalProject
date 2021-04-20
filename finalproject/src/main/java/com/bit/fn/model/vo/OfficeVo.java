package com.bit.fn.model.vo;

public class OfficeVo {
	private int officeNum,branchCode,floor,rent,occupancy,max;
	private String acreages,leaser,photo;
	public OfficeVo() {}
	public OfficeVo(int officeNum, int branchCode, int floor, int rent, int occupancy, int max, String acreages,
			String leaser, String photo) {
		super();
		this.officeNum = officeNum;
		this.branchCode = branchCode;
		this.floor = floor;
		this.rent = rent;
		this.occupancy = occupancy;
		this.max = max;
		this.acreages = acreages;
		this.leaser = leaser;
		this.photo = photo;
	}
	public int getOfficeNum() {
		return officeNum;
	}
	public void setOfficeNum(int officeNum) {
		this.officeNum = officeNum;
	}
	public int getBranchCode() {
		return branchCode;
	}
	public void setBranchCode(int branchCode) {
		this.branchCode = branchCode;
	}
	public int getFloor() {
		return floor;
	}
	public void setFloor(int floor) {
		this.floor = floor;
	}
	public int getRent() {
		return rent;
	}
	public void setRent(int rent) {
		this.rent = rent;
	}
	public int getOccupancy() {
		return occupancy;
	}
	public void setOccupancy(int occupancy) {
		this.occupancy = occupancy;
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
	public String getLeaser() {
		return leaser;
	}
	public void setLeaser(String leaser) {
		this.leaser = leaser;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((acreages == null) ? 0 : acreages.hashCode());
		result = prime * result + branchCode;
		result = prime * result + floor;
		result = prime * result + ((leaser == null) ? 0 : leaser.hashCode());
		result = prime * result + max;
		result = prime * result + occupancy;
		result = prime * result + officeNum;
		result = prime * result + ((photo == null) ? 0 : photo.hashCode());
		result = prime * result + rent;
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
		OfficeVo other = (OfficeVo) obj;
		if (acreages == null) {
			if (other.acreages != null)
				return false;
		} else if (!acreages.equals(other.acreages))
			return false;
		if (branchCode != other.branchCode)
			return false;
		if (floor != other.floor)
			return false;
		if (leaser == null) {
			if (other.leaser != null)
				return false;
		} else if (!leaser.equals(other.leaser))
			return false;
		if (max != other.max)
			return false;
		if (occupancy != other.occupancy)
			return false;
		if (officeNum != other.officeNum)
			return false;
		if (photo == null) {
			if (other.photo != null)
				return false;
		} else if (!photo.equals(other.photo))
			return false;
		if (rent != other.rent)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "officeVo [officeNum=" + officeNum + ", branchCode=" + branchCode + ", floor=" + floor + ", rent=" + rent
				+ ", occupancy=" + occupancy + ", max=" + max + ", acreages=" + acreages + ", leaser=" + leaser
				+ ", photo=" + photo + "]";
	}
	
}
