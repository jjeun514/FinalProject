package com.bit.fn.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.bit.fn.security.model.Account;
import com.bit.fn.security.model.Role;
import com.bit.fn.security.repository.AccountRepository;

@Service
public class AccountService {
	@Autowired
	private AccountRepository accountRepository;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	public Account save(Account account) {
		String encodedPassword = passwordEncoder.encode(account.getPassword());
		account.setEnabled(true);
		Role role = new Role();
		role.setNum(11);
		account.getRoles().add(role);
		return accountRepository.save(account);
	}
}
