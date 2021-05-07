package com.bit.fn.model.vo.join;

import com.bit.fn.model.vo.MemberInfoVo;
import com.bit.fn.security.model.Account;

public class AccountAndMemberInfoVo {
	private Account account;
	private MemberInfoVo memberInfoVo;
	public AccountAndMemberInfoVo() {}
	public AccountAndMemberInfoVo(Account account, MemberInfoVo memberInfoVo) {
		super();
		this.account = account;
		this.memberInfoVo = memberInfoVo;
	}
	public Account getAccount() {
		return account;
	}
	public void setAccount(Account account) {
		this.account = account;
	}
	public MemberInfoVo getMemberInfoVo() {
		return memberInfoVo;
	}
	public void setMemberInfoVo(MemberInfoVo memberInfoVo) {
		this.memberInfoVo = memberInfoVo;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((account == null) ? 0 : account.hashCode());
		result = prime * result + ((memberInfoVo == null) ? 0 : memberInfoVo.hashCode());
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
		AccountAndMemberInfoVo other = (AccountAndMemberInfoVo) obj;
		if (account == null) {
			if (other.account != null)
				return false;
		} else if (!account.equals(other.account))
			return false;
		if (memberInfoVo == null) {
			if (other.memberInfoVo != null)
				return false;
		} else if (!memberInfoVo.equals(other.memberInfoVo))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "AccountAndMemberInfoVo [account=" + account + ", memberInfoVo=" + memberInfoVo + "]";
	}
	
}
