package com.bit.fp.model.vo;

import java.sql.Date;

public class MasterAccountVo {
	private int comCode;
	private String masterId,password,profile;
	private Date signdate;
	public MasterAccountVo() {}
	public MasterAccountVo(int comCode, String masterId, String password, String profile, Date signdate) {
		super();
		this.comCode = comCode;
		this.masterId = masterId;
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
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
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
		result = prime * result + comCode;
		result = prime * result + ((masterId == null) ? 0 : masterId.hashCode());
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
		MasterAccountVo other = (MasterAccountVo) obj;
		if (comCode != other.comCode)
			return false;
		if (masterId == null) {
			if (other.masterId != null)
				return false;
		} else if (!masterId.equals(other.masterId))
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
		return "MasterAccountVo [comCode=" + comCode + ", masterId=" + masterId + ", password=" + password
				+ ", profile=" + profile + ", signdate=" + signdate + "]";
	}
	
	
}
