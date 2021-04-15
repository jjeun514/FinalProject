package com.bit.fn.security.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Entity
@Data
public class Account {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int num;
	
	private String id;
	private String password;
	private Boolean enabled;
	
	@ManyToMany
	@JoinTable(
			name = "accountrole",
			joinColumns= @JoinColumn(name = "accountnum"),
			inverseJoinColumns = @JoinColumn(name = "rolenum"))
	private List<Role> roles = new ArrayList<Role>();

}
