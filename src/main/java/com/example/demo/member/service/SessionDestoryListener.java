package com.example.demo.member.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.session.SessionDestroyedEvent;
import org.springframework.stereotype.Component;

import com.example.demo.member.model.dto.MemberDetailsDto;

@Component
public class SessionDestoryListener implements ApplicationListener<SessionDestroyedEvent> {
	
	// 스프링 시큐리티 관련 클래스

	private String nameSpace = "member.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public void onApplicationEvent(SessionDestroyedEvent event) {
		
		List<SecurityContext> contexts = event.getSecurityContexts();
        if (!contexts.isEmpty()) {
            for (SecurityContext ctx : contexts) {
                // 로그아웃 된 유저정보
                MemberDetailsDto memberDetaildto =  (MemberDetailsDto) ctx.getAuthentication().getPrincipal();               
  
                // 로그아웃  DB delete처리
                int result = sqlSession.delete(nameSpace + "deleteConnect", memberDetaildto.getUsername());
    
            }
        }
        System.out.println("삭제완료");
	}

}
