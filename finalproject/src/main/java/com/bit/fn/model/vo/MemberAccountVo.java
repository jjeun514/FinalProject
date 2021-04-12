package com.bit.fn.model.vo;

import java.sql.Date;

public class MemberAccountVo {
	private int comCode,admssion;
	private String memId,password,profile;
	private Date signdate;
	public MemberAccountVo() {}
	public MemberAccountVo(int comCode, int admssion, String memId, String password, String profile, Date signdate) {
		super();
		this.comCode = comCode;
		this.admssion = admssion;
		this.memId = memId;
		this.password = password;
		this.profile = profile;
		this.signdate = signdate;
	}
	public int getComCode() {
		return comCode;
	}
	public void setComCode(int comCode) {
		this.comCode = comCode;
	}
	public int getAdmssion() {
		return admssion;
	}
	public void setAdmssion(int admssion) {
		this.admssion = admssion;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public Date getSigndate() {
		return signdate;
	}
	public void setSigndate(Date signdate) {
		this.signdate = signdate;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + admssion;
		result = prime * result + comCode;
		result = prime * result + ((memId == null) ? 0 : memId.hashCode());
		result = prime * result + ((password == null) ? 0 : password.hashCode());
		result = prime * result + ((profile == null) ? 0 : profile.hashCode());
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
		MemberAccountVo other = (MemberAccountVo) obj;
		if (admssion != other.admssion)
			return false;
		if (comCode != other.comCode)
			return false;
		if (memId == null) {
			if (other.memId != null)
				return false;
		} else if (!memId.equals(other.memId))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		if (profile == null) {
			if (other.profile != null)
				return false;
		} else if (!profile.equals(other.profile))
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
		return "MemberAccountVo [comCode=" + comCode + ", admssion=" + admssion + ", memId=" + memId + ", password="
				+ password + ", profile=" + profile + ", signdate=" + signdate + "]";
	}
	
}
