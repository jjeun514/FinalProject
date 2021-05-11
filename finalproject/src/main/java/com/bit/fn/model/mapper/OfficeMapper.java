package com.bit.fn.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.bit.fn.model.vo.OfficeVo;


@Repository
@Mapper
public interface OfficeMapper {
	public List<OfficeVo> selectAll();
	public List<OfficeVo> selectPriceInfo();
	public List<OfficeVo> spaceInfo();
	public List<OfficeVo> officeDetail(String officeName);
	public int addSpaceInfo(int branchCode, int floorInput, int acreagesInput, int rentInput, String officeNameInput, int maxInput);
	public int selectOfficeNum(String officeName);
}