package com.bit.fn.model.mapper.join;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.BranchAndOfficeVo;


@Repository
@Mapper
public interface BranchAndOfficeAndCompanyInfoMapper {
	public List<BranchAndOfficeVo> officeCheck(String branchSelected, int floorSelected, String officeSelected);
	public List<BranchAndOfficeVo> AvailableOffice(String branchSelected, int floorSelected);
}