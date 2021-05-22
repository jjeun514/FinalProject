package com.bit.fn.model.service;

import java.util.Properties;
import java.util.Random;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.bit.fn.bean.EmailBean;
import com.bit.fn.security.model.Account;
@Service
@Component
@PropertySource("email.properties")
public class MailService {
	@Autowired
	JavaMailSender javaMailSender;
	
	@Autowired
	EmailBean emailBean;
	
	static String msg;
	public String code="";
	
	// 이메일 전송 (인증번호)
    public String sendMail(String to) throws MessagingException {
    	code=codeGenerator();
    	
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

	    Session session=Session.getInstance(props, new javax.mail.Authenticator() {
		       protected PasswordAuthentication getPasswordAuthentication() {  
		       return new PasswordAuthentication(emailBean.getFrom(), emailBean.getPass());  
		   }  
	    });  
	
	    Transport transport = session.getTransport();  
	    Message mimeMessage = new MimeMessage(session);
	    mimeMessage.setFrom(new InternetAddress(emailBean.getFrom()));
	    mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
	    mimeMessage.setSubject("[9 O' clock] 이메일 인증을 완료해주세요.");

	    MimeMultipart multipart = new MimeMultipart("related");
	    // 메일 본문
	    BodyPart messageBodyPart = new MimeBodyPart();
	    msg="<table style=\"width:80%; margin:0 auto; text-align:center;\">";
	    msg+="<tr><td>";
	    msg+="<div style=\"position:relative;\">";
	    msg+="<img src=\"cid:header\" style=\"width:700px;\"/>";
	    msg+="<div style=\"position:absolute;top:110px;width:100%;margin:0 auto;text-align:center;\">";
	    msg+="<h1>이메일 인증</h1>";
	    msg+="<p style=\"font-size:20px;\">회원 가입 페이지의 <b style='background-color:black;color:white;'>인증번호</b>란에 아래의 인증코드를 입력하여 이메일 인증을 완료해주세요.</p>";
	    msg+="<p style='font-size:13px;text-decoration:underlined'><strong>인증번호: ";
	    msg+=code+"</strong></p></div>";
	    msg+="<img src=\"cid:footer\" style=\"width:700px;\"/>";
	    msg+="</div></td></tr></table>";
	    messageBodyPart.setContent(msg, "text/html;charset=utf-8");
	    multipart.addBodyPart(messageBodyPart);
	    
	    // 이미지
	    messageBodyPart = new MimeBodyPart();
        DataSource fds = new FileDataSource("C:\\Users\\stxz\\Desktop\\FinalProject\\finalproject\\src\\main\\webapp\\imgs\\header.jpg");
        messageBodyPart.setFileName("header"); 
        messageBodyPart.setDataHandler(new DataHandler(fds));
        messageBodyPart.setHeader("Content-ID","<header>");
        multipart.addBodyPart(messageBodyPart);

        messageBodyPart = new MimeBodyPart();
        DataSource fds2 = new FileDataSource("C:\\Users\\stxz\\Desktop\\FinalProject\\finalproject\\src\\main\\webapp\\imgs\\footer.jpg");
        messageBodyPart.setFileName("footer"); 
        messageBodyPart.setDataHandler(new DataHandler(fds2));
        messageBodyPart.setHeader("Content-ID","<footer>");
        multipart.addBodyPart(messageBodyPart);
	    
        mimeMessage.setContent(multipart);
	    transport.connect();  
	    Transport.send(mimeMessage);
	    transport.close();
	    
	    return code;
    }
    
    // 인증코드 생성
	public String codeGenerator() {
		StringBuffer code=new StringBuffer();
		Random random=new Random();

		// 영문 대소문자+숫자 6자리
		for (int i=1; i<7; i++) {
			int index=random.nextInt(3);
			switch (index) {
				case 0:
					code.append((char)((int)(random.nextInt(26))+97));
					break;
				case 1:
					code.append((char)((int)(random.nextInt(26))+65));
					break;
				case 2:
					code.append((random.nextInt(10)));
					break;
			}
		}
		return code.toString();
	}
	
