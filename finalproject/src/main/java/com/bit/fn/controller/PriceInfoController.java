package com.bit.fn.controller;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bit.fn.model.service.MailService;
import com.bit.fn.model.service.OfficeService;

@Controller
@ComponentScan
public class PriceInfoController {
	@Autowired
	OfficeService officeService;
	@Autowired
	MailService mailService;
	
	String to="project210413@gmail.com";
	
	@RequestMapping("/priceInfo")
	public String priceInfoGet(HttpServletRequest req) {
		System.out.println("[PriceInfoController(priceInfoGet()]");
		req.setAttribute("priceItems",officeService.selectPriceInfo());
		return "priceInfo";
	}
	
	@RequestMapping(path="/priceInfo", method = RequestMethod.POST)
	public String priceInfoPost(String name, String company, String phone, String email, String crew, String budget, String msg) throws MessagingException {
		System.out.println("[PriceInfoController(priceInfoPost()]");
		mailService.sendApplication(to, name, company, phone, email, crew, budget, msg);
		return "priceInfo";
	}
}