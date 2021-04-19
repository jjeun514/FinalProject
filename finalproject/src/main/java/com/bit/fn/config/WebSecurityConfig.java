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
			//로그인 인증 없어도 접근 가능한 영역(이미지,css파일 영억은 main에서부터 시작한다)
				.antMatchers("/","/resource/**","/home","/index","/join","/resister","/jungbok"
						,"/bbs","/detail","/index","/mypage","/signUp","/test,/test/info"
						,"/imgs/**","/libs/**"
						).permitAll()
			//어드민 계정만 접근 가능
				.antMatchers("/user").hasRole("ADMIN")
			//그 외 모든 요청은 인증된 사용자만 접근이 가능하다
				.anyRequest().authenticated()
				.and()
			.formLogin()
			//로그인 페이지 설정
				.loginPage("/login")
			//로그인 성공시 이동 경로
				.defaultSuccessUrl("/index",true)
				.permitAll()
				.and()
			.logout()
				//로그아웃 경로
				.logoutUrl("/logout")
				.logoutSuccessUrl("/index")
				.permitAll();
	}

@Autowired
public void configureGlobal(AuthenticationManagerBuilder auth) 
  throws Exception {
    auth.jdbcAuthentication()
      //데이타 소스 연결
      .dataSource(dataSource)	
      //비밀번호 암호화 반영
      .passwordEncoder(passwordEncoder())
      //인증처리
      .usersByUsernameQuery("select username,password,enabled "
      		+ "from account "
      		+ "WHERE username = ?")
      //권한처리
      .authoritiesByUsernameQuery("select a.username, r.authority "
        + "from accountrole ar inner join account a on ar.account_num = a.num "
        + "inner join role r on ar.role_num = r.num "
        + "where a.username = ?");
}	

//Authentication = 로그인
//Authorization = 권한

	
@Bean
public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
}


}