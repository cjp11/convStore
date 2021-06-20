package com.example.demo.chatting.service;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.chatting.model.dao.ChattingDao;
import com.example.demo.chatting.model.dao.ChattingDaoImpl;
import com.example.demo.chatting.model.dto.ChattingDto;

@Service
public class ChattingServiceImpl implements ChattingService {

	@Autowired
	private ChattingDao chattingDao = new ChattingDaoImpl();
	
	@Override
	public List<ChattingDto> selectChattingList() {
		return chattingDao.selectChattingList();
	}

	@Override
	public int connectCount() {
		return chattingDao.connectCount();
	}

	@Override
	public int insertChat(ChattingDto chattingdto) {
		return chattingDao.insertChat(chattingdto);
	}

	@Override
	public int chatUpload(Map<String, String> map) {
		return chattingDao.chatUpload(map);
	}

}
