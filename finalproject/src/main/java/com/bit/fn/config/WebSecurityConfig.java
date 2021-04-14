package com.bit.fn.config;

import javax.sql.DataSource;

import org.apache.tomcat.util.http.parser.Authorization;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private DataSource dataSource;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.authorizeRequests()
			//로그인 인증 없어도 접근 가능한 영역
				.antMatchers("/", "/home","/index","/join").permitAll()
				.anyRequest().authenticated()
				.and()
			.formLogin()
			//로그인 없이 접근 시 이동하는 경로
				.loginPage("/login")
				.permitAll()
				.and()
			.logout()
			//로그아웃은 누구나 가능하다
				.permitAll();
	}

@Autowired
public void configureGlobal(AuthenticationManagerBuilder auth) 
  throws Exception {
    auth.jdbcAuthentication()
      .dataSource(dataSource)
      //비밀번호 암호화 반영
      .passwordEncoder(passwordEncoder())
      //인증처리
      .usersByUsernameQuery("select id,password,enabled "
      		+ "from account "
      		+ "WHERE id = ? "
      		)
      //권한처리
      .authoritiesByUsernameQuery("select id,roleId "
        + "from accountrole ar inner join account a on ar.accountNum = a.num "
        + "inner join role r on ar.roleNum = r.num"
        + "where id = ?");
}	

//Authentication = 로그인
//Authorization = 권한

	
@Bean
public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
}


}