package com.bit.fn.security.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bit.fn.security.model.Account;

public interface AccountRepository extends JpaRepository<Account, Integer>{
	

}
