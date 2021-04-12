package com.bit.fn.model.vo;

public class MemberInfoVo {
	private int comCode;
	private String memId,memName,department,memPhone,memNickName;
	public MemberInfoVo() {}
	public MemberInfoVo(int comCode, String memId, String memName, String department, String memPhone,
			String memNickName) {
		super();
		this.comCode = comCode;
		this.memId = memId;
		this.memName = memName;
		this.department = department;
		this.memPhone = memPhone;
		this.memNickName = memNickName;
	}
	public int getComCode() {
		return comCode;
	}
	public void setComCode(int comCode) {
		this.comCode = comCode;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getMemPhone() {
		return memPhone;
	}
	public void setMemPhone(String memPhone) {
		this.memPhone = memPhone;
	}
	public String getMemNickName() {
		return memNickName;
	}
	public void setMemNickName(String memNickName) {
		this.memNickName = memNickName;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + comCode;
		result = prime * result + ((department == null) ? 0 : department.hashCode());
		result = prime * result + ((memId == null) ? 0 : memId.hashCode());
		result = prime * result + ((memName == null) ? 0 : memName.hashCode());
		result = prime * result + ((memNickName == null) ? 0 : memNickName.hashCode());
		result = prime * result + ((memPhone == null) ? 0 : memPhone.hashCode());
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
		MemberInfoVo other = (MemberInfoVo) obj;
		if (comCode != other.comCode)
			return false;
		if (department == null) {
			if (other.department != null)
				return false;
		} else if (!department.equals(other.department))
			return false;
		if (memId == null) {
			if (other.memId != null)
				return false;
		} else if (!memId.equals(other.memId))
			return false;
		if (memName == null) {
			if (other.memName != null)
				return false;
		} else if (!memName.equals(other.memName))
			return false;
		if (memNickName == null) {
			if (other.memNickName != null)
				return false;
		} else if (!memNickName.equals(other.memNickName))
			return false;
		if (memPhone == null) {
			if (other.memPhone != null)
				return false;
		} else if (!memPhone.equals(other.memPhone))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "MemberInfoVo [comCode=" + comCode + ", memId=" + memId + ", memName=" + memName + ", department="
				+ department + ", memPhone=" + memPhone + ", memNickName=" + memNickName + "]";
	}
	
}
