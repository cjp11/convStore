package com.example.demo.utill;

import java.io.UnsupportedEncodingException; 
import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MailHandler {
//	private Logger logger=LoggerFactory.getLogger(getClass());
//    private JavaMailSender mailSender;
//    private MimeMessage message;
//    private MimeMessageHelper messageHelper;
//    
//    @RequestMapping("/common/util/sendmail.do")
//    @ResponseBody
//    public int sendEmail(@RequestParam String email) {
//    	System.out.println("email=" + email);
//    	logger.info("1단계 도착");
//    	
//    	int a = 0;
//    	String rndnum=randomNum();
//    	System.out.println("랜덤넘버 = " + rndnum);
//    	sendEmail("@naver.com", rndnum);
//    	return Integer.parseInt(rndnum);
//    }
//    
//    private String randomNum() {
//        StringBuffer buffer = new StringBuffer();
//            
//        for( int i = 0 ; i <= 6 ; i++) {
//            int n = (int)(Math.random() * 10);
//            buffer.append(n);
//        }
//            
//        return buffer.toString();
//    }
//     
//    public void sendEmail(String email, String authNum ) {
//        
//    	System.out.println("이메일 = " + email + "인증번호" + authNum);
//        SimpleMailMessage mailMessage = new SimpleMailMessage();
//        
//        mailMessage.setSubject("회원가입 안내 .[이메일 제목]");
//        mailMessage.setFrom("@naver.com");
//        mailMessage.setText("[이메일 내용]회원가입을 환영합니다. 인증번호를 확인해주세요. [ " + authNum + " ]");
//        mailMessage.setTo(email);
//        
//        System.out.println("메일내용" + mailMessage);
//        
//        try {
//            mailSender.send(mailMessage);
//        } catch (Exception e) {
//            System.out.println(e);
//            e.printStackTrace();
//        }
//    }
}
