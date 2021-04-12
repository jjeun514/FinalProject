package com.example.demo;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.demo.test.service.TestService;

@SpringBootTest
class SpringSecurityApplicationTests {
	@Autowired
	TestService testService;
	
	@Test
	void contextLoads() {
		assertNotNull(testService.selectTest());
		System.out.println(testService.selectTest());
	}

}
