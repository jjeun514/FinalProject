package com.bit.fn.config;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import com.bit.fn.bean.EmailBean;
@Configuration
@PropertySource("email.properties")
public class MailConfig {
	@Autowired
	EmailBean emailBean;
	
	@Bean
	public JavaMailSender getMailSender() {
		JavaMailSenderImpl mailSender=new JavaMailSenderImpl();
		mailSender.setUsername(emailBean.getUser());
		mailSender.setPassword(emailBean.getPass());
		mailSender.setHost(emailBean.getHost());
		mailSender.setJavaMailProperties(getMailProperties());
		mailSender.setDefaultEncoding("UTF-8");
		return mailSender;
	}

	private Properties getMailProperties() {
		Properties properties = new Properties();
		// 이메일 발송을 처리해줄 STMP 서버
		properties.setProperty("mail.smtp.host", emailBean.getHost());
		// SMTP 서버와 통신하는 포트 (Gmail은 465)
		properties.setProperty("mail.smtp.port", emailBean.getPort());
		properties.setProperty("mail.smtp.starttls.enable", emailBean.getStarttlsEnable());
		properties.setProperty("mail.smtp.starttls.required", emailBean.getStarttlsRequired());
		properties.setProperty("mail.smtp.ssl.trust", emailBean.getSslTrust());
		properties.setProperty("mail.smtp.ssl.enable", emailBean.getSslEnable());
		properties.setProperty("mail.smtp.auth", emailBean.getAuth());
		properties.setProperty("mail.smtp.socketFactory.port", emailBean.getSocketFactoryPort());
		properties.setProperty("mail.smtp.socketFactory.fallback", emailBean.getFallback());
		properties.setProperty("mail.smtp.socketFactory.class", emailBean.getSocketFactory());
		return properties;
	}
}