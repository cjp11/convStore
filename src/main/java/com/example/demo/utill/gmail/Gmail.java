package com.example.demo.utill.gmail;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.activation.CommandMap;
import javax.activation.MailcapCommandMap;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.stereotype.Component;

public class Gmail {

	private String url;
	private String u_email;
	private String u_id;

	public Gmail() {
		super();
	}

	public Gmail(String url, String u_email, String u_id) {
		super();
		this.url = url;
		this.u_email = u_email;
		this.u_id = u_id;

	}

	private void send() throws AddressException, MessagingException {

		// gmail
		Properties props = new Properties();

		props.setProperty("mail.transport.protocol", "smtp");

		props.setProperty("mail.host", "smtp.gmail.com");

		props.put("mail.smtp.auth", "true");

		// gmail port = 465 or 587
		props.put("mail.smtp.port", "465");

		props.put("mail.smtp.socketFactory.port", "465");

		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		props.put("mail.smtp.socketFactory.fallback", "false");

		props.setProperty("mail.smtp.quitwait", "false");

		Authenticator auth = new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("oz.hj25@gmail.com", "nxjyapuzhbempwbo");

			}
		};

		Session session = Session.getDefaultInstance(props, auth);

		MimeMessage message = new MimeMessage(session);

		// message.setSender(new InternetAddress("redcandy8@gmail.com"));
		try {

			message.setFrom(new InternetAddress("oz.hj25@gmail.com", "HJ25", "utf-8"));

			message.setSubject("안녕하세요 테스트 메일 입니다");

			message.setRecipient(Message.RecipientType.TO, new InternetAddress(u_email));

			Multipart mp = new MimeMultipart();
			MimeBodyPart mbp1 = new MimeBodyPart();
			
			mbp1.setContent("<h2>안녕하세요, " + u_id + "님</h2>" + " <a>귀하의 비밀번호 변경요청에 대하여 링크를 보냅니다 </a><br>"
					+ "<a>아래 링크로 가셔서 비밀번호를 변경해주시기바랍니다</a> <br>"
					+ "<span style='color: red;'>이메일 발송후 30분만 변경이 가능하오니 만약 시간이 지나셨다면 다시 비밀번호 찾기를 해주시기바랍니다</span><br>"
					+ "URL : <a href='http://192.168.3.98:8787/hj25/userPwUpdateFrom.jsp?url="+url+"'>비밀번호 변경하러가기</a>", "text/html; charset=utf-8");
			mp.addBodyPart(mbp1);

			MailcapCommandMap mc = (MailcapCommandMap) CommandMap.getDefaultCommandMap();
			mc.addMailcap("text/html;; x-java-content-handler=com.sun.mail.handlers.text_html");
			mc.addMailcap("text/xml;; x-java-content-handler=com.sun.mail.handlers.text_xml");
			mc.addMailcap("text/plain;; x-java-content-handler=com.sun.mail.handlers.text_plain");
			mc.addMailcap("multipart/*;; x-java-content-handler=com.sun.mail.handlers.multipart_mixed");
			mc.addMailcap("message/rfc822;; x-java-content-handler=com.sun.mail.handlers.message_rfc822");
			CommandMap.setDefaultCommandMap(mc);

			message.setContent(mp);

			Transport.send(message);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

	}

	@SuppressWarnings("finally")
	public boolean sendId(String url, String u_email, String u_id) {
		Gmail mail = new Gmail(url, u_email, u_id);
		boolean TF = false;
		try {
			mail.send();
			TF = true;
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		} finally {
			return TF;
		}
	}

}