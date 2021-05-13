package com.bit.fn.model.vo.join;

import com.bit.fn.model.vo.BranchVo;
import com.bit.fn.model.vo.CompanyInfoVo;
import com.bit.fn.model.vo.OfficeVo;

public class BranchAndOfficeAndCompanyInfoVo {
	private BranchVo branch;
	private OfficeVo office;
	private CompanyInfoVo companyInfo;
	public BranchAndOfficeAndCompanyInfoVo() {}
	
	public BranchAndOfficeAndCompanyInfoVo(BranchVo branch, OfficeVo office, CompanyInfoVo companyInfo) {
		super();
		this.branch = branch;
		this.office = office;
		this.companyInfo = companyInfo;
	}

	public BranchVo getBranch() {
		return branch;
	}

	public void setBranch(BranchVo branch) {
		this.branch = branch;
	}

	public OfficeVo getOffice() {
		return office;
	}

	public void setOffice(OfficeVo office) {
		this.office = office;
	}

	public CompanyInfoVo getCompanyInfo() {
		return companyInfo;
	}

	public void setCompanyInfo(CompanyInfoVo companyInfo) {
		this.companyInfo = companyInfo;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((branch == null) ? 0 : branch.hashCode());
		result = prime * result + ((companyInfo == null) ? 0 : companyInfo.hashCode());
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
		BranchAndOfficeAndCompanyInfoVo other = (BranchAndOfficeAndCompanyInfoVo) obj;
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
		if (office == null) {
			if (other.office != null)
				return false;
		} else if (!office.equals(other.office))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "BranchAndOfficeAndCompanyInfoVo [branch=" + branch + ", office=" + office + ", companyInfo="
				+ companyInfo + "]";
	}
}