package com.bit.fn.model.service.join;


import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.fn.model.mapper.join.MasteraccountAndCompanyInfoMapper;
import com.bit.fn.model.vo.join.MasteraccountAndCompanyInfoVo;


@Service
public class MasteraccountAndCompanyInfoService {
	@Autowired
	MasteraccountAndCompanyInfoMapper masteraccountAndCompanyInfoMapper;
	
	public MasteraccountAndCompanyInfoVo masterOne(String id){
		return masteraccountAndCompanyInfoMapper.masterOne(id);
	}
	
	
	public int updateInfo(String comName, String ceo, String manager, String comPhone, String id){
		return masteraccountAndCompanyInfoMapper.updateInfo(comName, ceo, manager, comPhone, id);
	}
	
	
}