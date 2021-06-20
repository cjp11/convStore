package com.example.demo.member.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.example.demo.member.model.dto.MemberDetailsDto;

public class MemberAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	
	// 스프링 시큐리티 관련 클래스

	private String nameSpace = "member.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		MemberDetailsDto member = (MemberDetailsDto) authentication.getPrincipal();
		
		int result = sqlSession.insert(nameSpace + "connectMember", member);	
		System.out.println("auth = " + authentication);	
		System.out.println("session = " + request.getSession().getId());
		
		response.sendRedirect("/demo"); // 패기지 이름명으로 ???

	}

}