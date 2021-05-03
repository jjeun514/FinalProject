package com.bit.fn.security.model;

public class AccountRole {
	private int account_num;
	private int role_num;
	public AccountRole() {}
	public AccountRole(int account_num, int role_num) {
		super();
		this.account_num = account_num;
		this.role_num = role_num;
	}
	public int getAccount_num() {
		return account_num;
	}
	public void setAccount_num(int account_num) {
		this.account_num = account_num;
	}
	public int getRole_num() {
		return role_num;
	}
	public void setRole_num(int role_num) {
		this.role_num = role_num;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + account_num;
		result = prime * result + role_num;
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
		AccountRole other = (AccountRole) obj;
		if (account_num != other.account_num)
			return false;
		if (role_num != other.role_num)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "accountRole [account_num=" + account_num + ", role_num=" + role_num + "]";
	}
	
}
