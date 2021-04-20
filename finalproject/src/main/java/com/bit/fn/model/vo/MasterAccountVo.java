package com.bit.fn.model.vo;

import java.sql.Date;

public class MasterAccountVo {
	private int comCode,admission;
	private String id,profile;
	private Date signdate;
	public MasterAccountVo() {}
	public MasterAccountVo(int comCode, int admission, String id, String profile, Date signdate) {
		super();
		this.comCode = comCode;
		this.admission = admission;
		this.id = id;
		this.profile = profile;
		this.signdate = signdate;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
		result = prime * result + admission;
		result = prime * result + comCode;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		if (admission != other.admission)
			return false;
		if (comCode != other.comCode)
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
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
		return "MasterAccountVo [comCode=" + comCode + ", admission=" + admission + ", id=" + id + ", profile="
				+ profile + ", signdate=" + signdate + "]";
	}
	
}
