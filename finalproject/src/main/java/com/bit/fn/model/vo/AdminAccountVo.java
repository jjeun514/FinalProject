package com.bit.fn.model.vo;

public class AdminAccountVo {
	private String id,nickName,profile;
	private int adminNum,branchCode;
	public AdminAccountVo() {}
	public AdminAccountVo(String id, String nickName, String profile, int adminNum, int branchCode) {
		super();
		this.id = id;
		this.nickName = nickName;
		this.profile = profile;
		this.adminNum = adminNum;
		this.branchCode = branchCode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public int getAdminNum() {
		return adminNum;
	}
	public void setAdminNum(int adminNum) {
		this.adminNum = adminNum;
	}
	public int getBranchCode() {
		return branchCode;
	}
	public void setBranchCode(int branchCode) {
		this.branchCode = branchCode;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + adminNum;
		result = prime * result + branchCode;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((nickName == null) ? 0 : nickName.hashCode());
		result = prime * result + ((profile == null) ? 0 : profile.hashCode());
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
		AdminAccountVo other = (AdminAccountVo) obj;
		if (adminNum != other.adminNum)
			return false;
		if (branchCode != other.branchCode)
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (nickName == null) {
			if (other.nickName != null)
				return false;
		} else if (!nickName.equals(other.nickName))
			return false;
		if (profile == null) {
			if (other.profile != null)
				return false;
		} else if (!profile.equals(other.profile))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "AdminAccountVo [id=" + id + ", nickName=" + nickName + ", profile=" + profile + ", adminNum=" + adminNum
				+ ", branchCode=" + branchCode + "]";
	}
	
}
