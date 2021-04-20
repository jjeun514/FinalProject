package com.bit.fn.model.vo;

public class MemberInfoVo {
	private int memNum,comCode,admission;
	private String memName,memNickName,id,dept,memPhone,signdate;
	public MemberInfoVo() {}
	public MemberInfoVo(int memNum, int comCode, int admission, String memName, String memNickName, String id,
			String dept, String memPhone, String signdate) {
		super();
		this.memNum = memNum;
		this.comCode = comCode;
		this.admission = admission;
		this.memName = memName;
		this.memNickName = memNickName;
		this.id = id;
		this.dept = dept;
		this.memPhone = memPhone;
		this.signdate = signdate;
	}
	public int getMemNum() {
		return memNum;
	}
	public void setMemNum(int memNum) {
		this.memNum = memNum;
	}
	public int getComCode() {
		return comCode;
	}
	public void setComCode(int comCode) {
		this.comCode = comCode;
	}
	public int getAdmission() {
		return admission;
	}
	public void setAdmission(int admission) {
		this.admission = admission;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemNickName() {
		return memNickName;
	}
	public void setMemNickName(String memNickName) {
		this.memNickName = memNickName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getMemPhone() {
		return memPhone;
	}
	public void setMemPhone(String memPhone) {
		this.memPhone = memPhone;
	}
	public String getSigndate() {
		return signdate;
	}
	public void setSigndate(String signdate) {
		this.signdate = signdate;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + admission;
		result = prime * result + comCode;
		result = prime * result + ((dept == null) ? 0 : dept.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((memName == null) ? 0 : memName.hashCode());
		result = prime * result + ((memNickName == null) ? 0 : memNickName.hashCode());
		result = prime * result + memNum;
		result = prime * result + ((memPhone == null) ? 0 : memPhone.hashCode());
		result = prime * result + ((signdate == null) ? 0 : signdate.hashCode());
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
		if (admission != other.admission)
			return false;
		if (comCode != other.comCode)
			return false;
		if (dept == null) {
			if (other.dept != null)
				return false;
		} else if (!dept.equals(other.dept))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
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
		if (memNum != other.memNum)
			return false;
		if (memPhone == null) {
			if (other.memPhone != null)
				return false;
		} else if (!memPhone.equals(other.memPhone))
			return false;
		if (signdate == null) {
			if (other.signdate != null)
				return false;
		} else if (!signdate.equals(other.signdate))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "MemberInfoVo [memNum=" + memNum + ", comCode=" + comCode + ", admission=" + admission + ", memName="
				+ memName + ", memNickName=" + memNickName + ", id=" + id + ", dept=" + dept + ", memPhone=" + memPhone
				+ ", signdate=" + signdate + "]";
	}
	
	
}
