package com.bit.fn.model.vo;

public class OfficeVo {
	private int officeNum,branchCode,floor,rent,occupancy,max;
	private String officeName, branchName,comName,acreages,photo;
	public OfficeVo() {}
	public OfficeVo(int officeNum, int branchCode, int floor, int rent, int occupancy, int max, String officeName,
			String branchName, String comName, String acreages, String photo) {
		super();
		this.officeNum = officeNum;
		this.branchCode = branchCode;
		this.floor = floor;
		this.rent = rent;
		this.occupancy = occupancy;
		this.max = max;
		this.officeName = officeName;
		this.branchName = branchName;
		this.comName = comName;
		this.acreages = acreages;
		this.photo = photo;
	}
	public String getBranchName() {
		return branchName;
	}
	public String getOfficeName() {
		return officeName;
	}
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getComName() {
		return comName;
	}
	public void setComName(String comName) {
		this.comName = comName;
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
		result = prime * result + ((branchName == null) ? 0 : branchName.hashCode());
		result = prime * result + ((comName == null) ? 0 : comName.hashCode());
		result = prime * result + floor;
		result = prime * result + max;
		result = prime * result + occupancy;
		result = prime * result + ((officeName == null) ? 0 : officeName.hashCode());
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
		if (branchName == null) {
			if (other.branchName != null)
				return false;
		} else if (!branchName.equals(other.branchName))
			return false;
		if (comName == null) {
			if (other.comName != null)
				return false;
		} else if (!comName.equals(other.comName))
			return false;
		if (floor != other.floor)
			return false;
		if (max != other.max)
			return false;
		if (occupancy != other.occupancy)
			return false;
		if (officeName == null) {
			if (other.officeName != null)
				return false;
		} else if (!officeName.equals(other.officeName))
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
		return "OfficeVo [officeNum=" + officeNum + ", branchCode=" + branchCode + ", floor=" + floor + ", rent=" + rent
				+ ", occupancy=" + occupancy + ", max=" + max + ", officeName=" + officeName + ", branchName="
				+ branchName + ", comName=" + comName + ", acreages=" + acreages + ", photo=" + photo + "]";
	}
}