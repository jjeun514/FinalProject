package com.bit.fn.model.vo.join;

import com.bit.fn.model.vo.CompanyInfoVo;
import com.bit.fn.model.vo.MemberInfoVo;
import com.bit.fn.model.vo.ReservationVo;

public class ReservationListVo {
	private ReservationVo reservation;
	private MemberInfoVo memberInfo;
	private CompanyInfoVo companyInfo;
	
	public ReservationListVo() {}

	public ReservationListVo(ReservationVo reservation, MemberInfoVo memberInfo, CompanyInfoVo companyInfo) {
		super();
		this.reservation = reservation;
		this.memberInfo = memberInfo;
		this.companyInfo = companyInfo;
	}

	public ReservationVo getReservation() {
		return reservation;
	}

	public void setReservation(ReservationVo reservation) {
		this.reservation = reservation;
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
		result = prime * result + ((reservation == null) ? 0 : reservation.hashCode());
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
		ReservationListVo other = (ReservationListVo) obj;
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
		if (reservation == null) {
			if (other.reservation != null)
				return false;
		} else if (!reservation.equals(other.reservation))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ReservationListVo [reservation=" + reservation + ", memberInfo=" + memberInfo + ", companyInfo="
				+ companyInfo + "]";
	}
	
	
}
