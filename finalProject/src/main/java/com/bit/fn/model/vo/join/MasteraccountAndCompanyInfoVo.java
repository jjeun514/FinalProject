package com.bit.fn.model.vo.join;

import com.bit.fn.model.vo.CompanyInfoVo;
import com.bit.fn.model.vo.MasterAccountVo;

public class MasteraccountAndCompanyInfoVo {
	private MasterAccountVo masteraccount;
	private CompanyInfoVo companyInfo;
	
	public MasteraccountAndCompanyInfoVo() {}

	public MasteraccountAndCompanyInfoVo(MasterAccountVo masteraccount, CompanyInfoVo companyInfo) {
		super();
		this.masteraccount = masteraccount;
		this.companyInfo = companyInfo;
	}

	public MasterAccountVo getMasteraccount() {
		return masteraccount;
	}

	public void setMasteraccount(MasterAccountVo masteraccount) {
		this.masteraccount = masteraccount;
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
		result = prime * result + ((companyInfo == null) ? 0 : companyInfo.hashCode());
		result = prime * result + ((masteraccount == null) ? 0 : masteraccount.hashCode());
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
		MasteraccountAndCompanyInfoVo other = (MasteraccountAndCompanyInfoVo) obj;
		if (companyInfo == null) {
			if (other.companyInfo != null)
				return false;
		} else if (!companyInfo.equals(other.companyInfo))
			return false;
		if (masteraccount == null) {
			if (other.masteraccount != null)
				return false;
		} else if (!masteraccount.equals(other.masteraccount))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "MasteraccountAndCompanyInfoVo [masteraccount=" + masteraccount + ", companyInfo=" + companyInfo + "]";
	}
	
}