	// 입주 상담 신청서
	public void sendApplication(String to, String name, String company, String phone, String email, String crew, String budget, String message) throws MessagingException {
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
	    
	    Session session=Session.getInstance(props, new javax.mail.Authenticator() {
		       protected PasswordAuthentication getPasswordAuthentication() {  
		       return new PasswordAuthentication(emailBean.getFrom(), emailBean.getPass());  
		   }  
	    });
	    
	    Transport transport = session.getTransport();  
	    Message mimeMessage = new MimeMessage(session);
	    mimeMessage.setFrom(new InternetAddress(emailBean.getFrom()));
	    mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
	    mimeMessage.setSubject("[9 O' clock] 입주 상담 신청서가 도착했습니다.");
	    
	    MimeMultipart multipart = new MimeMultipart("related");
	    // 메일 본문
	    BodyPart messageBodyPart = new MimeBodyPart();
	    msg="<table style=\"width:80%; margin:0 auto; text-align:center;\">";
	    msg+="<tr><td>";
	    msg+="<div style=\"position:relative;\">";
	    msg+="<img src=\"cid:header\" style=\"width:700px;\"/>";
	    msg+="<div style=\"position:absolute;top:110px;width:100%;margin:0 auto;text-align:center;\">";
	    msg+="<h1>입주상담신청서</h1>";
	    msg+="<table style=\"width:75%;margin:0 auto;text-align:center;font-size:20px;\">";
	    msg+="<tr style=\"height:35px;\"><th style=\"text-align:left;border:0;width:120px;\">신청자: </th>";
	    msg+="<td style=\"text-align:left;width:30%;\">"+name+"</td>"
	    	+"<th style=\"text-align:left;border:0;\">연락처: </th>"
	    	+"<td style=\"text-align:left;width:30%;\">"+phone+"</td></tr>"
	    	+"<tr style=\"height:35px;\"><th style=\"text-align:left;border:0;width:120px;\">회사명: </th>"
	    	+"<td style=\"text-align:left;width:30%;\">"+company+"</td>"
	    	+"<th style=\"text-align:left;border:0;width:120px;\">이메일: </th>"
	    	+"<td style=\"text-align:left;width:30%;\">"+email+"</td></tr>"
	    	+"<tr style=\"height:35px;\"><th style=\"text-align:left;border:0;width:120px;\">예정 입주인원: </th>"
	    	+"<td style=\"text-align:left;width:30%;\">"+crew+"명</td>"
	    	+"<th style=\"text-align:left;border:0;width:120px;\">희망 금액대: </th>"
	    	+"<td style=\"text-align:left;width:30%;\">"+budget+"</td></tr>"
	    	+"<tr style=\"height:35px;\"><th style=\"text-align:left;border:0;width:120px;\">추가 메세지: </th>"
	    	+"<td colspan=\"3\" style=\"text-align:left;\">"+message+"</td></tr>"
	    	+"</table></div>"
	    	+"<img src=\"cid:footer\" style=\"width:700px;\"/>"
	    	+"</div>";
	    msg+="</td></tr></table>";
	    messageBodyPart.setContent(msg, "text/html;charset=utf-8");
	    multipart.addBodyPart(messageBodyPart);
	    
	    // 이미지
	    messageBodyPart = new MimeBodyPart();
        DataSource fds = new FileDataSource("C:\\Users\\stxz\\Desktop\\FinalProject\\finalproject\\src\\main\\webapp\\imgs\\header.jpg");
        messageBodyPart.setFileName("header"); 
        messageBodyPart.setDataHandler(new DataHandler(fds));
        messageBodyPart.setHeader("Content-ID","<header>");
        multipart.addBodyPart(messageBodyPart);

        messageBodyPart = new MimeBodyPart();
        DataSource fds2 = new FileDataSource("C:\\Users\\stxz\\Desktop\\FinalProject\\finalproject\\src\\main\\webapp\\imgs\\footer.jpg");
        messageBodyPart.setFileName("footer"); 
        messageBodyPart.setDataHandler(new DataHandler(fds2));
        messageBodyPart.setHeader("Content-ID","<footer>");
        multipart.addBodyPart(messageBodyPart);
	    
        mimeMessage.setContent(multipart);
	    transport.connect();  
	    Transport.send(mimeMessage);
	    transport.close();
    }
	
