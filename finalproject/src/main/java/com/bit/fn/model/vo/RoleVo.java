package com.bit.fn.model.vo;

public class RoleVo {
	private int num;
	private String roleId;
	public RoleVo() {}
	public RoleVo(int num, String roleId) {
		super();
		this.num = num;
		this.roleId = roleId;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + num;
		result = prime * result + ((roleId == null) ? 0 : roleId.hashCode());
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
		RoleVo other = (RoleVo) obj;
		if (num != other.num)
			return false;
		if (roleId == null) {
			if (other.roleId != null)
				return false;
		} else if (!roleId.equals(other.roleId))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "RoleVo [num=" + num + ", roleId=" + roleId + "]";
	}
	
	
}
