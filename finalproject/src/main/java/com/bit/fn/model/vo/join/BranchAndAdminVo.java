package com.bit.fn.model.vo.join;

import com.bit.fn.model.vo.AdminAccountVo;
import com.bit.fn.model.vo.BranchVo;

public class BranchAndAdminVo {
	private BranchVo branchVo;
	private AdminAccountVo adminAccountVo;
	public BranchAndAdminVo() {}
	public BranchAndAdminVo(BranchVo branchVo, AdminAccountVo adminAccountVo) {
		super();
		this.branchVo = branchVo;
		this.adminAccountVo = adminAccountVo;
	}
	public BranchVo getBranchVo() {
		return branchVo;
	}
	public void setBranchVo(BranchVo branchVo) {
		this.branchVo = branchVo;
	}
	public AdminAccountVo getAdminAccountVo() {
		return adminAccountVo;
	}
	public void setAdminAccountVo(AdminAccountVo adminAccountVo) {
		this.adminAccountVo = adminAccountVo;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((adminAccountVo == null) ? 0 : adminAccountVo.hashCode());
		result = prime * result + ((branchVo == null) ? 0 : branchVo.hashCode());
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
		BranchAndAdminVo other = (BranchAndAdminVo) obj;
		if (adminAccountVo == null) {
			if (other.adminAccountVo != null)
				return false;
		} else if (!adminAccountVo.equals(other.adminAccountVo))
			return false;
		if (branchVo == null) {
			if (other.branchVo != null)
				return false;
		} else if (!branchVo.equals(other.branchVo))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "BranchAndAdmin [branchVo=" + branchVo + ", adminAccountVo=" + adminAccountVo + "]";
	}
	
}
