package com.bit.fn.model.vo.join;

import com.bit.fn.model.vo.BranchVo;
import com.bit.fn.model.vo.CompanyInfoVo;
import com.bit.fn.model.vo.MasterAccountVo;
import com.bit.fn.model.vo.OfficeVo;

public class TenantsMgmtVo {
	private CompanyInfoVo companyInfo;
	private MasterAccountVo masterAccount;
	private OfficeVo office;
	private BranchVo branch;
	
	public TenantsMgmtVo() {}
	
	public TenantsMgmtVo(CompanyInfoVo companyInfo, MasterAccountVo masterAccount, OfficeVo office, BranchVo branch) {
		super();
		this.companyInfo = companyInfo;
		this.masterAccount = masterAccount;
		this.office = office;
		this.branch = branch;
	}
	public CompanyInfoVo getCompanyInfo() {
		return companyInfo;
	}
	public void setCompanyInfo(CompanyInfoVo companyInfo) {
		this.companyInfo = companyInfo;
	}
	public MasterAccountVo getMasterAccount() {
		return masterAccount;
	}
	public void setMasterAccount(MasterAccountVo masterAccount) {
		this.masterAccount = masterAccount;
	}
	public OfficeVo getOffice() {
		return office;
	}
	public void setOffice(OfficeVo office) {
		this.office = office;
	}
	public BranchVo getBranch() {
		return branch;
	}
	public void setBranch(BranchVo branch) {
		this.branch = branch;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((branch == null) ? 0 : branch.hashCode());
		result = prime * result + ((companyInfo == null) ? 0 : companyInfo.hashCode());
		result = prime * result + ((masterAccount == null) ? 0 : masterAccount.hashCode());
		result = prime * result + ((office == null) ? 0 : office.hashCode());
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
		TenantsMgmtVo other = (TenantsMgmtVo) obj;
		if (branch == null) {
			if (other.branch != null)
				return false;
		} else if (!branch.equals(other.branch))
			return false;
		if (companyInfo == null) {
			if (other.companyInfo != null)
				return false;
		} else if (!companyInfo.equals(other.companyInfo))
			return false;
		if (masterAccount == null) {
			if (other.masterAccount != null)
				return false;
		} else if (!masterAccount.equals(other.masterAccount))
			return false;
		if (office == null) {
			if (other.office != null)
				return false;
		} else if (!office.equals(other.office))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "TenantsMgmtVo [companyInfo=" + companyInfo + ", masterAccount=" + masterAccount + ", office=" + office
				+ ", branch=" + branch + "]";
	}
}