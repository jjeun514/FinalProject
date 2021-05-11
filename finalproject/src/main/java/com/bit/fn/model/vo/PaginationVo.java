package com.bit.fn.model.vo;

public class PaginationVo {

	// 현재 페이지
	private int currentPage;
	// 페이지당 출력할 페이지 갯수
    private int countPerPage;
    // 화면 하단 페이지 사이즈 1~10, 10~20 20~30 ...
    private int pageSize;
    // 전체 데이터 개수 
    private int totalRecordCount;
    // 전체 페이지 개수 
    private int totalPageCount;
    // 페이지 리스트의 첫 페이지 번호
    private int firstPageNum;
    // 페이지 리스트의 마지막 페이지 번호
    private int lastPageNum;
    // SQL의 조건절에 사용되는 첫 RNUM
    private int firstRecordIndex;
    // SQL의 조건절에 사용되는 마지막 RNUM
    private int lastRecordIndex;
    // 이전 페이지 존재 여부 
    private boolean hasPreviousPage;
    // 다음 페이지 존재 여부
    private boolean hasNextPage;
    
    public PaginationVo(int currentPage, int countPerPage, int pageSize) {
    	
    	//강제입력방지
        if (currentPage < 1) {
            currentPage = 1;
        }
        //10,20,30개 단위 이외 처리 방지
        if (countPerPage != 10 && countPerPage != 20 && countPerPage != 30) {
        	countPerPage = 10;
        }
        // 하단 페이지 갯수 7개로 제한
        if (pageSize != 7) {
            pageSize = 7;
        }
    	this.currentPage = currentPage;
    	this.countPerPage = countPerPage;
    	this.pageSize = pageSize;
    }

	public PaginationVo(int currentPage, int countPerPage, int pageSize, int totalRecordCount, int totalPageCount,
			int firstPageNum, int lastPageNum, int firstRecordIndex, int lastRecordIndex, boolean hasPreviousPage,
			boolean hasNextPage) {
		super();
		this.currentPage = currentPage;
		this.countPerPage = countPerPage;
		this.pageSize = pageSize;
		this.totalRecordCount = totalRecordCount;
		this.totalPageCount = totalPageCount;
		this.firstPageNum = firstPageNum;
		this.lastPageNum = lastPageNum;
		this.firstRecordIndex = firstRecordIndex;
		this.lastRecordIndex = lastRecordIndex;
		this.hasPreviousPage = hasPreviousPage;
		this.hasNextPage = hasNextPage;
	}
	
	public void calculation() {
		 
        // 전체 페이지 수 (현재 페이지 번호가 전체 페이지 수보다 크면 현재 페이지 번호에 전체 페이지 수를 저장)
        totalPageCount = ((totalRecordCount - 1) / this.getCountPerPage()) + 1;
        if (this.getCurrentPage() > totalPageCount) {
            this.setCurrentPage(totalPageCount);
        }
 
        // 페이지 리스트의 첫 페이지 번호
        firstPageNum = ((this.getCurrentPage() - 1) / this.getPageSize()) * this.getPageSize() + 1;
 
        // 페이지 리스트의 마지막 페이지 번호 (마지막 페이지가 전체 페이지 수보다 크면 마지막 페이지에 전체 페이지 수를 저장)
        lastPageNum = firstPageNum + this.getPageSize() - 1;
        if (lastPageNum > totalPageCount) {
            lastPageNum = totalPageCount;
        }
 
        // SQL의 조건절에 사용되는 첫 RNUM
        firstRecordIndex = (this.getCurrentPage() - 1) * this.getCountPerPage();
 
        // SQL의 조건절에 사용되는 마지막 RNUM
        lastRecordIndex = this.getCurrentPage() * this.getCountPerPage();
 
        // 이전 페이지 존재 여부
        hasPreviousPage = firstPageNum == 1 ? false : true;
        if(hasPreviousPage == false) {
            if(currentPage != firstPageNum) {
                hasPreviousPage = true;
            }else {
                hasPreviousPage = false;
            }
        }
 
        // 다음 페이지 존재 여부
        hasNextPage = (lastPageNum * this.getCountPerPage()) >= totalRecordCount ? false : true;
        if(hasNextPage == false) {
            //마지막 페이지에서 현재페이지가 마지막 페이지가 아닌경우 next처리
            if(currentPage != lastPageNum) {
                hasNextPage = true;
            }else {
                hasNextPage = false;
            }
        }
    }

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getCountPerPage() {
		return countPerPage;
	}

	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalRecordCount() {
		return totalRecordCount;
	}

	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getFirstPageNum() {
		return firstPageNum;
	}

	public void setFirstPageNum(int firstPageNum) {
		this.firstPageNum = firstPageNum;
	}

	public int getLastPageNum() {
		return lastPageNum;
	}

	public void setLastPageNum(int lastPageNum) {
		this.lastPageNum = lastPageNum;
	}

	public int getFirstRecordIndex() {
		return firstRecordIndex;
	}

	public void setFirstRecordIndex(int firstRecordIndex) {
		this.firstRecordIndex = firstRecordIndex;
	}

	public int getLastRecordIndex() {
		return lastRecordIndex;
	}

	public void setLastRecordIndex(int lastRecordIndex) {
		this.lastRecordIndex = lastRecordIndex;
	}

	public boolean isHasPreviousPage() {
		return hasPreviousPage;
	}

	public void setHasPreviousPage(boolean hasPreviousPage) {
		this.hasPreviousPage = hasPreviousPage;
	}

	public boolean isHasNextPage() {
		return hasNextPage;
	}

	public void setHasNextPage(boolean hasNextPage) {
		this.hasNextPage = hasNextPage;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + countPerPage;
		result = prime * result + currentPage;
		result = prime * result + firstPageNum;
		result = prime * result + firstRecordIndex;
		result = prime * result + (hasNextPage ? 1231 : 1237);
		result = prime * result + (hasPreviousPage ? 1231 : 1237);
		result = prime * result + lastPageNum;
		result = prime * result + lastRecordIndex;
		result = prime * result + pageSize;
		result = prime * result + totalPageCount;
		result = prime * result + totalRecordCount;
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
		PaginationVo other = (PaginationVo) obj;
		if (countPerPage != other.countPerPage)
			return false;
		if (currentPage != other.currentPage)
			return false;
		if (firstPageNum != other.firstPageNum)
			return false;
		if (firstRecordIndex != other.firstRecordIndex)
			return false;
		if (hasNextPage != other.hasNextPage)
			return false;
		if (hasPreviousPage != other.hasPreviousPage)
			return false;
		if (lastPageNum != other.lastPageNum)
			return false;
		if (lastRecordIndex != other.lastRecordIndex)
			return false;
		if (pageSize != other.pageSize)
			return false;
		if (totalPageCount != other.totalPageCount)
			return false;
		if (totalRecordCount != other.totalRecordCount)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "PaginationVo [currentPage=" + currentPage + ", countPerPage=" + countPerPage + ", pageSize=" + pageSize
				+ ", totalRecordCount=" + totalRecordCount + ", totalPageCount=" + totalPageCount + ", firstPageNum="
				+ firstPageNum + ", lastPageNum=" + lastPageNum + ", firstRecordIndex=" + firstRecordIndex
				+ ", lastRecordIndex=" + lastRecordIndex + ", hasPreviousPage=" + hasPreviousPage + ", hasNextPage="
				+ hasNextPage + "]";
	}
    
}
