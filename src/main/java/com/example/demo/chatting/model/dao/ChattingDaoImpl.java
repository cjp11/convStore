package com.example.demo.chatting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.chatting.model.dto.ChattingDto;

@Repository
public class ChattingDaoImpl implements ChattingDao {

	private String nameSpace = "chatting."; 
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<ChattingDto> selectChattingList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(nameSpace + "selectChattingList");
	}

	@Override
	public int connectCount() {
		return sqlSession.selectOne(nameSpace + "connectCount");
	}

	@Override
	public int insertChat(ChattingDto chattingdto) {
		return sqlSession.insert(nameSpace + "insertChat", chattingdto);
	}

	@Override
	public int chatUpload(Map<String, String> map) {
		return sqlSession.insert(nameSpace + "chatUpload", map);
	}

}
