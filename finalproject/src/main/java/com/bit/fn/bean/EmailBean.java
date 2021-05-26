package com.bit.fn.bean;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

@Component
@PropertySource("email.properties")
public class EmailBean {
	@Value("${mail.transport.protocol}")
	public String protocol;

	@Value("${mail.smtp.host}")
	public String host;
	
	@Value("${mail.smtp.port}")
	public String port;
	
	@Value("${mail.smtp.auth}")
	public String auth;
		
	
	@Value("${mail.smtp.email}")
	public String email;
	
	@Value("${mail.smtp.user}")
	public String user;

	@Value("${mail.smtp.pass}")
	public String pass;
	
	@Value("${mail.smtp.email}")
	public String from;
		
	@Value("${mail.smtp.starttls.required}")
	public String starttlsRequired;
		
	@Value("${mail.smtp.starttls.enable}")
	public String starttlsEnable;
	
	@Value("${mail.smtp.socketFactory.port}")
	public String socketFactoryPort;
	
	@Value("${mail.smtp.socketFactory.fallback}")
	public String fallback;
	
	@Value("${mail.smtp.socketFactory.class}")
	public String socketFactory;
	
	@Value("${mail.smtp.ssl.trust}")
	public String sslTrust;
		
	@Value("${mail.smtp.ssl.enable}")
	public String sslEnable;
	
	@Value("${mail.debug}")
	public String debug;
	
	public EmailBean() {}

	public EmailBean(String protocol, String host, String port, String auth, String email, String user, String pass,
			String from, String starttlsRequired, String starttlsEnable, String socketFactoryPort, String fallback,
			String socketFactory, String sslTrust, String sslEnable, String debug) {
		super();
		this.protocol = protocol;
		this.host = host;
		this.port = port;
		this.auth = auth;
		this.email = email;
		this.user = user;
		this.pass = pass;
		this.from = from;
		this.starttlsRequired = starttlsRequired;
		this.starttlsEnable = starttlsEnable;
		this.socketFactoryPort = socketFactoryPort;
		this.fallback = fallback;
		this.socketFactory = socketFactory;
		this.sslTrust = sslTrust;
		this.sslEnable = sslEnable;
		this.debug = debug;
	}

	public String getProtocol() {
		return protocol;
	}

	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUser() {
		return user;
	}

	public String getDebug() {
		return debug;
	}

	public void setDebug(String debug) {
		this.debug = debug;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getStarttlsRequired() {
		return starttlsRequired;
	}

	public void setStarttlsRequired(String starttlsRequired) {
		this.starttlsRequired = starttlsRequired;
	}

	public String getStarttlsEnable() {
		return starttlsEnable;
	}

	public void setStarttlsEnable(String starttlsEnable) {
		this.starttlsEnable = starttlsEnable;
	}

	public String getSocketFactoryPort() {
		return socketFactoryPort;
	}

	public void setSocketFactoryPort(String socketFactoryPort) {
		this.socketFactoryPort = socketFactoryPort;
	}

	public String getFallback() {
		return fallback;
	}

	public void setFallback(String fallback) {
		this.fallback = fallback;
	}

	public String getSocketFactory() {
		return socketFactory;
	}

	public void setSocketFactory(String socketFactory) {
		this.socketFactory = socketFactory;
	}

	public String getSslTrust() {
		return sslTrust;
	}

	public void setSslTrust(String sslTrust) {
		this.sslTrust = sslTrust;
	}

	public String getSslEnable() {
		return sslEnable;
	}

	public void setSslEnable(String sslEnable) {
		this.sslEnable = sslEnable;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((auth == null) ? 0 : auth.hashCode());
		result = prime * result + ((debug == null) ? 0 : debug.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((fallback == null) ? 0 : fallback.hashCode());
		result = prime * result + ((from == null) ? 0 : from.hashCode());
		result = prime * result + ((host == null) ? 0 : host.hashCode());
		result = prime * result + ((pass == null) ? 0 : pass.hashCode());
		result = prime * result + ((port == null) ? 0 : port.hashCode());
		result = prime * result + ((protocol == null) ? 0 : protocol.hashCode());
		result = prime * result + ((socketFactory == null) ? 0 : socketFactory.hashCode());
		result = prime * result + ((socketFactoryPort == null) ? 0 : socketFactoryPort.hashCode());
		result = prime * result + ((sslEnable == null) ? 0 : sslEnable.hashCode());
		result = prime * result + ((sslTrust == null) ? 0 : sslTrust.hashCode());
		result = prime * result + ((starttlsEnable == null) ? 0 : starttlsEnable.hashCode());
		result = prime * result + ((starttlsRequired == null) ? 0 : starttlsRequired.hashCode());
		result = prime * result + ((user == null) ? 0 : user.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		EmailBean other = (EmailBean) obj;
		if (auth == null) {
			if (other.auth != null)
				return false;
		} else if (!auth.equals(other.auth))
			return false;
		if (debug == null) {
			if (other.debug != null)
				return false;
		} else if (!debug.equals(other.debug))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (fallback == null) {
			if (other.fallback != null)
				return false;
		} else if (!fallback.equals(other.fallback))
			return false;
		if (from == null) {
			if (other.from != null)
				return false;
		} else if (!from.equals(other.from))
			return false;
		if (host == null) {
			if (other.host != null)
				return false;
		} else if (!host.equals(other.host))
			return false;
		if (pass == null) {
			if (other.pass != null)
				return false;
		} else if (!pass.equals(other.pass))
			return false;
		if (port == null) {
			if (other.port != null)
				return false;
		} else if (!port.equals(other.port))
			return false;
		if (protocol == null) {
			if (other.protocol != null)
				return false;
		} else if (!protocol.equals(other.protocol))
			return false;
		if (socketFactory == null) {
			if (other.socketFactory != null)
				return false;
		} else if (!socketFactory.equals(other.socketFactory))
			return false;
		if (socketFactoryPort == null) {
			if (other.socketFactoryPort != null)
				return false;
		} else if (!socketFactoryPort.equals(other.socketFactoryPort))
			return false;
		if (sslEnable == null) {
			if (other.sslEnable != null)
				return false;
		} else if (!sslEnable.equals(other.sslEnable))
			return false;
		if (sslTrust == null) {
			if (other.sslTrust != null)
				return false;
		} else if (!sslTrust.equals(other.sslTrust))
			return false;
		if (starttlsEnable == null) {
			if (other.starttlsEnable != null)
				return false;
		} else if (!starttlsEnable.equals(other.starttlsEnable))
			return false;
		if (starttlsRequired == null) {
			if (other.starttlsRequired != null)
				return false;
		} else if (!starttlsRequired.equals(other.starttlsRequired))
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "EmailBean [protocol=" + protocol + ", host=" + host + ", port=" + port + ", auth=" + auth + ", email="
				+ email + ", user=" + user + ", pass=" + pass + ", from=" + from + ", starttlsRequired="
				+ starttlsRequired + ", starttlsEnable=" + starttlsEnable + ", socketFactoryPort=" + socketFactoryPort
				+ ", fallback=" + fallback + ", socketFactory=" + socketFactory + ", sslTrust=" + sslTrust
				+ ", sslEnable=" + sslEnable + ", debug=" + debug + "]";
	}
}