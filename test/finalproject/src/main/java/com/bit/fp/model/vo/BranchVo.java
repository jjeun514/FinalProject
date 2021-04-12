package com.bit.fp.model.vo;

public class BranchVo {
	private int branchCode;
	private String branchName;
	public BranchVo() {}
	public BranchVo(int branchCode, String branchName) {
		super();
		this.branchCode = branchCode;
		this.branchName = branchName;
	}
	public int getBranchCode() {
		return branchCode;
	}
	public void setBranchCode(int branchCode) {
		this.branchCode = branchCode;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + branchCode;
		result = prime * result + ((branchName == null) ? 0 : branchName.hashCode());
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
		BranchVo other = (BranchVo) obj;
		if (branchCode != other.branchCode)
			return false;
		if (branchName == null) {
			if (other.branchName != null)
				return false;
		} else if (!branchName.equals(other.branchName))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "BranchVo [branchCode=" + branchCode + ", branchName=" + branchName + "]";
	}
	
}
