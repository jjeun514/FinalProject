package com.bit.fn.model.mapper.join;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.join.BranchAndOfficeVo;


@Repository
@Mapper
public interface BranchAndOfficeMapper {
	public List<BranchAndOfficeVo> duplicationCheck(String branchInput, int floorInput, String officeNameInput);
	public int selectOfficeNum(String branchInput, int floorInput, String officeNameInput);
}