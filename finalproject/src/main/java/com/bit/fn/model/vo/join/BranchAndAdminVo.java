package com.bit.fn.model.vo.join;

import com.bit.fn.model.vo.AdminAccountVo;
import com.bit.fn.model.vo.BranchVo;

public class BranchAndAdminVo {
	private BranchVo branch;
	private AdminAccountVo adminAccount;
	public BranchAndAdminVo() {}
	public BranchAndAdminVo(BranchVo branch, AdminAccountVo adminAccount) {
		super();
		this.branch = branch;
		this.adminAccount = adminAccount;
	}
	public BranchVo getBranch() {
		return branch;
	}
	public void setBranch(BranchVo branch) {
		this.branch = branch;
	}
	public AdminAccountVo getAdminAccount() {
		return adminAccount;
	}
	public void setAdminAccount(AdminAccountVo adminAccount) {
		this.adminAccount = adminAccount;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((adminAccount == null) ? 0 : adminAccount.hashCode());
		result = prime * result + ((branch == null) ? 0 : branch.hashCode());
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
		if (adminAccount == null) {
			if (other.adminAccount != null)
				return false;
		} else if (!adminAccount.equals(other.adminAccount))
			return false;
		if (branch == null) {
			if (other.branch != null)
				return false;
		} else if (!branch.equals(other.branch))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "BranchAndAdminVo [branch=" + branch + ", adminAccount=" + adminAccount + "]";
	}
	
}
