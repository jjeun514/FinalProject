package com.bit.fp;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.bit.fp.model.mapper.BoardMapper;
import com.bit.fp.model.service.AdminAccountService;
import com.bit.fp.model.service.BoardService;

@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class Finalproject2ApplicationTests {
	@Autowired
	AdminAccountService adminAccountService;
	
	@Autowired
	BoardService boardService;
	
	@Order(1)
	@Test
	void contextLoads() {
		assertNotNull(adminAccountService);
		assertNotNull(boardService);
	}
	
	@Order(2)
	@Test
	void selectAll() {
		assertNotNull(adminAccountService.selectAll());
		assertNotNull(boardService.selectAll());
	}

}
