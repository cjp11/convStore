package com.example.demo.chatting.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.example.demo.utill.EchoHandler;

public class WebSocketConfig implements WebSocketConfigurer  {

	@Autowired
	private EchoHandler echohandler;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// TODO Auto-generated method stub
		registry.addHandler(echohandler, "/echo").setAllowedOrigins("*").withSockJS();
		//registry.addHandler(echohandler, "/echo").addInterceptors(new HttpSessionHandshakeInterceptor());
		
	}
	
	@Bean
	public WebSocketHandler echohandler() {
		return new EchoHandler();
	}
		
}
