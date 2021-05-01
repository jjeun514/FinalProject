package com.bit.fn.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.fn.model.service.OfficeService;
import com.bit.fn.model.vo.OfficeVo;

@Controller
@ComponentScan
public class SpaceMgmtController {
	@Autowired
	OfficeService officeService;
	List<OfficeVo> spaceInfo;
	
	@RequestMapping("/spaceMgmt")
	public String spaceMgmtGet(HttpServletRequest req) throws Exception {
		System.out.println("[SpaceMgmtController(spaceMgmtGet())]");
	// 공간 관리
		spaceInfo=officeService.spaceInfo();
		System.out.println("[SpaceMgmtController(spaceMgmtGet())] 공간: "+spaceInfo);
		req.setAttribute("spaceInfo", spaceInfo);
		
		return "spaceMgmt";
	}
}