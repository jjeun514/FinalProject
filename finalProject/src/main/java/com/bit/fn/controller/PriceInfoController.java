package com.bit.fn.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bit.fn.model.service.OfficeService;

@Controller
@ComponentScan
public class PriceInfoController {
	@Autowired
	OfficeService officeService;
	
	@RequestMapping("/priceInfo")
	public String priceInfoGet(HttpServletRequest req) {
		System.out.println("[PriceInfoController(priceInfoGet()]");
		req.setAttribute("priceItems",officeService.selectPriceInfo());
		return "priceInfo";
	}
}