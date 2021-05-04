package com.bit.fn.model.vo.join;

import com.bit.fn.model.vo.CompanyInfoVo;
import com.bit.fn.model.vo.MemberInfoVo;

public class MemberInfoAndCompanyInfoVo {
	
	private MemberInfoVo memberInfo;
	private CompanyInfoVo companyInfo;
	public MemberInfoAndCompanyInfoVo() {}
	public MemberInfoAndCompanyInfoVo(MemberInfoVo memberInfo, CompanyInfoVo companyInfo) {
		super();
		this.memberInfo = memberInfo;
		this.companyInfo = companyInfo;
	}
	public MemberInfoVo getMemberInfo() {
		return memberInfo;
	}
	public void setMemberInfo(MemberInfoVo memberInfo) {
		this.memberInfo = memberInfo;
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
		result = prime * result + ((memberInfo == null) ? 0 : memberInfo.hashCode());
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
		MemberInfoAndCompanyInfoVo other = (MemberInfoAndCompanyInfoVo) obj;
		if (companyInfo == null) {
			if (other.companyInfo != null)
				return false;
		} else if (!companyInfo.equals(other.companyInfo))
			return false;
		if (memberInfo == null) {
			if (other.memberInfo != null)
				return false;
		} else if (!memberInfo.equals(other.memberInfo))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "MemberInfoAndCompanyInfoVo [memberInfo=" + memberInfo + ", companyInfo=" + companyInfo + "]";
	}
	

}
