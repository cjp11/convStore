package com.example.demo.member.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.demo.member.model.dao.MemberDao;
import com.example.demo.member.model.dto.MemberDetailsDto;

@Service
public class MemberDetailsService implements UserDetailsService {
	
	// 스프링 시큐리티 관련 클래스

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private MemberDao memberDao;
		
	@Override
	public MemberDetailsDto loadUserByUsername(String username) throws UsernameNotFoundException {
		
		logger.info("username = " + username);

		Map<String, Object> member = memberDao.selectConnectMember(username);
		logger.info(member.toString());
		
		if(member == null) {
			throw new UsernameNotFoundException(username);
		}
		
		List<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
		auth.add(new SimpleGrantedAuthority(member.get("AUTHORITY").toString()));
		
		return  new MemberDetailsDto(member.get("USERNAME").toString(), member.get("PASSWORD").toString(), true, true, true, true, auth,member.get("MEMBER_NAME").toString());
	}


}
