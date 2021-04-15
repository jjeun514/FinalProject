package com.bit.fn.security.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

import lombok.Data;

@Entity
@Data
public class Role {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int num;
	
	//권한이름
	private String roleId; 
	
	@ManyToMany(mappedBy = "roles")
	private List<Account> accounts;
	
}
