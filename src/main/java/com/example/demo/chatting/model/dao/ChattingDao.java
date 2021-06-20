package com.example.demo.chatting.model.dao;

import java.util.List;
import java.util.Map;

import com.example.demo.chatting.model.dto.ChattingDto;

public interface ChattingDao {

	List<ChattingDto> selectChattingList();

	int connectCount();

	int insertChat(ChattingDto chattingdto);

	int chatUpload(Map<String, String> map);

}
