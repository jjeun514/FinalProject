package com.bit.fn.model.vo.join;

import com.bit.fn.model.vo.BranchVo;
import com.bit.fn.model.vo.OfficeVo;

public class BranchAndOfficeVo {
	private BranchVo branch;
	private OfficeVo office;
	public BranchAndOfficeVo() {}

	public BranchAndOfficeVo(BranchVo branch, OfficeVo office) {
		super();
		this.branch = branch;
		this.office = office;
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
		BranchAndOfficeVo other = (BranchAndOfficeVo) obj;
		if (branch == null) {
			if (other.branch != null)
				return false;
		} else if (!branch.equals(other.branch))
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
		return "BranchAndOfficeVo [branch=" + branch + ", office=" + office + "]";
	}
}