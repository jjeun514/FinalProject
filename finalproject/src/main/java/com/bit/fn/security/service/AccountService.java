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
	
	//어드민 회원가입
	public Account adminSave(Account account) {
		//패스워드 단방향 암호화 설정
		String encodedPassword = passwordEncoder.encode(account.getPassword());
		account.setPassword(encodedPassword);
		
		//enabled 사용가능 컬럼 1 반영i
		account.setEnabled(true);
		
		//권한 구분 1(어드민) 설정
		Role role = new Role();
		role.setNum(1);
		account.getRoles().add(role);
		
		//설정한 값으로 MariaDB 값 저장(회원가입)
		return accountRepository.save(account);
	}
	
	//마스터 회원가입
	public Account masterSave(Account account) {
		//패스워드 단방향 암호화 설정
		String encodedPassword = passwordEncoder.encode(account.getPassword());
		account.setPassword(encodedPassword);
		
		//enabled 사용가능 컬럼 1 반영i
		account.setEnabled(true);
		
		//권한 구분 1(어드민) 설정
		Role role = new Role();
		role.setNum(2);
		account.getRoles().add(role);
		
		//설정한 값으로 MariaDB 값 저장(회원가입)
		return accountRepository.save(account);
	}
	
	//멤버 회원가입
	public Account memverSave(Account account) {
		//패스워드 단방향 암호화 설정
		String encodedPassword = passwordEncoder.encode(account.getPassword());
		account.setPassword(encodedPassword);
		
		//enabled 사용가능 컬럼 1 반영i
		account.setEnabled(true);
		
		//권한 구분 1(어드민) 설정
		Role role = new Role();
		role.setNum(3);
		account.getRoles().add(role);
		
		//설정한 값으로 MariaDB 값 저장(회원가입)
		return accountRepository.save(account);
	}
	
}