	// 마스터 계정 임시 비밀번호
	public String sendTmpPassword(Account account) throws MessagingException {
		String to=emailBean.email;
		String tempPassword=codeGenerator();
		
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
		
		Session session=Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {  
				return new PasswordAuthentication(emailBean.getFrom(), emailBean.getPass());  
			}  
		});
		
		Transport transport = session.getTransport();  
		Message mimeMessage = new MimeMessage(session);
		mimeMessage.setFrom(new InternetAddress(emailBean.getFrom()));
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
		mimeMessage.setSubject("[9 O' clock] 마스터계정 임시비밀번호 발급");
		
		MimeMultipart multipart = new MimeMultipart("related");
	    // 메일 본문
	    BodyPart messageBodyPart = new MimeBodyPart();
	    msg="<table style='width:80%; margin:0 auto; text-align:center;'>";
	    msg+="<tr><td>";
	    msg+="<div style='position:relative;'>";
	    msg+="<img src='cid:header' style='width:700px;'/>";
	    msg+="<div style='position:absolute;top:110px;width:100%;margin:0 auto;text-align:center;'>";
	    msg+="<h1>마스터계정 임시비밀번호</h1>";
	    msg+="<table style='margin:0 auto;text-align:center;font-size:20px;'>";
	    msg+="<tr style='height:35px;'><th style='text-align:left;border:0'>아이디: </th>";
	    msg+="<td style='text-align:left;'>"+account.getUsername()+"</td></tr>"
	    	+"<tr style='height:35px;'><th style='text-align:left;border:0;'>임시 비밀번호: </th>"
	    	+"<td style='text-align:left;'>"+tempPassword+"</td></tr>"
	    	+"</table></div>"
	    	+"<img src='cid:footer' style='width:700px;'/>"
	    	+"</div>";
	    msg+="</td></tr></table>";
	    messageBodyPart.setContent(msg, "text/html;charset=utf-8");
	    multipart.addBodyPart(messageBodyPart);
		
		// 이미지
	    messageBodyPart = new MimeBodyPart();
        DataSource fds = new FileDataSource("C:\\Users\\stxz\\Desktop\\FinalProject\\finalproject\\src\\main\\webapp\\imgs\\header.jpg");
        messageBodyPart.setFileName("header"); 
        messageBodyPart.setDataHandler(new DataHandler(fds));
        messageBodyPart.setHeader("Content-ID","<header>");
        multipart.addBodyPart(messageBodyPart);

        messageBodyPart = new MimeBodyPart();
        DataSource fds2 = new FileDataSource("C:\\Users\\stxz\\Desktop\\FinalProject\\finalproject\\src\\main\\webapp\\imgs\\footer.jpg");
        messageBodyPart.setFileName("footer"); 
        messageBodyPart.setDataHandler(new DataHandler(fds2));
        messageBodyPart.setHeader("Content-ID","<footer>");
        multipart.addBodyPart(messageBodyPart);
	    
        mimeMessage.setContent(multipart);
		transport.connect();  
		Transport.send(mimeMessage);
		transport.close();
		
		return tempPassword;
	}
	
	// 회의실 예약 확인 메일
		public String sendRemindReservation(String id, int roomNum, String memName, String useStartTime) throws MessagingException {
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
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(id));
			mimeMessage.setSubject("[9 o'clock] 회의실 예약 안내");
			
			// 메일 본문
			msg="<table width='90%' cellpadding='0' cellspacing='0' border='0' align='center' style='margin:0 auto;table-layout:fixed;border-collapse: collapse'>";
			msg+="<tbody>";
			msg+="<tr style='background-color: lightgray; text-align:center'>";
			msg+="<td width='100%' style='padding:40px;border-radius:10px;font-size:12px;'>";
			msg+="<font size=6><strong>9 o'Clock  회의실 예약 안내</strong></font>";
			msg+="<table style='padding-top:30px'>";
			msg+="<tr style = 'text-align:center'><td colspan='4' style = 'text-align:center;'>예약하신 회의실이 사용 시간이 30분 후에 시작됩니다.</td></tr>"
					+"<tr style = 'height: 40px;'></tr>"
					+"<tr><td style = 'width: 30%'></td><td style='background-color:white; width: 20%;'><b>회의실:</b></td><td>"+roomNum+"</td><td style='width: 30%'></td></tr>"
					+"<tr><td></td><td style='background-color:white; width: 20%;'><b>예약자명:</b></td><td>"+memName+"</td><td style='width: 30%'></td></tr>"
					+"<tr><td></td><td style='background-color:white; width: 20%;'><b>예약일시:</b></td><td>"+useStartTime+"시</td><td style='width: 30%'></td></tr>"
					+"</table>";
			msg+="</td>";
			msg+="</tr>";
			msg+="</tbody>";
			msg+="</table>";
			mimeMessage.setContent(msg, "text/html;charset=utf-8");
			
			// 메일 발송
			transport.connect();  
			Transport.send(mimeMessage);
			transport.close();
			
			return msg;
		}
}