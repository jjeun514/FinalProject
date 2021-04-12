package com.bit.nam;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.bit.nam.model.service.DeptService;

@SpringBootTest
class NamApplicationTests {
	@Autowired
	DeptService deptService;
	
	@Test
	void contextLoads() {
		assertNotNull(deptService);
		System.out.println(deptService.selectAll());
	}

}
