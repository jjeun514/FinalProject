package com.bit.fn.model.service;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.bit.fn.bean.EmailBean;
@Service
@Component
@PropertySource("email.properties")
public class MailService {
	Logger logger=LoggerFactory.getLogger(MailService.class);
	
	@Autowired
	JavaMailSender javaMailSender;
	
	@Autowired
	EmailBean emailBean;

	static String msg;
	public String code="";
	
    public String sendMail(String to) throws MessagingException {
    	System.out.println("[MailService] sendMail()");
    	// 메일 보내기 전에 인증번호 생성
    	code=codeGenerator();
    	System.out.println("[MailService] code: "+code);
    	System.out.println("[MailService] from: "+emailBean.getFrom());
    	// 회원가입 페이지의 emailInput값 받아와야함
    	System.out.println("[MailService] to: "+to);
    	// properties 설정
	    Properties props = new Properties();  
	    props.setProperty("mail.transport.protocol", emailBean.getProtocol());
	    props.setProperty("mail.host", emailBean.getHost());
	    
	    props.put("mail.smtp.auth", emailBean.getAuth());  
	    props.put("mail.smtp.port", emailBean.getPort());  
	    props.put("mail.smtp.host", emailBean.getHost());
	    
        props.put("mail.smtp.ssl.enable", emailBean.getSslEnable());
        props.put("mail.smtp.ssl.trust", emailBean.getSslTrust());
        
	    props.put("mail.smtp.socketFactory.port", emailBean.getSocketFactoryPort());  
	    props.put("mail.smtp.socketFactory.class", emailBean.getSocketFactory());  
	    props.put("mail.smtp.socketFactory.fallback", emailBean.getFallback());
	    
	    props.put("mail.debug", emailBean.getDebug());

	    // 메일 세션
	    Session session=Session.getInstance(props, new javax.mail.Authenticator() {
		       protected PasswordAuthentication getPasswordAuthentication() {  
		       return new PasswordAuthentication(emailBean.getFrom(), emailBean.getPass());  
		   }  
	    });  
	
	    Transport transport = session.getTransport();  
	    Message mimeMessage = new MimeMessage(session);
	    mimeMessage.setFrom(new InternetAddress(emailBean.getFrom()));
	    mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
	    mimeMessage.setSubject("[9'o clock] 이메일 인증을 완료해주세요.");

	    // 메일 본문
	    msg="<table width='90%' cellpadding='0' cellspacing='0' border='0' align='center' style='margin:0 auto;table-layout:fixed;border-collapse: collapse'>";
	    msg+="<tbody>";
	    msg+="<tr style='background-color:#e2e4f3;text-align:center'>";
	    msg+="<td width='100%' style='padding:40px;border-radius:10px;font-size:12px;'>";
	    msg+="<font size=6><strong>9'o Clock 이메일 인증</strong></font>";
	    msg+="<p style='padding-top:30px'>회원 가입 페이지의 <b style='color:darkblue'>인증번호</b>란에 아래의 인증코드를 입력하여 이메일 인증을 완료해주세요.</p>";
	    msg+="<p style='font-size:13px;text-decoration:underlined'><strong>인증번호: ";
	    msg+=code+"</strong></p>";
	    msg+="</td>";
	    msg+="</tr>";
	    msg+="</tbody>";
	    msg+="</table>";
	    System.out.println("[MailService] msg: "+msg);
	    mimeMessage.setContent(msg, "text/html;charset=utf-8");
	    
	    // 메일 발송
	    transport.connect();  
	    Transport.send(mimeMessage);
	    transport.close();
	    
	    return code;
    }
    
//	인증코드 생성
	public String codeGenerator() {
		System.out.println("[MailService] codeGenerator()");
		StringBuffer code=new StringBuffer();
		Random random=new Random();

		// 6자리
		for (int i=1; i<7; i++) {
		System.out.println("[MailService] i: "+i);
			// 3개의 랜덤 수를 뽑아서, 영문 대소문자+숫자 섞어주자
			int index=random.nextInt(3);
			System.out.println("[MailService] index(3개의 랜덤 수): "+index);
			switch (index) {
				// 1이 나오면
				case 0:
					// 알파벳 A~Z 총 26개+97을 char로 변환하면 랜덤한 영문 소문자
					code.append((char)((int)(random.nextInt(26))+97));
					break;
				// 2가 나오면
				case 1:
					// 알파벳 A~Z 총 26개+65를 char로 변환하면 랜덤한 영문 대문자
					code.append((char)((int)(random.nextInt(26))+65));
					break;
				// 3이 나오면
				case 2:
					// 0~9 사이의 랜덤 값으로 바꾸기
					code.append((random.nextInt(10)));
					break;
			}
			// 이렇게 총 6자리수를 뽑아냄 (영문 대소문자+숫자 섞어서)
			System.out.println("[MailService] code(for문 안): "+code);
		}
		System.out.println("[MailService] codeGenerator() - code: "+code.toString());
		return code.toString();
	}
}